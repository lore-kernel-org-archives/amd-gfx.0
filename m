Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C1C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 14:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B40206C3
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 14:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3SNDAICZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B40206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23C76E060;
	Wed,  1 Jul 2020 14:34:24 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690050.outbound.protection.outlook.com [40.107.69.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7926E060
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 14:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWqGoDqLlVBUOWOeTtPM+NK4P3/Gghq6i//j4ixUcuD94LfueO5Aso4V2iwNI63m0BTLqV5vTwuXh3e5WCAemYoc6POXKkaCXdq54cdPJ3zQMpfg/WQMKwxcTqXfAxIxgm40gJQhSZHQAEVrDwxjIuQIaOUL0BasZ5mbfRWAQx7uOYwDxf5znRggJ60GF9Zye8ls8hPgJBqO2FCsjvgqztFzDYKTnGwdTQA6gpWmWlyk3TIc34z4g5fweD4QftJ9hm0HigoBg42eCotrwUqPCdLPF5gGerxpd+4jr16a9bF+GTFcK4hirFWLVfHAiClh4aK/8LZUOc117FrHCHfowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1QIdhVUHDB3/3G1+74FwFgwKEgA4FBidDBD9WWLY8Y=;
 b=ZRio03QDWj44MPcsHv+4RhQ1ZBLICBtzTmBsuH/LjNzQQyvl3zb/TqZgINyPEAdkGmHMWN/16akfMiuNWkyX1rdWX2IwDU2m3jZVhPMiFwzc2ObwrTaovF8jUdRFPAZSM6lBq1t2Q0bUQTszfdTtkcZoWRc1blFpdGDAloUomptGUZbrs54+96QN6Hrl/Gcjn0/lJsgdecezLGlI2sUEHu3ToVC3dpH3ETp41kM+MZUx1Ck7NnPUYAJidfm1rcozHQ5GWbMLkxa0tdH/Hl7ArSqMa/T+kICMaVD5RvlMuVb7jxCIISHK8vY8LD6Znd5GqlBqa/zL5daRn5svS0l7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1QIdhVUHDB3/3G1+74FwFgwKEgA4FBidDBD9WWLY8Y=;
 b=3SNDAICZst0tHbOFvM+P+OufB3NG1plezhifNaONiEy3Ua9r43E8z8tep2tMGywcSAptmZwanvLAMUffjINSc4kqJr7TmFehc69UPskxy3pqXAY/7op5ezNVTy5EIlChA64GxIiK6ZaTytSacz5LA6pqDOOev2b5ppvIZuAxDhc=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Wed, 1 Jul 2020 14:34:22 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a%7]) with mapi id 15.20.3153.020; Wed, 1 Jul 2020
 14:34:22 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: return an error for hw access in INFO ioctl
 when in reset
Thread-Topic: [PATCH] drm/amdgpu: return an error for hw access in INFO ioctl
 when in reset
Thread-Index: AQHWS8K7kzBtripP8UeKS6gsMzr2ZajyOtGAgAAugICAAGexcA==
Date: Wed, 1 Jul 2020 14:34:22 +0000
Message-ID: <DM5PR12MB253318A2BF34A961F75176C0ED6C0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200626140423.1425349-1-alexander.deucher@amd.com>
 <CADnq5_MzKqWxOdzGSVUWU3cJaXwXNNB3T0igMP8dyRpLMGpgEw@mail.gmail.com>
 <50d38fa7-5efd-e6ec-d3bd-313cc0138666@gmail.com>
In-Reply-To: <50d38fa7-5efd-e6ec-d3bd-313cc0138666@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-01T14:34:09Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=19c5cd7e-3c6a-4e7d-a121-02273882c0ef;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.86.6.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ef45028-269f-410f-e088-08d81dcbd8a3
x-ms-traffictypediagnostic: DM5PR12MB1947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1947FEF01BAE89001233CAEEED6C0@DM5PR12MB1947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BxIx4RsYrG3Jnv3xf/1PfHiHz4RCjwd9S2/61rXQnnmU/8g4F5rWfC8wYaeq2RuO8Y/1siILNtLDggnbsVmxBCbQD9ryGbkeFiwLQ9xXFOQbRuNnXOmfhqgtUnANW/0Fbamt+aW6M7UCunqoaDxh2bbmESKnF79qKbXwoEc+bzR0noW9UMAM0cy67clqUWF/bACvowsFlss9edUMo6q/kkFLc6Sx7br4KdnyNQdqoQ+2dvrKfJI/VBW3ZJ3t8jvWa98Pak2RRfe+gvIc4/sM4NXh1V52FwQ19dcxc7ThLzK6dZvHGCyd0yi80QRDiMQtQv4yaubHoZ3Gy0FhqeDSu2IrfyOJvFHYvIswC1LC4FIyre3BdapPVnd1cr6mskoldT7JqRn+Hb+BKbwijYVIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(8936002)(55016002)(83380400001)(71200400001)(86362001)(7696005)(45080400002)(52536014)(2906002)(5660300002)(110136005)(966005)(66946007)(83080400001)(76116006)(316002)(53546011)(6506007)(26005)(186003)(66574015)(8676002)(9686003)(478600001)(66476007)(33656002)(66556008)(64756008)(4326008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Y2IFu3p4B4L6T3fyoGqgFcS/GESDwqc7Xm6F+4hcmypQVB8kL0gmYmzPRFfWjtbfZfUjt43mFiujALNynFyjv5dUtlIK4nt7rTXxWoFrtPYiyQD/4stPAav+0fp4lcrtNyViDKS5Kj/SdeK75VJbEy1KguorbAAmoQTL20BA9Jp+usVELwcx0dUpWULyO4aSLb2rzSuuhAHG2KWCV3SWOX0DLz8YDH0XzfWPWG+52Bq4WwNOWbfSTEnQWUEAXrZUlDR4mdLMsxmj06bnY9TAEhXJjA3NJJYWWy563sofzLrqPKEdWBrN0RVc9bbzGvDruSO3Ryv4ZLthAmxk9bfzpgXNGrfq0UvPS4pwHg7tC6/C4VAMJfT8ECrIpK4H+Umdx30JDq4rU9wRKXgP/hCLco8/QTuUevWo9fJWdNmXbjVCgYohXjg7ILOjwIZ7ayvbfF4JYlgoR0Dbd3WR9vI48hYY2ivli8ht9c1obFt0awY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef45028-269f-410f-e088-08d81dcbd8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 14:34:22.2010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNcqgWYJ3vPYBbcDa1EsJl17w08Ca7CgGexJuy9T5opQcFQ/ruGY4y/qj+5YKGe3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Christian and Alex
      Not only amdgpu ioctls, but amdkfd ioctls also have the same issue. =


Best Regards
Dennis Li
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christia=
n K=F6nig
Sent: Wednesday, July 1, 2020 4:20 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-gfx@lists.freed=
esktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: return an error for hw access in INFO ioct=
l when in reset

I don't think this is a good idea, we should probably rather wait for the G=
PU reset to finish by taking the appropriate lock.

Christian.

Am 01.07.20 um 07:33 schrieb Alex Deucher:
> ping?
>
> On Fri, Jun 26, 2020 at 10:04 AM Alex Deucher <alexdeucher@gmail.com> wro=
te:
>> When the GPU is in reset, accessing the hw is unreliable and could =

>> interfere with the reset.  Return an error in those cases.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c =

>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 341d072edd95..fd51d6554ee2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -684,6 +684,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev,=
 void *data, struct drm_file
>>                  if (info->read_mmr_reg.count > 128)
>>                          return -EINVAL;
>>
>> +               if (adev->in_gpu_reset)
>> +                       return -EPERM;
>> +
>>                  regs =3D kmalloc_array(info->read_mmr_reg.count, sizeof=
(*regs), GFP_KERNEL);
>>                  if (!regs)
>>                          return -ENOMEM; @@ -854,6 +857,9 @@ static =

>> int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
>>                  if (!adev->pm.dpm_enabled)
>>                          return -ENOENT;
>>
>> +               if (adev->in_gpu_reset)
>> +                       return -EPERM;
>> +
>>                  switch (info->sensor_info.type) {
>>                  case AMDGPU_INFO_SENSOR_GFX_SCLK:
>>                          /* get sclk in Mhz */
>> --
>> 2.25.4
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CDe
> nnis.Li%40amd.com%7Cefeeda4b6d194660fbc508d81d9791a3%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637291884123360340&amp;sdata=3DGNPWQNndUJKx7
> 70fDTuRGBnJzfmRUQjD4B1HBie3xUQ%3D&amp;reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CDennis.L=
i%40amd.com%7Cefeeda4b6d194660fbc508d81d9791a3%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637291884123360340&amp;sdata=3DGNPWQNndUJKx770fDTuRGBnJzfm=
RUQjD4B1HBie3xUQ%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
