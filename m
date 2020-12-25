Return-Path: <SRS0=eRNB=F5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A7C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 04:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEB2230FA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 04:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEB2230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3B389B06;
	Fri, 25 Dec 2020 04:20:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444B889B18
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Dec 2020 04:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUjObc+hv8wKau25vzcNIuShO14YiPNkx/Ym7OQteP6cjmgTuBciDNWZwki0Fg+n8nypIOmjuppw4yskbdYxMKMpyCXaD4eReQWPLvPlt2e6c6ySgD5gu3wCp8NggP15M+HbQLTnVS+zcCdF9r0QX+8xFWn0M/IuZnAQ1CS355RDdsX6NKTI/TQTCMRcwIKM14EqxTYiAza6drOXCtuCqacbxycuXOI1CTAN2QgWbAgcxjkNxSi9dNG2BT0wnuhZPLPuFoD93orXOMr7UE8rpl8rmXZSqmEyyZJgOfoh7+UK6KSubBa+MG0fQnSqiN3Y5rcrpdlZIGcWpXfegmNQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1bJKsOYCDrvyftQuxKBqU0HANyMo0XZ2CX/7zFqtFc=;
 b=ZzVLMWOFaXOv5y6gNlpNJCaCcMO79BHcBRn07JOuSNhSIQ/ezW/YF0gIN7OvojMwZsZcy88ezVHsV687CvOI5JQXqJk37Li/6cH+5W8Jn5Z7nDuiar9MozBCdfzfnxuGpm60mjRVPugG3pzxuKP3qmOeGiT4oJeTgmT98CeOApUqxKCSqoIKLLLVud34QC/ya57IT0w9C7AuTeHrp7V60LEnPo55aipc6eo93L9uSszwqVO59llawdBN3Ck/5pri0HpdKpHy7B6y0+xmFQUE//e3gtUM2j1wdJprrg0z/1aSgVEyjwWPJd0lQvLPcFMBqe9FbviNhUBJG2C42cUvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1bJKsOYCDrvyftQuxKBqU0HANyMo0XZ2CX/7zFqtFc=;
 b=Tu/Ex5wKcwdcgPKHOZgcnLPChhCgwBTmUqZUCW3s3atI6p95fhgaAu0BxxiVEmCvpQntja9AkbXWdcfg61vG37VkCdaFqmZqgnDlIoFUxkcXqQHkhBCwAR3eGsuBH+VJXmaI9DVyo/Yo9hDEXawqCcZmRub1S7bgSSt9wcx1/3c=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.30; Fri, 25 Dec
 2020 04:20:17 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%6]) with mapi id 15.20.3676.034; Fri, 25 Dec 2020
 04:20:17 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
Thread-Topic: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
Thread-Index: AQHW2brIoij0wk4HnUine7fBFS1UhqoHNwWg
Date: Fri, 25 Dec 2020 04:20:17 +0000
Message-ID: <BY5PR12MB4115A0AD3C9AEE4A5A155F808FDC0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20201224060434.18144-1-PengJu.Zhou@amd.com>
In-Reply-To: <20201224060434.18144-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e210860a-192a-4a3a-b116-971d5bbafaac;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-25T04:20:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bebe74b-d805-44c4-483d-08d8a88c6281
x-ms-traffictypediagnostic: BY5PR12MB4115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4115FCC23E16E0AC13B5EBD48FDC0@BY5PR12MB4115.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMtRGXvdySgzvLHoph++8YcEoEJBZWCr0qnIlcYLkATAdlEyHqa3+zWollkbsUhGb2F7cCM00IIf3sgHeTLh28BR3CsHfuOjNcDgJFPzFlo8vUAS11DCb5EGFQ2zbJoejRXOTdz+cdfN9tMJlUfIX/B2g7I9TQGGj0KdlCsLFTcQ/QhV44sNyiZRA85u3NmHRMwNyc9onOSvJ+zGRa4RFlfB9TU/BnUOF+tt9JdGWjZarfDkdwUtzLrD3YrapEva+jxy+icTTRuFx5s17WYsV4s2IVbUsNJa9ZfpK8C+FODwKO847kfmftv2X7DHbe1lvEm/NTSasRAr2vIM9ABADNoDxx3oFznl5Kg9JPG6yM5PxPwBTCn57KisBUrcFI9VkieBr/8uFAziN0DcQ2PhrsZA8j6VQIMznfY+MRwMn5hKXPtoVJEqmwAr/RxGxbWjdwgbdBEmABjv0RsMg0lBpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(76116006)(66476007)(478600001)(8676002)(55016002)(2906002)(7696005)(6506007)(45080400002)(8936002)(5660300002)(71200400001)(26005)(66556008)(66446008)(33656002)(186003)(66946007)(64756008)(110136005)(316002)(9686003)(83380400001)(86362001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LZ2y6pS4YGsBtck57TaLgy8CGmhUFhivJ+jvL5s/n6GEImR41VOdxFlqzkti?=
 =?us-ascii?Q?nkZJRe++U3fqdSl8a36ZScdZd29g8zb3ZIjtnugUFgENj/x+MpEJ4LUwYszN?=
 =?us-ascii?Q?lAB4R1OHAj0NCBb6R2l1LadYvo6JJJN1SG8lHck/IT+9/d9WTbDeXk3X9rJL?=
 =?us-ascii?Q?w+L/+Qbm07HMh8To8VotrNnC9itZCHo2tHPScV/2dSZYKUX2z5UkXAhEU9X6?=
 =?us-ascii?Q?4M5Y79bXLjjuanMAjpL9KrOlLLsFswm5nXtt0mWOA5seoXdESp6tbkneRQiM?=
 =?us-ascii?Q?rFFu49U9MEbHOV5D1EAYjbIt7FH0tLDky/WN1Z4VEj5VZI6/Z7WOmMlkdw2G?=
 =?us-ascii?Q?YJtmExmLzAbrOPx6Vp4mRFMb/441O7ST74+Xj24w5iy9BmJGJeXCKOGFUVvq?=
 =?us-ascii?Q?mMjyul4a4hGFXk83nSjS5t5clw/EXfCcOhnCTWAH5TlG8hs/xE2poBNKUmyG?=
 =?us-ascii?Q?tINlhXmXT7jdKLc7Jsfzou3SjYL13sRp/NB+eUiv+xIBWttr8lxmOoB/mb41?=
 =?us-ascii?Q?Ha5G1/nBfwHwNn2JuexUaib8exCyjyuZq4HaD/oVN0Nl8xhLfXrCELQ7FVDT?=
 =?us-ascii?Q?8Bo7hUsYk29nQtieY+O73B9SMyW3oODGkG5O+wRi1JkxNwWk1DGvVBcsreA/?=
 =?us-ascii?Q?3lRgUukFFXf5f7CGj5hPcgRtYZ1QzNk4l9kuPSUK7H/8/y9qa7+Wt6qHgHsP?=
 =?us-ascii?Q?1Pa6//RJdRoJOw564Kl4+WSZjbOCSvX15/VPNIv+fNKL+LM3Jz8DqeXUk8xf?=
 =?us-ascii?Q?nXSEkcnB9jgdj5jYf12/RpZuSS6xbOqbovoaZeSVJBzsTcxDKRVIX+SsHNLM?=
 =?us-ascii?Q?a6jJsm+t2sKNcnIJlWK4uHD5b1g59p6988dU/jrY/ah1rn54GTWImccCQSx4?=
 =?us-ascii?Q?UxaikQO6CwKQF7NREa8C7QkKuWLMA8wW4pXOfSjRJ6hPzsdopRjjSUoiP+4D?=
 =?us-ascii?Q?Sf/vbkJW7aH8llHZVWRDVcRu2XAlcgHi/zcAgIWFLiA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bebe74b-d805-44c4-483d-08d8a88c6281
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 04:20:17.3382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIX1QsLHQSmZ6O4ruqrXbZhzpneGNdS0D2heK+7xP8CvZbcldQ3EGB9ZKCD7RSCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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

Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>pengzhou
>Sent: Thursday, December 24, 2020 2:05 PM
>To: amd-gfx@lists.freedesktop.org
>Subject: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
>
>The function msleep(1) can be delay to 10+ ms sometimes, which contributes
>a big delay during the full access time.
>
>Changing msleep(1) to usleep_range(10, 100) and it can reduce about 50ms
>delay during full access time.
>
>Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
>Change-Id: I151a07c55068d5c429553ef0e6668f024c0c0f3d
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index 523d22db094b..ef69051681cf 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -282,7 +282,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
> ras_intr = amdgpu_ras_intr_triggered();
> if (ras_intr)
> break;
>-msleep(1);
>+usleep_range(10, 100);
> amdgpu_asic_invalidate_hdp(psp->adev, NULL);
> }
>
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C902b8d53955b4eb
>aba9c08d8a7d1d6f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637443867305925612%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sda
>ta=Nj4thtHNHcIZyVxn1lFOsQSXO0i4cSSWEASpt3RfGtw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
