Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E09C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FF360E91
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4FF360E91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADE26EBA5;
	Fri, 23 Jul 2021 07:32:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8A46EBA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 07:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReJxflDA9BsZg+1tnfnlcWZTRcYZPNPhhSirTZtB2XKaar4S2dBZTQPh/TwrRIdcoPomRjnu/ozo5YsELyWZ9Mr6VYc02/19fVCgKskYA+x4kMbznbKtlfcsaKdmIf/VLhhXzgOM1hwNhsoaIyLSwtK6sYLTOnMS4fu55NydgHCkud/eQI0kQbgB+ZWAdkv41BKdw4Jr4QZLQSrKdnz8tTRrVfwh4C3BQtBK8qHCAOT77SErg8/bxALYat0HOJmQTcPU/JEG1JyJX66kV3stCHAcPLpG4WE704+CDLf9UzW0q7ohAhN/ZyN+asZo5kuL2SHpxKHRqmDAkQizs9Ld9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eap4Us02E6OYg8YRbgPnZlAdlNqDs98Vdgjj1nuZ0w0=;
 b=BH4t1dzyehYoAGk7D+D0Mm+mEwNyKgzC9KhGT6y6VUuRpmGQiAbC38v9WnwFSEGzf5zrP2oC44GgaZLZsnLFAuKvB8fIckPwpE2LpZ5XnhDZIu8fVlVKVQYtvQ82mrOWdky6eb4o56HC+Cagsd92bVgRNeyWEWa9+zB+D+smsg0OeaZ5cdEWlTDRXZPdmu5tbEUfwX0fqqUe7yiaH1B893XRo0NQ51Rr7i1l9dHNkBnn4q+IgOSH67F/4dZljvNtgoAuKR2qROo/+WSrv33CXAWVO+/hGMCYyeFwJz0sorj2d3GV/KJW25uddIOEQR4youBL7Epo/QDdDQie4uqQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eap4Us02E6OYg8YRbgPnZlAdlNqDs98Vdgjj1nuZ0w0=;
 b=TXOxjTX0lnDAMK4nQBV5zsU+uPdI+o0uT4btWnIUcy+1cB4YXGgQWy8Z2IJyBj2B8pzG7RT6KR5knQv2vrAdyfYPdtgEHb0RqIaeAasX+URA61SMXPDdtKdvFs8LWadWJ6YZMsrLrMtR8wVTfN7ZeL7xR7Y2UrKSN6zcvBygpL0=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 07:32:06 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::7d61:1d52:4f7a:6a63]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::7d61:1d52:4f7a:6a63%8]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 07:32:06 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: retire sdma v5_2 golden settings from driver
Thread-Topic: [PATCH] drm/amdgpu: retire sdma v5_2 golden settings from driver
Thread-Index: AQHXf4mOG9gbcTZ6qkWpdSB9GubIoqtQKokQ
Date: Fri, 23 Jul 2021 07:32:06 +0000
Message-ID: <DM4PR12MB5181410EF8953ECE3EE43445EFE59@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <1627020674-2338-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1627020674-2338-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-23T07:32:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=964a3a69-64a2-4414-bdae-7da9a7a38978;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d032997-e7b2-4892-7b8d-08d94dabf95a
x-ms-traffictypediagnostic: DM4PR12MB5245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB524517A8CC3B3F36553332CDEFE59@DM4PR12MB5245.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:230;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2v+O2vXtxX+gXidxvC7OIYA0CMFMlciU90xGP3X3VOnp5blUsKcxob5bv4l+oYj9jwWOu5WoZ3O9NG/iIreDzYIQvqNJB6AGPkY2E4aGELOxtociw/yyOIENidqP5pttGJsLJJNEcI2J23E8HBhJEV6fwyS0CFil9ppQ6cI/UDf3WoEdwU/cNuaNqQf0yBADZ9kB8TR0EqBICGJyyB4FY1PZ6cKvMLFGxkkZRI51za4BxLcAgUZ8Ek1gZemRaVV50FCDXv6QMYR0tXlZW4kZ/SzUXKa8SGOWMyKUrxmedVICHChtlM1hMm7gamZxicrV3KZ3K6KRpHesmli0VMZnZLAEB0OjwxYmqoeLcaRtBOk8ucwlSeRzPtgeJaWaZrrCa2DoucdGImfhfTKVKWOEpTibESeHVKOzshCttYHO9yI/fqSOHP+qrfvCEMQIJc8SkhMzqCXXvXtukduG7KJNbK7Na75CvAyYo+BHddgDsFMvusk/hgPeM9VP5l71YvWca+x4M5KqNTPEkerJvezhzJC5cqrujMN21USATl5X2/HtDSNffna0gn4mk6SonGlN9wuIvF/BcwjAg9N75pZ5PtQ1Tmu+RLjCBpfUGUOebgGYyO5W71kebXNPcR08HaitBCkFEoxKgF11D4hxrgq1MAlcZt65zdDU0b+ZGYON5fUQOr+tWoTuJZ5wkgv5CG80k1+YuU/AVQMJh/f/iXGRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(4326008)(110136005)(53546011)(9686003)(64756008)(5660300002)(76116006)(86362001)(33656002)(2906002)(83380400001)(55016002)(8936002)(478600001)(71200400001)(7696005)(66556008)(122000001)(186003)(6636002)(8676002)(316002)(66476007)(52536014)(6506007)(26005)(38100700002)(66946007)(66446008)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TxhOOt5TbsJlk7WcyaCITPUuNLpZG7Ta2sg1Xevfsb8LGTobSI/FnSlQ/HPG?=
 =?us-ascii?Q?8JGgZMPmpocUd7VCNsi8C7nngO+3Cb5eptw+nXbh19K0n2B2cx2Lw7Waa51+?=
 =?us-ascii?Q?5QMFKUTYef3qwMuNiC7xpOzmWu/T5Q83sLeB0gP7h33oMRfoQXWDav1xiINm?=
 =?us-ascii?Q?/8b5EhNhRnaYbXWbrEP5njX0C1GOEldJlDX5AidNnIblN1ut/zpqpwnCzYRT?=
 =?us-ascii?Q?OZ7qhE3BaoL+lYuJlRCmEieahIX8sB8ND+YVoyPVA0ZJZHlueHGBYdP9hnyF?=
 =?us-ascii?Q?2okrGuVMCCvVDzKyQbGdIFwljMA5mONc1jAsuuC9kz+wEFZ3LONOZxSMKvvR?=
 =?us-ascii?Q?k5kumyKUU9+OHFbgW4g6FCLGdWqid+6zCmv6565zuP/N89v0xiy8stcGnwaz?=
 =?us-ascii?Q?UCJcW76A7el1qpOkGn4kpHvy0ajq7IyRH+iOBAob/L8Hzxhl9MDE2F5oL+fp?=
 =?us-ascii?Q?OBpFnZ1xAwxlOKRifNPUyTL0fHCrd1oDcsKp3SEobttYlahqHP4ipuqqNIjz?=
 =?us-ascii?Q?ttMZCjWtTDCn4nLA+VTFSdaGqaGgxSaNCs3eot9UmuzA71NTzFTmA5iFJqZZ?=
 =?us-ascii?Q?r4tR6zhP9nUBFjfBlMG5RsvJ8IARFBG7gh4ECXjYcObDimgKjUKar5aPfbef?=
 =?us-ascii?Q?YjmIJUKzKTojMCAcXSxhUq6bbE33HTRv+MqowzpVP8dVRpL9M5RvLsMMaGZW?=
 =?us-ascii?Q?42UvSBcZfwK3bUL/TNH3irM1lkbsuF3ak8A3PeA/cKhUAH8DxQxsBPtHRnV0?=
 =?us-ascii?Q?ykVvby3H4/Pywgb1oQGYWwJ6xU0ww/cgI2PSifwuI2xllqGjmxqS/XfwP8K2?=
 =?us-ascii?Q?GAzApOCUPCnY6jyNKDL7vW1j7rhUmFekaac3waIlg73btpDugxKunqwfhYeA?=
 =?us-ascii?Q?cMM8vgYgUkUpABlOqIQ1/Pw1IV8P2W962ylodC66LXKIkLsWuVtIDYVeOvXc?=
 =?us-ascii?Q?xHMRetUtTzqgRSA7w8LH3amgH2OOS62GUGS9d5iwKQ3itx29+DmIXi6mTKSV?=
 =?us-ascii?Q?2dtAZpPB0SXFRix4+9ztgu58mev2Z24lfJ0brJIJ1yceOdwaia7BgSf063JR?=
 =?us-ascii?Q?L5AuyZk5pyUhlbfwq0eFW3aOY6+cnmq7ca3O09lcX18FLYZBxAWzgRrybMu8?=
 =?us-ascii?Q?0Xs/5+tfVqoUw+bIzVHbQQNQQBlXckz6udhcNkm7/uCOvdAJjCR16+t6+ELi?=
 =?us-ascii?Q?TvuTVhppIgFVQ60A7jQAjLdHrAmiXdZ8ybfYrlIZHFM36uqJYNLA3p2BJJqi?=
 =?us-ascii?Q?s+lAe5jeh8t0KV+yBk7aLGb/umXo3efkH64bWPsKikjyDKZm3FOj5VLcFjoB?=
 =?us-ascii?Q?SYkClAUQnYUxHHfFu4YRBBcT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d032997-e7b2-4892-7b8d-08d94dabf95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 07:32:06.5937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mje+PqhKCqdV2VTnB2yLnWmFNjv5dwGOyKLf4pf+96DNKmjebfkYFytzbZ9Eqa0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
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

[AMD Official Use Only]

Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Friday, July 23, 2021 2:11 PM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: retire sdma v5_2 golden settings from driver

They are initalized by hardware during power up phase, starting from sdma v5_2 generation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 7486e53..779f5c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -87,21 +87,6 @@ static u32 sdma_v5_2_get_reg_offset(struct amdgpu_device *adev, u32 instance, u3
 	return base + internal_offset;
 }
 
-static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev) -{
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-		break;
-	default:
-		break;
-	}
-}
-
 static int sdma_v5_2_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)  {
 	int err = 0;
@@ -1345,8 +1330,6 @@ static int sdma_v5_2_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	sdma_v5_2_init_golden_registers(adev);
-
 	r = sdma_v5_2_start(adev);
 
 	return r;
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
