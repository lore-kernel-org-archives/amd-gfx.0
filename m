Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F8C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC246145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC246145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C098D6ED8E;
	Thu, 29 Apr 2021 07:55:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9BD6ED8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtvoP92+uceUXeKXWVnDduqJkDQWeaYwHShonlHz8gO5zBdZ++bz9WjpRwk7uGimjna0lidUAd6q74BlYqczEKJmczBz2n1QOugshUDdgHRNUQaSSACNTk4tn4dF/2uv7+LF1DWe8Qeznar2Hd/c/Ld5gngY7h+mhQ5X0cUCFM7nV7x6fDvk6ft51u/i4BZLUd7NyOFc3MrlltQrGgkYduNxmJ6JY498EFe6V0xcAumimSKSQ2jSdPb8t93vfmVDb4Chbgsg0WRMPAkZDaTflaHB4eU9xg+I8z3JDBSi3yYIy30ZSSqKfTG+klupeOyh7TdEokREQHJ4tXlcokCeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijP/fOVPi4Ya60rc5KHVkyaVr9P8UzvL8EO5zaXAUj4=;
 b=kri+awSOIXAUan7tbkUknV+iecqekMnlTNCXunGZ7j/T8uLWEtXfeuNF26KiO0wxgfctyF17f6rGApkS+eabRDGf2+/dB925+zQ1r9t4ysdF0WXJ92jKgh16r91Wy4Fa4L3u8xx3g4afalQik1LEKcXzL2mZbrdbj5IRfcg138Uk+tky2tC4tUFks549v+lUx9M9FuxoIqP3/tZh7QXJfterfTYUp6kG5RMdbH6p2/LdIKGAi3iDuVnFyUqy/ibtosDW5zeUyjau58p4vEJYyXyIPVwlV1/lNJuxsNnKKbys+3m/iwVT+0dDT4Ma9d5zfkVJ3KBfsO/ngEr3pa//DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijP/fOVPi4Ya60rc5KHVkyaVr9P8UzvL8EO5zaXAUj4=;
 b=YeYqYaq7DT6duIu1b3U3eP+I+ty/UOtxNb5QBBvzleIm+Ap6+PxYg62KPg/lUE7FzBdYSQFP3mrl+ibhpSTdWgx/7Vm8q0RTy8EetDkhVCv1P5lDqYUJzMn2wSC3WAFcASFb30pPXk9ySJqIvN9ynzvAmQIZYxgBEFEOwfspKYA=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR12MB1526.namprd12.prod.outlook.com
 (2603:10b6:910:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 07:55:42 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 07:55:35 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: switch to mmhub ras callback for ras fini
Thread-Topic: [PATCH] drm/amdgpu: switch to mmhub ras callback for ras fini
Thread-Index: AQHXPMCs7KHlrXc7h0WYMy/LQG+tVKrLIIjA
Date: Thu, 29 Apr 2021 07:55:35 +0000
Message-ID: <CY4PR1201MB0072B4897164A81ADD6A19CFFB5F9@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <1619677619-2735-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677619-2735-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T07:55:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b5982143-cf2f-4b62-b1c5-7c7a8dfa66bc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:38a:845b:7000:43a:f4aa:d777:f395]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a4c9dd-3baf-4467-7a81-08d90ae42c31
x-ms-traffictypediagnostic: CY4PR12MB1526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB152607C7BFBE60BD2052986CFB5F9@CY4PR12MB1526.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWI+MdTP771n0EpaCw/thIyvD2D2VYhlPhydUue5dzxNX2Q1ijIFJz23F55eQO9agrh7kJhGFuuufhVrtgT/yjXrm8rjo47EF1StfFfWzcQodbYI1nKPkQMyoo6h28x7nsCvzX6V8ZzmDHCTbXowv11QW6QJUZxr31dje6k5G9wfVCwa4tVDeQlXCiruDyUoc0lWWFg4E75WUkT3wkFmeZfSfCIiJZ+kMv4piUI3n4RbFT9LyNSuyh/m9ufm13nnOcZnodotARF2x5iNsjtek8KTYlacdBv15ahEablZnPi+LcFY+mxj0BcJ9CrnA4D9OFmvAd/RMH/5Ww4Ndfic9aHE6HvfY2M/PtvwnKw6eEh83FgW7A+xxkERrE229JAO8Motc/FESRxOC5Bj6ZCpC1x6nlgmpW/6YZz+sfSppU0SYguocC/ITgaKyCwonj0fBd0zmlYbjUMiAq+iEnzJNrxOebtQxyYYPq+d40G5qV8v/fdqmlC7pPDZBzFujgVbMBfyzzOk60VN2s6Bmpq92yJNjSmvfkZyZNgE1FTC3BsiWATvbeoRETKD0n6S6rgSUtFK2LY00yNpBnwD1vmXfgZKuVrmFPoh81jag/iIp0A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(38100700002)(5660300002)(55016002)(478600001)(53546011)(122000001)(52536014)(6506007)(9686003)(71200400001)(7696005)(2906002)(76116006)(86362001)(83380400001)(8676002)(33656002)(66446008)(186003)(66946007)(64756008)(316002)(8936002)(66476007)(4326008)(110136005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TIZtLsEQpnQQMsNKY2WOkBrmvUw467MbCS65s2qmCfkk7YJ1MLi4kqlDs7kB?=
 =?us-ascii?Q?A9j99T4Q0HJzww2+FQlS3CwbuE1ns2JOdhrPl+J+irvrNWMjX27/2e9+VroN?=
 =?us-ascii?Q?zJYSLfVjgczcFJBs/yF5Toc3MW9HXrxfXFx32mnGaCwytZ/zIhxZv6VhWGu3?=
 =?us-ascii?Q?dKWUKYegGzBCn4z+0TXm3bSz/be0E07Ekpi7KViTx64a+kaVKiK+24vwxETO?=
 =?us-ascii?Q?fNT9Lyd83VFWNlHYwXU/JyaafF6drQ716VjFdUv4iCWZAipzWleWAUt3T9rV?=
 =?us-ascii?Q?4fi/VYWt656+4u7HXo1sYAxie6PbEmRCUrN721QFruiET5muAVzSMkQ87B0o?=
 =?us-ascii?Q?Zq/5+M4wHRsFppUYrqyS4B+kBA78viIoK1z0ajsmjIdEy3kgFe7t5MqTy2IO?=
 =?us-ascii?Q?di/JACVSET2T+r2aqydstfIjHo05uWVRzP3BbZp2yv16Ri26epJZZSjOL+ox?=
 =?us-ascii?Q?SLPb9xXBbepuu/F9Mpc24/d26+8i1+Kn6HSJAzEfa1NB5ZDa1yh4HP8WTJ1x?=
 =?us-ascii?Q?6kTnHt0NIhQayTGqpPDtfB9M5ZUx9v13aqORUiEXrJB7WzCoqKd6ZFViUVK0?=
 =?us-ascii?Q?bLVZrfn7k31NbgVTcEVCrFUXBs+OOdzteyo/cOhb1FVVDU05Ewrbk3PF+hTE?=
 =?us-ascii?Q?/q56yOrY8MVlhcpwwAkEPsJW9gGPgBO05IcqF+PmZXDxbBdjzTT45u4gCM/A?=
 =?us-ascii?Q?lXx2unWSoXXgUHudCtLY7vMCXpe+zfeEG700fibZtw22+n2XA44FJPpHfepG?=
 =?us-ascii?Q?IrmHdGTC/bEtctp48rcLqJKeVNEvXcHya7vloxkTPbUx16pTYYrMRd/zqNnf?=
 =?us-ascii?Q?4Lssk/v8W5XO0e82GePD7nFCwnTrPQwXQHysh5Xbcb9nRQ1P3xLhxcxVUAf3?=
 =?us-ascii?Q?BlKnQWvffI1WM+/2JXQg74e4JYTPi0pLcZbFcVWajF4COuaH41GJwgz6HxHB?=
 =?us-ascii?Q?f2lpAVOxuZ0MtUkb/QqbEbM8K0ZAGlI1uxScAqsu9VzoyEYwGQQA20QNzrgK?=
 =?us-ascii?Q?os6zxH0xXWmfIqcv0GeO29x+zDkoAVHXQEXkS+6Hcc6hVPhQrDbH4wOggR6Y?=
 =?us-ascii?Q?wJxRxlJs8py4Eu1HyX+oWV2iHgJ6vEHQKT7j/eMFR36pKkmQ1qOqdnnmXkZQ?=
 =?us-ascii?Q?q+AryUtBMUl235jmgDfpdpOVodwCIGXqTuTdYLjLS1srXO11KBH3uNsNflMH?=
 =?us-ascii?Q?aQnTQ5//kfkIy23Abrl17XHN+0Vx1fzfCTPOSi1z4EnkdRiS7hrzod0FxXyz?=
 =?us-ascii?Q?oRONrmQSYhXFejO7urfajKqW+KNFaeQg5u2PlBWajj7L5zetvXq6Mq2yYj1C?=
 =?us-ascii?Q?Bc9L16iYMvqV0retVwuUJwzWwwQhM7Gnkea5l9/BoYZLyBRehCWBYahauL2y?=
 =?us-ascii?Q?JubC/7RNgArT1WyVjfA7SU7e4GpU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a4c9dd-3baf-4467-7a81-08d90ae42c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 07:55:35.8168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUDCyujtG/7Gs8J7/bPmp3wJO2yv2ObVFtR3Iflrr7wU+kHIzlum8jnsYtbH5MqVj3wD3Q4sPCxNGZ3zyDzcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1526
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:27 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: switch to mmhub ras callback for ras fini

invoke callback function for mmhub ras fini

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 697ab26..a129ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -473,7 +473,7 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 
 	if (adev->mmhub.ras_funcs &&
 	    adev->mmhub.ras_funcs->ras_fini)
-		amdgpu_mmhub_ras_fini(adev);
+		adev->mmhub.ras_funcs->ras_fini(adev);
 
 	if (adev->gmc.xgmi.ras_funcs &&
 	    adev->gmc.xgmi.ras_funcs->ras_fini)
-- 
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
