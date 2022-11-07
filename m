Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F83C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 08:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C0610E2B2;
	Mon,  7 Nov 2022 08:53:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57B410E2EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 08:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtQ/A9mcMMPdgUM2UICMk6BU8NfQBkgES11sOlxHk427bh/F6ADpN3QYM02WhUOqqvXELUGvU0SiMB87I2NExZBBFx57fHF9QPeJarGcX1IcGF036x+UtCFwB8bg+A1grAgOzr5tvvqON0NWUNUBBtsAVRBIJ+3k3AhNHNri4B23oMqtOWQHcGF7+PXzmrA3CFhuPawY6//ngtDyA6Md+BdGvCno2PeCv32sEcI/hfPUS2VfH7xBQSiD2pEcaD10wd7orW8VNZx+rG1muSAyh6Lk66y1Wh+YS3bJGgI5rjDZdfM/NlYsHg3OEGtjfBB0xmjon0s3ivFHr78akhf2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fde5+Re2fTqvO9PASqPmEGgJwm67QCplUIHDRbQxSJA=;
 b=YXtuFKBAiQpvLgvK2W/TZHelYSNaJyWHdNLWwdBde4msAkZWtfxB/n+AxPW6Nl5P2DWwr+aaTdBrcvEi9BUNjIxwEDNSh8t5RsfG+mzQrE6UFVdNpbDtQ2iB39j/9TMDTlwiqi45Cv2rKFIHlJZeRuXYvIj9dKPXOQ5/SxHkrsXJbmxMfstLh9SylXHk79IY5yrXe7+oVBiZntj6NZt8pysLhoU4ZoBN9To5Bmni22hDP8y34Gn+hImYGemynbOOjuT9ULO5OAm/ZsJOOQrvGnGLyHQd6N++Y83SNnFNzU78B6Ls2E6O0EInfMUYMH7A2LfMq6TdnTVjNXvz9CENkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fde5+Re2fTqvO9PASqPmEGgJwm67QCplUIHDRbQxSJA=;
 b=mnQrTAI72sBj+oMZCuW1nOi1yhdXQCIcJkhMVqdJxA13j9g4zsObTeypISrZmg1T072eMjEqZGEgd49iKbKelgmaZyikDNSjuig6hFFKnUT05sx7alU0xyg++f+AyVEep3e7g5PPHaAnVMQFnrrLbGnky7OphdJcmkxyL7LmHuw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Mon, 7 Nov
 2022 08:53:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 08:53:09 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable BACO on special BEIGE_GOBY card
Thread-Topic: [PATCH] drm/amdgpu: disable BACO on special BEIGE_GOBY card
Thread-Index: AQHY8oXti5rKb78MYE2Y3Eln+SF9Nq4zJ56A
Date: Mon, 7 Nov 2022 08:53:09 +0000
Message-ID: <DM6PR12MB2619AD9503054D81E51D4C76E43C9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221107084942.1065293-1-guchun.chen@amd.com>
In-Reply-To: <20221107084942.1065293-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-07T08:53:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2317bd5d-865e-4eb5-b6e4-6825516a58c8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|PH7PR12MB6561:EE_
x-ms-office365-filtering-correlation-id: 43075cf7-5e59-4a79-81f7-08dac09d7eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldH6dKDlQPdIO+QhF9wNpivWsbDvgTNJ8yKXnb+Zr3zctd/BepS1ssnujubADWbTJFNBdXJ2vtxGhyhB9WMvKzTcOIlKHOf5qNqSSpThYMDAbtkHaoDjQE+aKPYd4AE2aqjn3aAV8qqdzUtu+JnCKsj0US4JX1N3Xpu0OyRQ9rRoXWxvQO+CXyTpsem5Omjz6w/LXJBB/xRjLqD2J7UmwCoGWkUaXHBHJsop/YQ3rV9MvMH8dyvRiT48pEzLB9N7t3HDRQaW075sp7pDeoqyofXDTalYjA/I3tLNB7xs6HybDwJ/e/ObwnQa16sHmn/RH4pln9hv/VkhmntNgMwa4wdeKhWDJeDuXw8zZRTiSSahxliMaAmdTDapOtsGGgNrE9l/BkJDD4h54PUfuPUr/39e3Odz5W1R7njHN00uVIAoCvGXwSMDQ6fk8pyXwP59um9LuP/A1+hj2M3jezjHSQ3HZP60++lBcEf0Cw3edg/wkPK8oe5Vgxxc3zztnB4IgIa+fWVMN5XVNVhEHeXcNiuocM3J7ly933gdDeIDugEV3YbY8ThOvJS5rE3K3NcZZotQB4s4zmyEsmhIBvv+G56YtZpX7G7cfjUGXyRx4cSrUDNMnrLeCR5eLm5ccQ8kYMry+MZ5hxGVPPqrJ31Alfsj2ZFgy8PqS1Kn9jU/gzf+tH3MRFVIe6RFL8u693XiWknxER842RWYae4E8dqNDkhlRj5oVcYItCsHW6yfYB4JkzYiG1SjXEsCsl+1D9ZJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(38070700005)(33656002)(66556008)(6506007)(55016003)(2906002)(86362001)(83380400001)(71200400001)(7696005)(316002)(64756008)(8676002)(66446008)(53546011)(5660300002)(66476007)(41300700001)(8936002)(66946007)(52536014)(26005)(110136005)(38100700002)(122000001)(186003)(9686003)(76116006)(478600001)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YVxiTSllTKDmopEoE/nHebqLTR+mwNkCkBQs5KPqDp47vajTmG6LrHdergpk?=
 =?us-ascii?Q?6+5miCRH+5MWucg7X6hj81UuVBKRwEZz7Zd0EmSc+dKWhB36UExFcfsBjsGq?=
 =?us-ascii?Q?zis9WJEPMuuggTNQ8NMjGIAkD29JYeQauCiFLGXc06n+bv1Coe7Tqtxkc9kx?=
 =?us-ascii?Q?ZxkYoxUN1caxzlwauDz1XJTs1P4Z86aD22CyOfq0mMTZSQBgAah34Le0VR8V?=
 =?us-ascii?Q?a8yMaup2WLmhgXbbdcVehVaoGx/1umgB5N1OC5PTdfGtI1Y58RmMhLVJo0K6?=
 =?us-ascii?Q?916TkhLh/1XWmwh7w07WVcLWLJlJxsjDkkuYfmjxG/kC4AXMk888cjeHptMb?=
 =?us-ascii?Q?VEjUCLEF0zfXV7v/0iMsfsrgrQj+8XOrBkh+2Sak0bOhYi6n4syMWvIcr7z+?=
 =?us-ascii?Q?iYxzu+4v5qp00B6wnoUAXy3Gbp5xbLojRdAmUQ+qyeiET29tlAXB+3oMfrma?=
 =?us-ascii?Q?uwzPs3Jv4Nr9RLsuVoFNlZ4AKiyNrYFOmx65foIgYW/5qmUKQC24xd3+D6hz?=
 =?us-ascii?Q?gNzdE3DDDNk2UFZ9PbhtNZSkj7k8GNvfl0c01ajZdBX+y+VPx2l2P+AqDs3n?=
 =?us-ascii?Q?efGbMRq0l7LQKijgmjVDs+oqMOu7158duGZ2/IHwYbuztMJcW40RZjD7aKLI?=
 =?us-ascii?Q?75lMCtcdattqCIDEW1e9RwnAA9be3llM7voTsnVtCnGvSE9/KCiySy8XM6h4?=
 =?us-ascii?Q?waX23dkLQ75TiV+TIDU7GtxG8TsuLIOFVCWd7Ixc/Dl6TuXQqCM44NHboTE5?=
 =?us-ascii?Q?SYLSY/lGi2evD98I0XpALWeQyPRFxT/AMxj+WArlm6XKFiFcchWEC+rwFvsc?=
 =?us-ascii?Q?hPU6e36WNv2orvVc2uHGS2YYuYoqvfnl5dl2rAVg9wXOBAPhRkZ0R7jqM3Qn?=
 =?us-ascii?Q?WYqzeLECqZr/qukRR19MDgjVZ2BHI6Ukr+kD4Y0za9icJF79qFkruY8xZRjz?=
 =?us-ascii?Q?AiGUjbOGTV1mmu98ZGanuYS8yc5sxJZAvh6iIWVTf3++H0alEPJfB6hT4LhM?=
 =?us-ascii?Q?/ZJ3UblliE3no2UlkfKl3k5Ca4mtyxtP7QMzQ27fJt3uCVayHF/nzYwTuGB/?=
 =?us-ascii?Q?ImTddTT4vRnDYondzWcgXlfo3mHvJ3NV1DtNcogZzCd/kRx74SWzHAo6AJmq?=
 =?us-ascii?Q?Q34G3s0w5j2LFkO0ZOZu+LgzfukJgR92XOR18Se2NEEFnINCu5ZZbOtm+H02?=
 =?us-ascii?Q?Vm0PgIC636vjRtTHhF317UQTIQSJTTsiRn+TBgR7f+VeDa7+jpNOczGd04Au?=
 =?us-ascii?Q?tfGbG9PNxwoYsQFY1lLNWLDVudicltgnJuUy6BE7x7gzF5FCxfhi6jkutLNJ?=
 =?us-ascii?Q?4+0W4bZyIj+m7BphWCjPAO3rh+9n83Yh3+E0n6k0WjWzuwJSlOBDtb3huc74?=
 =?us-ascii?Q?vVpZhMTRMYULoY9+8NFAD8ajR5n1/Xjad7IAgzcZg2MpNvlJSDWJ037PebzL?=
 =?us-ascii?Q?kXxSj62Mrcqw2Ni91zvegz5uqHulZ7ZqD/u0cTVu/ycmIYF0gmcs3JfYjuZ8?=
 =?us-ascii?Q?lV9lDgRDB0UXvdjvpHIL07QpmHxpQPr58CkjLKkKqRTax6aGtc1VY5OB6Bqo?=
 =?us-ascii?Q?Ni8BNDMYLqSIGqKtZ6w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43075cf7-5e59-4a79-81f7-08dac09d7eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 08:53:09.6525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/cpY74IP3l+3fBd7JLNE2pTnIvBqJLi4x4EPBw8V6sddcGWSX6zIU5aVS3V2S+W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, November 7, 2022 4:50 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: disable BACO on special BEIGE_GOBY card
>=20
> Still avoid intermittent failure.
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 74996a8fb671..c9e0be9bb180 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -377,7 +377,9 @@ static void sienna_cichlid_check_bxco_support(struct
> smu_context *smu)
>  		if (((adev->pdev->device =3D=3D 0x73A1) &&
>  		    (adev->pdev->revision =3D=3D 0x00)) ||
>  		    ((adev->pdev->device =3D=3D 0x73BF) &&
> -		    (adev->pdev->revision =3D=3D 0xCF)))
> +		    (adev->pdev->revision =3D=3D 0xCF)) ||
> +		    ((adev->pdev->device =3D=3D 0x7422) &&
> +                    (adev->pdev->revision =3D=3D 0x00)))
>  			smu_baco->platform_support =3D false;
>=20
>  	}
> --
> 2.25.1
