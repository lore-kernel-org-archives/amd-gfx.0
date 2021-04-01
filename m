Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D36C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F0361055
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F0361055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E11C6EC70;
	Thu,  1 Apr 2021 06:03:21 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690061.outbound.protection.outlook.com [40.107.69.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4756EC71
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 06:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6RoLTKxdGKERljDIwpvwwjubqY8cot1695SCiQso9UN6M6g0X4WSIhXSIiTKyc8+qjQoJSiVZZWsRq98nDoD8LWiTBmKKutPx5vyx5eBIYvhUUCzOmUGLY+sdlNfltJmhY850hU06xYXnNLmtKVCXA5jARgxDxT9WroYhfkiVJqKM0xuEPWr4KixF8+MGchuKazeYjHK6lcgksO9udtrwP8AEx+Tfs+8qAIKadLeCX/gz+uBfXwQkZ5nWqsjps0udJROwEiDRsdguqCG0TqYn4/00nZtBXbFYoJYiYdqA6h51a0bv+e/IKCj9+WsMO4Q+hYgI+TUFudw/h8vx6kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn9L4OLmfzsYIkEeF4up3GxBsO8nE/SHP5lYxumP/sk=;
 b=KPxwcXLQNYG3DbKEO+fraxK36dJxtJky7QmGVghasuBUjU7kxJnG9CkDcwrOyeyA1uNxzuTJaVvrbCLDJSwD0yAR+N/V+yHCh19Sy1FuyFqKCHyYXTOSsCfRIo+6pV6sKn++7IjwqTUuHwe1rwO3XfG0EW3UqEji/rOWx2TjnyQgFJcAL5P5WBz/0bU1I2nSA/nYqFLfOmWz4ZJ6AB7lQxJAcMX9XMKtoohCkfrohCfJ3QV3oZFu2J+T6Xeosz8vKjf5wScPUD8uz96AVfz7pPB/1rVldY/om15QYQmNGUhZ2sScii0NTrNd7lWL0Pgy1FLfBh3waKVUtL5JwWuikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn9L4OLmfzsYIkEeF4up3GxBsO8nE/SHP5lYxumP/sk=;
 b=Aj7Q0I0XD7hBh7l+F8zxSJVRe0bOrKjFLQj1nqw90e83+zgDY23uaFK4ZVSsZjf4iDM3wv42rWAWpd4/DPx19RWK9jMJ6zbCbnIFCxcOBwqUV08G0uNvw0WUdJdg4AuLM9TQwfZA2w5mkYzXVyhv6vU7GAapLr/CkxUMfMzjBfY=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 06:03:16 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 06:03:16 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Topic: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Index: AQHXJR8Dr66IHxXZu0+elg0UnZ+vxKqdzm3ggAFgsmA=
Date: Thu, 1 Apr 2021 06:03:15 +0000
Message-ID: <BY5PR12MB41151210844D036CF600264C8F7B9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-2-Emily.Deng@amd.com>
 <BY5PR12MB4115CBCD452268FEE95909928F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115CBCD452268FEE95909928F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ef1ca1c1-b4a6-4588-9375-a4643d51ff2d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:00:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ed33c8-60b9-4436-71a4-08d8f4d3d75a
x-ms-traffictypediagnostic: BY5PR12MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4001FB93B73AD5AC0C0CDDC88F7B9@BY5PR12MB4001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: br0q/O2JVjY+8SiFN4d37pregVGnAVwlmBM90rJZPKyb+o0AHYvS+fOmvGAMRnFJL62ZvbrbcHawLkJn+HWCBsqF+GKA9BScpirYszYpCQNaPEVdGfVpqUFVCnp2QKVEhGxrhQkh8YI6OwgEUL8UGicRhJtBOi4lzDXhg06xQlop4emhguAhixOw7vKSIBz/3HQV1m1CALba3BRFcNsfeHvhwSq7URpUsCrmUGcJRq3AfykuEqv7226o8rgZcftvB/21uu6AyytiPG+aWgEa4ILqIJAaFMnVC77RPqGUPS2UI/KQtp95gFTVNlLjEUt3/pq54PG+hRM7Kpw+pJxRnBQVe2jqGszPD27xtACaiOA7FRak3Uoh1EQd7lqoo3HqpaRhpv+FX88Gtv7gx1LwEkrzcd89TUU14ai0T+eo0D/n62QdQfQmFPKIchbFU0ZqDJkhDjUN9BMyrKruOcqFyx7Nsz8l+EpBwomOxWhLMWMmka/HETzmGJKReFc/+wlDJ48jBI1C0CklALaUY61ewrf0oseWoMFbGP2bbZpeC7BvOxDCYRJbPE064hNCVnUlM5cZ+j96WpfoSmZo+z3+gDnlfibvyEgjNUgJmn4P+Cl51QUfyPDKhBz2L5DD2l7/2UYJV0BlodEvroeN80R3iWNGwLjLGCRlY6m8PK6YqiA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(52536014)(71200400001)(6862004)(186003)(33656002)(64756008)(66476007)(26005)(66556008)(316002)(478600001)(66446008)(4326008)(76116006)(6636002)(5660300002)(66946007)(9686003)(6506007)(8936002)(55016002)(86362001)(83380400001)(7696005)(8676002)(38100700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5T77kaDuEx2vKP54VGYVRk20UoiCr/MOPYXTj6oDjPJhVp06fk5PYFAtj+cE?=
 =?us-ascii?Q?Re3LaatEUnmUMkCiI9iPFF4KEBZ+Q+LG0KmrYGAtjXfSN+QTQR7d1Kan73Sw?=
 =?us-ascii?Q?q63Ayk5l+8ZkXQfoAY2F/dUtj7PIlnR3iWB0SWAryGDSgew2gZdCei72fbOp?=
 =?us-ascii?Q?ap/sHipAi+pv966951ayKTyWm/YjSOPxTyZh3TW9nQSLbzD6GKX7M/Mia/cA?=
 =?us-ascii?Q?Q/puvBI+2tTLQzSr/0kYi5/LTbxlnOxZ27d/g3tAYgTftubaEtrdTi4nPWTm?=
 =?us-ascii?Q?7HaT6x6MNFPwrUApWzNA+oF6/I1H2MQ/F5c/Nhjiyq7R+uPL+pIKpnTsZ+8O?=
 =?us-ascii?Q?WJKOfWzs/GvJekMb/OfuuEGObKgUQRW7SZM8KUyrQqN52rAhReGFa/qPncMg?=
 =?us-ascii?Q?NF+m+WAb//yFhjo0QaV5TylCZlqb3GFYS72Xne5h2JFpsh7HpZqb345QlNtm?=
 =?us-ascii?Q?eDqaJ+TWsOzKATg4j8ou5byT24MOETkNCMtynSd2Pm+Ma67GIvknZZhIoKFj?=
 =?us-ascii?Q?l84KtLcnuE8frfUST7JeevzcFyItFa6fqRjIDfVDpxnRdrK01BJB4WabgCYu?=
 =?us-ascii?Q?I2ttXcbOs3OEUsJNbkB9BSJ776vzpvVZxZYBWCrPKxiLhdb+KZyjBRJOhVAX?=
 =?us-ascii?Q?n75mfbNKad8MET+Z5u5mCjyrlTOmex5VSH486B41ewwGRTSoonZ5uZIF8wOW?=
 =?us-ascii?Q?srzw2rShuuTWotogcCy1YMdWGj1f0N21ZpSsqyekljEFccERrpUISY3V5cF2?=
 =?us-ascii?Q?fjlbmiE/wbrVt2Az8PBnGOSy6/dHQwQApM6aFG+C9ZZhGicgK2Tgw1cT2dbi?=
 =?us-ascii?Q?tUuDF4mM9B68c+zgfgpnnp5l9RdAfWdSz1XsERGOC39OsWjSpQd78cw1PFBj?=
 =?us-ascii?Q?RN6UixhUsD831weDQwWq/tCtAVPVgVVI8GzQtr1P0xZJrNrzpZTNMwOLWqNG?=
 =?us-ascii?Q?k222959XDlQQY4jJnYtsU/AeRAjG0DCXHh0LyEBqXhikYeu1Xp/cu3JYDt0B?=
 =?us-ascii?Q?odL71Mbxg64k+FsfNvyzqJhteov4fuurLgkb1w/5joPL6RbTHJ4BZNIF5Ioe?=
 =?us-ascii?Q?rU54MwzFwhwqJ5OvigYZ8qFvkNKAox3hliSHjMjS+NgXV5Y3RrgDAsGRF8dn?=
 =?us-ascii?Q?CMqSMQe1k+WNe6V5385Jy+Rw6TgydjjTSpZ7e2ywHZA8F9duksGeAXor3HVj?=
 =?us-ascii?Q?NqYsidbXfWfpW/OcMlIhwqeFNkanq3QOOyj7BxMGuLG9chPI2Lrw1rBB6HAu?=
 =?us-ascii?Q?VNfZyhBNAACLFNCSPqtIux3AdyRSkp93n1jkYeyQRBHQpnh9x6vlyAF36P5m?=
 =?us-ascii?Q?8JPQgg1b5TaKvPUIqWeIeEBY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed33c8-60b9-4436-71a4-08d8f4d3d75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:03:15.9538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRkVR+uGd4pwrNq/nieqZrrEc56SmIjPAi2W9hinqhiCMDtPJJLqEWs5IH8+X5wK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Monk,
     Could you help to review this patch?

Best wishes
Emily Deng

>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, March 31, 2021 5:01 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping......
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, March 30, 2021 12:42 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual
>>ctrc
>>
>>Set the num_types equal to the enabled num_crtc.
>>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>index 5c11144da051..c03a83a2b7cd 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>@@ -768,7 +768,7 @@ static const struct amdgpu_irq_src_funcs
>>dce_virtual_crtc_irq_funcs = {
>>
>> static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)  {
>>-adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
>>+adev->crtc_irq.num_types = adev->mode_info.num_crtc;
>> adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;  }
>>
>>--
>>2.25.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
