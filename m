Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2866C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 05:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87147613DB
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 05:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87147613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCF86EB4D;
	Fri, 23 Apr 2021 05:24:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2DA6EB46
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 05:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMuCkS1+fcOkl9+qfbitfCPR7YtFMgxCqj5SjBA+9EfknIN38p3sO8P1sIRlo2aTztwt57S+J3C9aqB6D2qZ1LA66ZUUYLBOQG3D7qvXOEXKZNrGd7FSgAVpXYJXOebvphLFNGCvMpqItgz7iu4VpLuaBuzY6qAANvtsSnCGtaw5+SDJ4RzK1sD52Bgxq7uY1IXa0RBIm9V46RdONKinzinvt50+TwitD/MRLjT+uP/HM9eF194ONeRT75d3rbe6hH0Zo2p9I0/9GcVnAsSf9jh7FyVnDvGyCSbJ816HafOpn9f+Lv201EnsKNMO9XUNf2VK0KyMQ9Hty+CvvRDe2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8rKs1fa/fJMNDxeJ74cYCNNLJvZ5Cr0GrZ7W7CLKxA=;
 b=gmLM/9dZZ698a5ReU/KOlCPQKXIKb4BhJ3GQRDKQDQajmp7XzHKO7jIpkQmotlPp0FffrBs5l8XtvyXP9OPMd6ufZkMaBt77PQDiRbWA1iCZxuPWzuTYU8lJGBgCBZAcPJpoaZm7nyCgwVCGGhkLQ7ibohvvpr/Zg+xXaJ/65JX9fyIqtbXwmnFF+jFZLiKvnHhmOjRX8K+8/lYcAbMizLTse0Inj0ql8fdvQejmEiRyYG+CqIbnNmijz76XmeGVtT+/eOGIE/4QY/EZ3ljdjuVGBnyXIkY+LmU/8bk9CpqY85VXHfFuqHAtYWc6ZjS8Z8pVA2Atq/X41PpFE1KRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8rKs1fa/fJMNDxeJ74cYCNNLJvZ5Cr0GrZ7W7CLKxA=;
 b=fGi6gKL2txaxLMF6SsUM9I57PrBqjdbGpb9+aNp87wBzfOt3DcuxU1zLSWH4wf8IA7AGQfl6LgsxI+PmOuFZKqUQ5qCIa1h6WQQf2yB4ERKHhRT5EiWSn4YyREc0TxliNu6SxSW2mOcKkqrqpWQ2p8QJKxbgYAdw9mzWFI+1Q0g=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB3047.namprd12.prod.outlook.com (2603:10b6:a03:d9::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 05:24:17 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::445a:a6bb:4c3f:b565]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::445a:a6bb:4c3f:b565%7]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 05:24:17 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 0/3] Prevent set of DCEFCLK on smu_v11 gpus
Thread-Topic: [PATCH v2 0/3] Prevent set of DCEFCLK on smu_v11 gpus
Thread-Index: AQHXN+/0jubtJXutKE2NJ4U5sx2CQqrBkahw
Date: Fri, 23 Apr 2021 05:24:16 +0000
Message-ID: <BYAPR12MB36409F6F860250596BD7EC678E459@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210423032236.6379-1-darren.powell@amd.com>
In-Reply-To: <20210423032236.6379-1-darren.powell@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-23T05:24:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6fc80a16-99cd-4f51-8f1b-b64c433cfa24;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cd78c33-9fd3-4c85-ad33-08d906180a4e
x-ms-traffictypediagnostic: BYAPR12MB3047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30472156A82D46D6323256D98E459@BYAPR12MB3047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:139;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EcK/iLrjIKamw5IfpX6mINczx1bXsxhNXXcHg9WtprqpZ8EihpXpeLAcc/VYrXEx8DXb0i/a2WO27eo5jOC8CdXU+AmqdCB9gT/3GqQxiFOqixdwAkq3afOsvPZq/J+m6Y1Y/thPIBBDd+aOgWeJ8gsxNUaSq7Y+fH+UrvsfWmmZhc9Qlsv6PntQLlxIxLTdeQRwEUYBVQtMVNN5r2jqFM3AYSUTHRifcLxrSEdpy6uG2CAjhPW/UowaDw30ZvQOyKGdE37pXxPO+sk3miQWv3tv80oA/G8W0KJuw+tqgHoyYuunpauRGg/IW68pmgbKu9Cwk6811oLZpM8REKcrnKGDLGkgnyIAinaxyYRBHRAJWZAojmhBJHViifGOlroukoyyLPJ5Mnlqq8iMZEy928CXP55tD6PaUeZlAzO1xe8EW9IH14qJnfaf3u8pkoNnZ8K8voI6lESe6nFipd5PwuGjcqvEmiap4CgTKf+WRSw1R5BeA/4Cl07DrgjoZiHu8bJ/Ihz+qHr5rrBsKNC4HNiKQjNsYKnKUigxFUSiEl9hiVeUdjBuOMgmJK9ld/lseKqlgDH39kzeSKmnFzkzA00kxWC6TP5DgDOJedZ9opc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(5660300002)(53546011)(186003)(33656002)(316002)(110136005)(6506007)(55016002)(86362001)(66556008)(8936002)(478600001)(9686003)(2906002)(38100700002)(8676002)(66476007)(64756008)(71200400001)(52536014)(7696005)(83380400001)(66446008)(26005)(66946007)(122000001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MbW1Ljp959/om9zXrjeV9vUqF40yJqGkeHaLGhu44Umx2s8X0/EYU1na1ibP?=
 =?us-ascii?Q?OYCJv99dh5P5T+PzLEdf1L80ci+/p2Ca/supiJWEw+Si4bCcmABpiyyie8kQ?=
 =?us-ascii?Q?5haYFJMhpv9cWPvC42dLihLTqcCkyhutET/SBtvGB0KX2X40BLXVGXkKsxl3?=
 =?us-ascii?Q?344HSch3heHVqvYrpWyYXsuWLvt5+kiQEWJVUoH0Zvm6nFIAb9IehW0n9d0w?=
 =?us-ascii?Q?ABj4p9qylf4KWJM7xnfDOO/gWQnfKaHMAZ9lnhWeipjqc3QPOuNnT5OLhoua?=
 =?us-ascii?Q?Y8OGY3Gpi5FOIAAnq22B/mljhwUpA/T4x8x6YdEP9vy49CgSpvXj1FdIkki3?=
 =?us-ascii?Q?nqFMlJz8Lv2AUXhjbgcDADVRDb6yB7QGwMxFpdVFqmavRel8ZC3IFkbNu2zg?=
 =?us-ascii?Q?bHDJhRL9TdlaqKgLcpwUD+PUb6t9dWy4O6ACeUFWsjJYuNAGBDQHr46hU8We?=
 =?us-ascii?Q?3xjO2nA+6+tZJvr7w1AuTII7CPhwbqqhjze7T7Yw0Y84MW41RCqfef4z8Vos?=
 =?us-ascii?Q?NmE7nu2N8EylaLY+SmbYduG2LzBee9B9+wh8l16bmAape7LnjmvsdyY9M1Xx?=
 =?us-ascii?Q?IpLxbOM/bezrhKJywdEplfru5+xKXdN1HRfLF2pFYICTOR/jFh73hTrIaKoG?=
 =?us-ascii?Q?MVEPF3B5AyYDizWfJRghrz8d1uauBJH1gHc14VBuyJaNIT05S+Le0K29MwBZ?=
 =?us-ascii?Q?YQBfP+H5USUJM1mPmEEE5BbvlHApyKKFePv7V0pRQKea7jw6swPycBhR80bt?=
 =?us-ascii?Q?D0ndhOcuNDLLZJYoda/gbJlHExKoJRBYn4H1X8qnhiJxVBug7Q3yCMSB6frd?=
 =?us-ascii?Q?A8IPp1usavO2vstOJ8h0AyjO7AQ1ByzHxQZTI1LCX0wEg/ni6vPU5NRlm+dw?=
 =?us-ascii?Q?0J/B7KLnlzNDo0/I4fL8ilyXMlPMKU6JmwHRJgq/tDdx8DTxs5dtN/0bo5yM?=
 =?us-ascii?Q?wQ6/P9CaLWzmDdtC48eG9yF9uy/me0SERe1mx7sy3t1ZJpNPs7baQexMUnJd?=
 =?us-ascii?Q?Hx9dXt++L+0Dxn1Za0A7ZmKB3wgnq3YN64Dc4IsH5a30knk9hOXD2kwUZ8Hm?=
 =?us-ascii?Q?NxU0+lNoa9+5xWlr/6wNSNhXo1jtlSXDWG5zBZyYnf0PN6Lll9Hnjqzx5PkK?=
 =?us-ascii?Q?V/o2LhXJGn9kWPaaLVoB+kQx5tCiEWgc6XpPEgN4Ml2g7OAC3Q+2RLyxxYF+?=
 =?us-ascii?Q?CBWBPWtx2tpxuMJE6l3XOJvOK+g1u/POcz9F5u/36ODVbOpN7w2qs/EczFIb?=
 =?us-ascii?Q?xTNyl4e2N+czyoCKWw/P/Pn83lUYdivAQPIY00ktrPsGEXsUm+4rmdYATruO?=
 =?us-ascii?Q?W+/xij0QktlIYll244t++OPJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd78c33-9fd3-4c85-ad33-08d906180a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 05:24:16.8067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2rZTjlec9VkmCp8iY1NNkaqrOZaNk2PpFQmymlGvGIb0AUAFnsBtAUqA8lnDQNb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3047
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series are Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Powell, Darren <Darren.Powell@amd.com> 
Sent: Friday, April 23, 2021 11:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH v2 0/3] Prevent set of DCEFCLK on smu_v11 gpus

=== Description ===
Set of simple patches to prevent attempts to set dcefclk on NAVI10

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)  + ISO(Ubuntu 20.04.1 LTS)  + Kernel(5.11.0-custom-amdinternal-dirty)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ b54280b32ebb
    + 599f1ebb60cc  amdgpu/pm: add extra info to SMU msg pre-check failed message
    + 291dcf836f45  amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and SIENNA_CICHLID
    + c8ce10fc1d99  amdgpu/pm: set pp_dpm_dcefclk to readonly on NAVI10 and newer gpus

=== Tests ===
General Test Sequence
---------------------
* monitor dmesg output in a shell
  dmesg -w

* launch a root shell
  sudo bash

* set control to manual
  cd /sys/class/drm/card0/device
  echo manual > power_dpm_force_performance_level

* next step is expected to crash the GPU in unpatched and with patch 0001
** system usually continues operation so you can reboot gracefully

* TEST 1: modify pp_dpm_dcefclk to each level (0,1,2) and read setting after each write
  echo "1" > pp_dpm_dcefclk ; sleep 2 ; echo " ---set 1---" ; cat  pp_dpm_dcefclk ;\
  echo "2" > pp_dpm_dcefclk ; sleep 2 ; echo " ---set 2---" ; cat  pp_dpm_dcefclk ;\
  echo "0" > pp_dpm_dcefclk ; sleep 2 ; echo " ---set 0---" ; cat  pp_dpm_dcefclk
** example output
  [   74.493190] amdgpu 0000:03:00.0: amdgpu: failed send message: SetSoftMaxByFreq (27)  param: 0x000504f2 response 0xff
  [   76.497102] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   76.497114] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [   76.497649] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   78.501229] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   78.501241] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [   78.501766] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   80.505401] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   80.505414] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!

* TEST 2:
   ls -la  /sys/class/drm/card0/device/pp_dpm_dcefclk
** example output
  -rw-r--r-- 1 root root 4096 Apr  7 18:33 /sys/class/drm/card0/device/pp_dpm_dcefclk

* POST TEST
** restore dpm clock to auto
  echo auto > power_dpm_force_performance_level


Test Results
------------
* 0001 amdgpu/pm: add extra info to SMU msg pre-check failed message
** TEST 1 dmesg output
  [  101.414826] amdgpu 0000:03:00.0: amdgpu: failed send message: SetSoftMaxByFreq (27) 	param: 0x000504f2 response 0xff
  [  103.418916] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  103.418930] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [  103.419474] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  105.423226] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  105.423239] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [  105.423649] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  107.427502] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  107.427516] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!

* 0002  amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and SIENNA_CICHLID
** GPU remains operational after test
** TEST 1 dmesg output
  [  263.087136] amdgpu 0000:03:00.0: amdgpu: Setting DCEFCLK min/max dpm level is not supported!
  [  265.092026] amdgpu 0000:03:00.0: amdgpu: Setting DCEFCLK min/max dpm level is not supported!
  [  267.096648] amdgpu 0000:03:00.0: amdgpu: Setting DCEFCLK min/max dpm level is not supported!

* 0003  amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11 gpus
** TEST 2 shell output
  bash: pp_dpm_dcefclk: Permission denied
   ---set 1---
  0: 506Mhz *
  1: 886Mhz 
  2: 1266Mhz 
  bash: pp_dpm_dcefclk: Permission denied
   ---set 2---
  0: 506Mhz *
  1: 886Mhz 
  2: 1266Mhz 
  bash: pp_dpm_dcefclk: Permission denied
   ---set 0---
  0: 506Mhz *
  1: 886Mhz 
  2: 1266Mhz 

Darren Powell (3):
  amdgpu/pm: add extra info to SMU msg pre-check failed message
  amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and SIENNA_CICHLID
  amdgpu/pm: set pp_dpm_dcefclk to readonly on NAVI10 and newer gpus

 drivers/gpu/drm/amd/pm/amdgpu_pm.c                      | 8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
 4 files changed, 17 insertions(+), 4 deletions(-)


base-commit: b54280b32ebb9381e045e645eabd99dbbe607ec2
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
