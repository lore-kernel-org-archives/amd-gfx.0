Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FDBC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 12:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5309208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 12:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YR+QkP/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5309208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8086B6E9BA;
	Wed, 15 Apr 2020 12:25:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2A06E9BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 12:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz7wPCDWUDn52T7EMFfUFCpyjZ+ty+QFNeKn9vnoJX49sp6+BdCSrJzc/MHPf2MTGMwdl3NjEBdu6UwPcGQBkDY8u3l544UlRGqux+QFsuKrRpICJp+va45KWYWs/vxY7yEkbpE2Sbd0deqQkASU4TFv1XPcBe8iJ1zU1gw1eqdE2G3TSD4myJDRi/CC0iyYmg1rtCiywUev9eug9SHRVm2iG8h9KyxbOoaMBupLiikgvjNs0YmlFlVDkdwJJ5Cwg7biojdWLyCJAewrCjsvLzEzdhXRrDukNoCnfdA116I9IYIwkjUNfG0HUJMHkovod5Qj4oZs03wn4X/PvNEatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5fYVscH+3abwnVjGyRfyVXIge0MPKT1KzZ0sPeqiHM=;
 b=nbi0mC0vmEHVtbtVHFRWai6HzF62kODuV8P5d2hYA1ZkA1uJma6CARYe+t4SUqFvofOd/aF7o5j+ymPGqNK3Mnw/IQg1p9S4X88WTitOEqTUkd86QCDu9GHUSRD9wgr0yhvFpkejSPtdN/oTACmpGs85g71bFEg4DpJ0TFlsHGxlP+AEh1+OV2la+OB7k/Mj9Ey6ykcviROihD0hpcVJeIaj6SHgPz7mUSOtliDcp01PjE9PO90rIuPDHSq4Di2ucKjB3+T11mb0/PrnKZDcCd/Ooh3vAX4TLZlnvG8dg8y3z2NSx8bRMRJkH4Y2n4bnYgWLxjBfI1cvFg/PPXq/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5fYVscH+3abwnVjGyRfyVXIge0MPKT1KzZ0sPeqiHM=;
 b=YR+QkP/YuIiacezzfmkLcLk2fadp7muKK1g/4e0RBJuh0AJG3RIegfOJ0A6ysAms8s2/0TiRQyT0QwipcmKx1E/0D44llndpSPZmNEYIsAsqXM9jEQP8iDWSCAvd+YNbvdvKMoFzLIyxU9lKrk7bCtU6BHkXSI++Nom1xxcSYIw=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2SPR01MB0056.namprd12.prod.outlook.com (2603:10b6:208:1d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 15 Apr
 2020 12:25:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 12:25:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Zhu, James" <James.Zhu@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Index: AQHWElUnk8wKi1ZLqEuV2gA7O9p+26h4q6YAgAAISgCAAAIWAIAAyrOAgACMPgCAABAHtA==
Date: Wed, 15 Apr 2020 12:25:18 +0000
Message-ID: <MN2PR12MB44881B28F6F7D279851B350EF7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
 <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
 <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
 <MN2PR12MB40785C6264E06349DAC18DB2FCDB0@MN2PR12MB4078.namprd12.prod.outlook.com>,
 <MN2PR12MB289650886705D4BB2185C90DFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB289650886705D4BB2185C90DFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T12:25:17.014Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.187.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 230bb1f1-7274-44cd-9ac5-08d7e1380f0a
x-ms-traffictypediagnostic: MN2SPR01MB0056:|MN2SPR01MB0056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2SPR01MB0056C95034C864F703706B59F7DB0@MN2SPR01MB0056.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(19627405001)(8936002)(45080400002)(5660300002)(966005)(33656002)(2906002)(478600001)(8676002)(86362001)(71200400001)(81156014)(26005)(186003)(110136005)(54906003)(66446008)(4326008)(53546011)(66556008)(55016002)(7696005)(83080400001)(316002)(64756008)(66476007)(76116006)(66946007)(52536014)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyuRff1BZBFlp7HCu9YA+acTgaCIJF+EPfgtFHRLl+UlseFPlBwhQAhniQhTnoJYKzCDUvumvIV+4LX7iKdAjZfhPIGka26rpRyf13FlD1EVv2gwGr5xYJ7WX2foNASqbl7emh++fpJvvcU2asp8MRKrKqytfB30G30s2dKnojW4Drtx6SWmOTFRube/vBo/uGXwWCmvf4f2EhusZOl3/TzbrZGAdNET0JATJWgTUcvVwTwdXoKDGVUiK7uu5pxPrpq47/8OW+nVubMBnFQj0EQsKL7NiMe5R9Ty+Do9hqkukdcPbxjmMEUYEdNKSZ5EMc+Pz90xnIFsAkPj63dfCgOGmSAsnyiFExqpzm+hd1HXQrsA8j1YUdwj3B2PD0YIm4uaXccgD/0cDEhOWzXTBchg4tE4SQv/rd/GEok6R8YKAImuebd+xrXVkrnBMN5ppbv+a1XLym66GuhFtHFWtuOs4PHtoXz3EkEC7YJLsF6N33TuigM1gbNckgCTFvBdnjXELDd7Lvk3krSzhe+ySw==
x-ms-exchange-antispam-messagedata: /wHq/jW7x2a4Dhsxr12E/hQ5lOgP46S5npylozWeEelvpTVXWGGPMSI4jRy5FaRvrz3iiDyJyj7lgjskuPacD7+VVgLmtCb6N1DNL2OP13fI/1oV5SF/SnNocR0sH5qsod82ZLvs/VtJIzZpT9BVZg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230bb1f1-7274-44cd-9ac5-08d7e1380f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 12:25:18.1592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CE+Ed5lQ9HnRO3eoMcZkitkvqQcpXEShkWE0fQZ2YHuJU28s1EiEmQEWjCFGwPLViNG8LJi2lVbu5RugnBcDBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2SPR01MB0056
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
Cc: "Huang, Shimmer" <Xinmei.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============1606588954=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1606588954==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881B28F6F7D279851B350EF7DB0MN2PR12MB4488namp_"

--_000_MN2PR12MB44881B28F6F7D279851B350EF7DB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Do we know if whatever issue was actually fixed on renoir?  If not, I'd say=
 just leave it for now.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhu, Cha=
ngfeng <Changfeng.Zhu@amd.com>
Sent: Wednesday, April 15, 2020 7:27 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhu, James <James.Zhu@amd.com>;=
 Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <amd-g=
fx@lists.freedesktop.org>
Cc: Huang, Shimmer <Xinmei.Huang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue

[AMD Official Use Only - Internal Distribution Only]

After drop this WA,
It can't enter GFXOFF on raven2.
And it can't run S3 successfully on Picasso and raven1.

I suggest that it can add chip type and drop this WA only on renoir.

BR,
Changfeng

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, April 15, 2020 11:05 AM
To: Zhu, James <James.Zhu@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Z=
hu, Changfeng <Changfeng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue

[AMD Official Use Only - Internal Distribution Only]

This actually introduced at very early stage we enabled GFXOFF for the firs=
t time on Raven platform. At that time gfxoff can't work with Video play ba=
ck (this is general issue across all OSes). So we disabled gfxoff when ther=
e is workload on VCN.

For most ASICs, it shall be removed. The only concern is some old Raven pla=
tform where the rlc fw fixes are not available.

I had a quick chat with @Zhu, Changfeng who will have a quick validation on=
 his old Raven platform so that we can safely remove this workaround finall=
y.

Regards,
Hawking
-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, April 14, 2020 23:00
To: Alex Deucher <alexdeucher@gmail.com>; Zhu, James <James.Zhu@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhu, Changfeng <Changfeng=
.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix gfxoff issue

+Hawking

Hi Hawking,

can we drop this WA?

Thanks!

James

On 2020-04-14 10:52 a.m., James Zhu wrote:
> +Rex
>
> This is introduce by below patch.
>
> commit 3fded222f4bf7f4c56ef4854872a39a4de08f7a8
> Author: Rex Zhu <Rex.Zhu@amd.com>
> Date:   Fri Jul 27 17:00:02 2018 +0800
>
>     drm/amdgpu: Disable gfx off if VCN is busy
>
>     this patch is a workaround for the gpu hang
>     at video begin/end time if gfx off is enabled.
>
>     Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>     Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>
> On 2020-04-14 10:22 a.m., Alex Deucher wrote:
>> On Tue, Apr 14, 2020 at 8:05 AM James Zhu <James.Zhu@amd.com> wrote:
>>> Turn off gfxoff control when vcn is gated.
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index dab34f6..aa9a7a5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -369,9 +369,11 @@ void amdgpu_vcn_ring_begin_use(struct
>>> amdgpu_ring *ring) cancel_delayed_work_sync(&adev->vcn.idle_work);
>>>
>>>          mutex_lock(&adev->vcn.vcn_pg_lock);
>>> -       amdgpu_gfx_off_ctrl(adev, false);
>>> -       amdgpu_device_ip_set_powergating_state(adev,
>>> AMD_IP_BLOCK_TYPE_VCN,
>>> -              AMD_PG_STATE_UNGATE);
>>> +       if (adev->vcn.cur_state =3D=3D AMD_PG_STATE_GATE) {
>>> +               amdgpu_gfx_off_ctrl(adev, false);
>>> +               amdgpu_device_ip_set_powergating_state(adev,
>>> AMD_IP_BLOCK_TYPE_VCN,
>>> +                      AMD_PG_STATE_UNGATE);
>>> +       }
>>>
>> Why are we touching gfxoff with VCN?  Was this a leftover from bring
>> up?  Can we just drop all of this gfxoff stuff from VCN handling?  I
>> don't see why there would be a dependency.
>>
>> Alex
>>
>>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)    {
>>>                  struct dpg_pause_state new_state;
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli
>>> sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%
>>> 7CJames.Zhu%40amd.com%7C3dd9135c717a4b3011e308d7e07f52b6%7C3dd8961fe
>>> 4884e608e11a82d994e183d%7C0%7C0%7C637224709763391845&amp;sdata=3DY%2Bt
>>> sJQNB1TXCQ9v86DW%2F0FC63gOSHsfzzZFu0MDvCHw%3D&amp;reserved=3D0
>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C9c7d297e1bae4b559e2c08d7e12ff6b7%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637225469199881257&amp;sdata=3Dl%2BQiZNOq%2F%2FazF=
g2wmPAt6ZmNSQfJsniMA4W%2BQUBzTxE%3D&amp;reserved=3D0

--_000_MN2PR12MB44881B28F6F7D279851B350EF7DB0MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Do we know if whatever issue was actually fixed on renoir?&nbsp; If not, I'=
d say just leave it for now.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhu, Changfeng &lt;Changfeng.=
Zhu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 15, 2020 7:27 AM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhu, James &lt;Jam=
es.Zhu@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lis=
ts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Huang, Shimmer &lt;Xinmei.Huang@amd.com&gt;; Huang, Ray &lt;Ray.=
Huang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
After drop this WA,<br>
It can't enter GFXOFF on raven2. <br>
And it can't run S3 successfully on Picasso and raven1.<br>
<br>
I suggest that it can add chip type and drop this WA only on renoir.<br>
<br>
BR,<br>
Changfeng<br>
<br>
-----Original Message-----<br>
From: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>
Sent: Wednesday, April 15, 2020 11:05 AM<br>
To: Zhu, James &lt;James.Zhu@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmai=
l.com&gt;; Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
This actually introduced at very early stage we enabled GFXOFF for the firs=
t time on Raven platform. At that time gfxoff can't work with Video play ba=
ck (this is general issue across all OSes). So we disabled gfxoff when ther=
e is workload on VCN.<br>
<br>
For most ASICs, it shall be removed. The only concern is some old Raven pla=
tform where the rlc fw fixes are not available.
<br>
<br>
I had a quick chat with @Zhu, Changfeng who will have a quick validation on=
 his old Raven platform so that we can safely remove this workaround finall=
y.<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Zhu, James &lt;James.Zhu@amd.com&gt;<br>
Sent: Tuesday, April 14, 2020 23:00<br>
To: Alex Deucher &lt;alexdeucher@gmail.com&gt;; Zhu, James &lt;James.Zhu@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhu, Changfeng &lt;=
Changfeng.Zhu@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix gfxoff issue<br>
<br>
&#43;Hawking<br>
<br>
Hi Hawking,<br>
<br>
can we drop this WA?<br>
<br>
Thanks!<br>
<br>
James<br>
<br>
On 2020-04-14 10:52 a.m., James Zhu wrote:<br>
&gt; &#43;Rex<br>
&gt;<br>
&gt; This is introduce by below patch.<br>
&gt;<br>
&gt; commit 3fded222f4bf7f4c56ef4854872a39a4de08f7a8<br>
&gt; Author: Rex Zhu &lt;Rex.Zhu@amd.com&gt;<br>
&gt; Date:&nbsp;&nbsp; Fri Jul 27 17:00:02 2018 &#43;0800<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp; drm/amdgpu: Disable gfx off if VCN is busy<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp; this patch is a workaround for the gpu hang<br>
&gt; &nbsp;&nbsp;&nbsp; at video begin/end time if gfx off is enabled.<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp; Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.co=
m&gt;<br>
&gt; &nbsp;&nbsp;&nbsp; Signed-off-by: Rex Zhu &lt;Rex.Zhu@amd.com&gt;<br>
&gt; &nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher@a=
md.com&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2020-04-14 10:22 a.m., Alex Deucher wrote:<br>
&gt;&gt; On Tue, Apr 14, 2020 at 8:05 AM James Zhu &lt;James.Zhu@amd.com&gt=
; wrote:<br>
&gt;&gt;&gt; Turn off gfxoff control when vcn is gated.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 &#43;&#43;&=
#43;&#43;&#43;---<br>
&gt;&gt;&gt; &nbsp; 1 file changed, 5 insertions(&#43;), 3 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt; index dab34f6..aa9a7a5 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt; @@ -369,9 &#43;369,11 @@ void amdgpu_vcn_ring_begin_use(struct=
 <br>
&gt;&gt;&gt; amdgpu_ring *ring) cancel_delayed_work_sync(&amp;adev-&gt;vcn.=
idle_work);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&a=
mp;adev-&gt;vcn.vcn_pg_lock);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev=
, false);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_pow=
ergating_state(adev,<br>
&gt;&gt;&gt; AMD_IP_BLOCK_TYPE_VCN,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; AMD_PG_STATE_UNGATE);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.cur=
_state =3D=3D AMD_PG_STATE_GATE) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev,<br=
>
&gt;&gt;&gt; AMD_IP_BLOCK_TYPE_VCN,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_STATE_UNGATE);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt; Why are we touching gfxoff with VCN?&nbsp; Was this a leftover fro=
m bring <br>
&gt;&gt; up?&nbsp; Can we just drop all of this gfxoff stuff from VCN handl=
ing?&nbsp; I <br>
&gt;&gt; don't see why there would be a dependency.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;=
pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state new_state;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.7.4<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fli">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli</a><=
br>
&gt;&gt;&gt; sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;dat=
a=3D02%7C01%<br>
&gt;&gt;&gt; 7CJames.Zhu%40amd.com%7C3dd9135c717a4b3011e308d7e07f52b6%7C3dd=
8961fe<br>
&gt;&gt;&gt; 4884e608e11a82d994e183d%7C0%7C0%7C637224709763391845&amp;amp;s=
data=3DY%2Bt<br>
&gt;&gt;&gt; sJQNB1TXCQ9v86DW%2F0FC63gOSHsfzzZFu0MDvCHw%3D&amp;amp;reserved=
=3D0<br>
&gt;&gt;&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C9c7d297e1bae4b559e2c08d7e12ff6b7%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637225469199881257&amp;amp;sdata=3D=
l%2BQiZNOq%2F%2FazFg2wmPAt6ZmNSQfJsniMA4W%2BQUBzTxE%3D&amp;amp;reserved=3D0=
">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cal=
exander.deucher%40amd.com%7C9c7d297e1bae4b559e2c08d7e12ff6b7%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637225469199881257&amp;amp;sdata=3Dl%2BQiZNO=
q%2F%2FazFg2wmPAt6ZmNSQfJsniMA4W%2BQUBzTxE%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44881B28F6F7D279851B350EF7DB0MN2PR12MB4488namp_--

--===============1606588954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1606588954==--
