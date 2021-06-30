Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF7EC11F67
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 02:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1818861864
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 02:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1818861864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B906F6E0D4;
	Wed, 30 Jun 2021 02:09:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4896E0D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 02:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naTmMT6JUWuoJqMgDa7/o5N/uOrO+Nas9McVT3qFEMF1P3x/httIgnOKDryf+gjefMgTjJQydT+sHgX5MH2JQxED4e2GkCCvhZHoDVVynTj/slBe8NxGcDM8deIboeggLZ5y5RbxFL808HKuVMe3sd+wYJQTjVkKvvQGMBLrny2QP5bJrNva4HMmHvvOe7tMd5E5rFQJGRFA4YFpbmVbLOd9mOfkfgaCNEvmw+Uc1cEMShNo/G7VOPvY2zc91+MCm3F+teWMyMFTSHAD+RlmyRYHPZYOEcyqe2U6GKNIbeH7OFLO8tXLFFVCJptzFzQk9SZKWEdetAZGD/mKr927aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTZuhSKz53DpZJDQJiURjVayPPPH/yPBu0RSBDfKsWY=;
 b=Usri2U42buRO5f0BnctFuA8rH+0Mvwcbt3hrJzVy4O81c0owrj+lMMr+C0w+Lp1pQLDChU8tSTOy5g1B+bZqRp/YJoyWn+GNP4zyRHyQwXU3RES2vEPJWb/CI6vnUkdmhkVLiizrvTfduFN/Om5yqm47pwhzpItVOPFvXYyYdHEeY3HzSaPJIypl099W0JsMAgoJ7kLxcGubc+K4Se4vmRsqwW8hWXjxZ0POsf5aVSoLQKIkcrfN/VXgYbFXwT8HqJueoR4QoVVKEgJa6wHLQ7DFN5BvD7q/jb+OPcvmtdHvqBgqdB1ahOF0JrJEo5hBpeuH6w9+kyZ3S/8tx4xGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTZuhSKz53DpZJDQJiURjVayPPPH/yPBu0RSBDfKsWY=;
 b=3HepF0z6JjPlj92NwJY+aJ4ypqboLx9YHWCrTpLpm6rc9rw1F6KVOvFI+qs0GAr0CmEk8M8xAG+3iaR4QdqgHIXDaYX1Y0ku2d6SAX2RhBPgmrEoUw+tY4xyRvKlO7H58JgAvBl1dAi+Bp2B70nQb5psBZnlpjd0YvO2Sv9EIhQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1128.namprd12.prod.outlook.com (2603:10b6:903:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 02:09:20 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 02:09:20 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add new dimgrey cavefish DID
Thread-Topic: [PATCH] drm/amdgpu: add new dimgrey cavefish DID
Thread-Index: AQHXbSBfrKndypP1LEGhhdYf2WgDJasrz33Q
Date: Wed, 30 Jun 2021 02:09:20 +0000
Message-ID: <CY4PR12MB1287FBD23831DBDCC2F15536F1019@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210629195236.326722-1-alexander.deucher@amd.com>
In-Reply-To: <20210629195236.326722-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-30T02:09:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d14e6dda-9534-45ae-a2e3-73a84f6aa89c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d474d2f6-edc5-4b7b-8512-08d93b6c12a2
x-ms-traffictypediagnostic: CY4PR12MB1128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1128246F21DAB48BDA5ED255F1019@CY4PR12MB1128.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:147;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CM58KoqYAipDGQSsd6bhqL6Ui8LqBBrbWPkywmYH0AsIIwrunlXPmey3SdaKIRJnjzT68QXmTdOEP9pmNJ8cDnoGU6D8pFXBpVsKVtVlX89OUkU+B2pSTSZ9SCKrnZr+S1SReFdsThjLKgxwrXNpCxs/dSK8ixWyjWw8B79eBNHnkcfM6VeA+nd4vHNct3tIEObUgWz+6GH4NOKW1ODWdGh36vxzm6xr3aYvPyKrwyahZLQDXoYaC0+IwAJqqncfKX7TGXLq/cWAmEOuXe6V5GFZv3TduZ5Kqecp92KGJH+QruDG6LOjNxumcjS3B2gIBSUBchTpANscbgoKKJz29WU35HNQnuzbAE/JhR3Sba9TAL4BnIcni8WaarjH/rBSBs24Ejjz6wFRUDqkUqG9c3J+lX1CZUzl1m4xt9N9kLiFa8Gao/sLJz02uargDR6aOAHQ1ZyRrO2kSW+2dad04sWJkwUE51QC9g+8t6XZ5ryFz3DhjTavek2CgzPrEZuEOd0lc6rb0R5jy7ntVN+ygOM0Qg4wtO9H+gG1V5wYe0jKiYX8Wrr6zFzTqLPrLkN1DZv1xawm5+/nbCcX8rQ58oCbsAJtSedO8ZIraU6dkMfu2q8rFJK0zifLv0v7XJGzLsmlh93lwPntmNDCWVZz7OH1TEXW9eS80Uq63LszWn53zyKH/jug7N7bniB+AOf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(6506007)(53546011)(26005)(186003)(83380400001)(86362001)(7696005)(122000001)(66556008)(71200400001)(4326008)(38100700002)(66476007)(66946007)(76116006)(5660300002)(64756008)(66446008)(33656002)(966005)(110136005)(52536014)(316002)(55016002)(2906002)(45080400002)(478600001)(8936002)(8676002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0upN0H5Ta6nVw2bNVvCjkAwLfZWAQfcp0n4VgBf8tJ4HQMOoY2Ez2PAihU1F?=
 =?us-ascii?Q?XEtlw4nhVJJ9/vAv0Tj7o14zPFJQdeBaRbCrxa2nSLi/tSzBCA9iSSgTC++3?=
 =?us-ascii?Q?RKA7ljJUErSu+YHsV3fseHjFa6hN8PU0ykh2G95V7qXk6WbYHKsY/8xW1i/B?=
 =?us-ascii?Q?fqcQfRgt/ZQAkFUcv/ePW/fycv4XT9qwqQm/ZgIOxGwOsXr7ud3UzCDfbR0V?=
 =?us-ascii?Q?n4XVtcRYsnECqqcSQB7kCVAHkFh2Ci1Eaf1ivi9GqNiLLSFVUpk23NKsAXpI?=
 =?us-ascii?Q?edXzlN58vqGkVZJUIwjj489nQbCVswUmILTb9ofd00CwPWd2Bg5eiJwVCNZw?=
 =?us-ascii?Q?CaR5F8wZIOq2+2xCX3IVcC/VUSd1PCInGlaQFnU+2kYofs8Khz+TlYEcBqmm?=
 =?us-ascii?Q?dGWEissKfqQicxA+ZkBtZS2j9j4pllMwEStg88tsdRK1Ho2BRWrxF4I9Y35l?=
 =?us-ascii?Q?eJOUXQZ8RQCv9WSkYPgwLGU/fS6iTIEqZO/0vNMh/8qOJCbjhT1kPGzw+Ute?=
 =?us-ascii?Q?hmh1IWScZRRJAUiq70Yl5l1a27gvU+2y/uyxJcxYHm5fiYRj1PHjraGXUnPJ?=
 =?us-ascii?Q?QtsZOcmLOvWeNTuLRXAh7fYoQbHfOxqzWYG9J5/UvX9H6lU93CieeVpzV1b1?=
 =?us-ascii?Q?jXm3GEnkZX9Ua0qRKn5QiAFgksB2uyoHuJdmWwYa56Wm8hfVzLBEawmi0mPG?=
 =?us-ascii?Q?/F4sMfy+8WdMVBxUqOnXVbyAN5cQDgY6e/1sFFO1AUIwWkCeyBos4WC494Yu?=
 =?us-ascii?Q?zzNid0oIBNqWIWvXsLY7ARxEFjtKUztB1oVF/DUa4tsUeQs+EgqZaog7cq22?=
 =?us-ascii?Q?8GeyzQH7hfDUYRFYj8edfNuROTt6EEHSgzaErQX0AAIWzYHisE1eJ0mYk05V?=
 =?us-ascii?Q?nRNSATxNeLK9mowuAlGvcyWwXwQFkNCrk78veyvNZsS3yPDNp1m0myZpEKPI?=
 =?us-ascii?Q?LWSMaDAO5JWJnrc8oMX080f2DAUX0bH+gYL2mlFOuGkj4YiOOmDVOu2S+Xje?=
 =?us-ascii?Q?oMh3M+pxb9+rBN02+1J2DuYd3SuW4Zx7LsTq5uKdr+kKCR15xDRZreigJ2eQ?=
 =?us-ascii?Q?j3Li2uH9XtJYRZ87GZAoVuYlSIM7xglTlNfFoE3w1xfcvax9Hh8Rp5EdrpDd?=
 =?us-ascii?Q?15TP4xhdZP3aGh3KDRndi1eo+ESnw6QUIHl1u2FC+9mNwYJXu/2z+iX/UEFq?=
 =?us-ascii?Q?w28TF0VILj7UJr2sGzZ3UXiQlzDHBtTGDZEZDPsUa/jUqoa4q8mV7f27gk0b?=
 =?us-ascii?Q?Zco9JWQsr6ooJ0cNFbY/LE0BeKIgu+kp+6XPCLERfDYgY1GNzIOf2CUxhaxM?=
 =?us-ascii?Q?3wETYccstfcMJBC7k6+YWAei?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d474d2f6-edc5-4b7b-8512-08d93b6c12a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 02:09:20.3823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXnb0ehDEymcDy1ONDN9C5DZGWiQArkKLVNkL0ALPTv0hrzAb382OGLyNiHzwVyb4b0iGN5s+2RPE6ytqrYedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1128
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, June 30, 2021 3:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add new dimgrey cavefish DID

Add new PCI device id.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1a110b06cb6e..6419d75f1f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1198,6 +1198,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73E0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73E1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73E2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73E3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 
 	/* Aldebaran */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cf8b42ee8ab8c4345d05c08d93b37805b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637605931833229462%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8vr6oKTDlmF24Sy8Le6XIAp3OCizTtr5NXUec9jLodE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
