Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E1FC001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 03:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E7510E028;
	Fri, 28 Jul 2023 03:41:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2064F10E028
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 03:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fovy1gQOoLoRqgbrgnDaPzhL95O2mmrj4HqxyxBr01sf8C2pujRzEXUIOCxJZsOl2QDFtm7oVy7GaUZ9s8pSNOmNwRyKPeKgkkIVITgoqiPqGBlvqShsvThK9VoYB+L+iXAX3+2Ye6aPZ6Qv27KEhslASldOy2c2TZXDrLFEjOrvF4ednq6hkHt7OLF/0fH5gwD2ES7USuEkydTIkTlnWaO3MGiTRaWtrshPW3xZMXnfEGPTyHhLIu9/Xwj+wp5D2A2KfyePp+cduLgGMSWTCaCS7OcT1z+0RKkyu4+0NuR1Tp96yZAPyDqss2x5h5a7I9r6v53CiL3RAuJS/HyEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saxPNJjPHZsoKOEO/Wl1ep/rZL6CaIObyA3d53zlfKk=;
 b=CZ5WWIPU2cgi+CiqDpHvDGP87FETLB5P03bd4k2lpHWDqmoVO5Plb9qYKeWvBjR7SsdG0Ls2TAd5U61OWb4vAxmmvQ3qjRT+K50S7QX5oRX4TUonMQR0Y1HgKK9EICeLAGZkDjHWhN7vJUrqrqeYgEt+nS4xZUTlPRUKlL/PXuzrOj4un/YZzBhftYAQReB3cjlARJFEByMGnHe8pQW1L2ku3/ZS/i2h9/vUcvVE5ZUt+2xRd5MHiikUjAgg85wvAH5G8XAg87BTKDeY/FT/Sfw2pEp7mxbD6IRZWXwUa0v/3IoVKeAPYdwi24yuKvaqBvBNLnxqyevKFui3MlI3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saxPNJjPHZsoKOEO/Wl1ep/rZL6CaIObyA3d53zlfKk=;
 b=eLrWPh+7rp9iSCzvz3s5ST/QPYg+KbY7rH0mIpb9zw2mepi7bEMA7AQu7SjdW8nQ40B5cBWJjWj9L0CMrUiSnyfBkh2a14G3wS3Bu5O41RCKmawnf1zUUWFzUHU71A5Pq5L5lXh5AznBeLS5X8BvG1FXlEhCk9Ae2wCyz5bVqzQ=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 03:41:05 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::151a:deaf:fc88:ab6b]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::151a:deaf:fc88:ab6b%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 03:41:04 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU
 v13.0.4/11
Thread-Topic: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU
 v13.0.4/11
Thread-Index: AQHZwO/cPE+4GwfmvEWxlR2Jigotna/OX9MAgAASFu2AAAWXAIAADNjQ
Date: Fri, 28 Jul 2023 03:41:04 +0000
Message-ID: <BY5PR12MB3873DFD25AA068E593F046FEF606A@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230728010504.532158-1-tim.huang@amd.com>
 <e751765e-9ec2-83e0-90f6-c7d96943dac2@amd.com>
 <BY5PR12MB3873A8ADD1B0CE858527D041F606A@BY5PR12MB3873.namprd12.prod.outlook.com>
 <99aa09fc-4f63-0529-c029-a4f5a8f49bf0@amd.com>
In-Reply-To: <99aa09fc-4f63-0529-c029-a4f5a8f49bf0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-28T03:40:56.874Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|LV3PR12MB9213:EE_
x-ms-office365-filtering-correlation-id: ae3268fb-e542-4203-76dc-08db8f1c786a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9m6/F6vEzYF4PZMyGgRqzc0kCBam05zoGg6OWNCYpV1J+FGFPC71uARm/4vq3zJLG9RmHMpWuMK0de3S1eFD54QHc35RVC18i8xPP7XDonJktKfBgYIC3GL19q+eHwOVjwarA7tcbRgP6EjamDPYCfi6PgiG1QNnEe/t3mib72VYY+Tr0KeQFL5wqn3pLU1iPsp1FmG0SmTYtMLcXmVyr4nipaO48u0kTqJuow1jjchUd5coLwQXz2fGR4pgQsXTctb5nYLfYXP5MBuBVCuchHNMCS6RSxpt2/P1Gzw0ToRNtCrvyFmxBG5h+yd0k4xso8UvGj7JgVDBOaarFb334494kX468xKGG8mwQOpKjD1mCnu32VpMvcjATbepgpaf839eK4KdVZkimFaD0kaa3b54H1HHJNS+UC0gaKPh3pRvpaY1ceuw+ax26alWkRUZefm5sOHsfrlvFLtoKu1bDnE6r1NIpUW2pPSwrzMJeK5nrvjZSqJ8fQzm7gvk6CTwFJl3DwwQnBIkqULXW1aUTnvMxSNg6tZKyMMJheEWPJ73wf97L6hjgcmXMN6HW3IApALedHSOEKMQ1puFPpJ/Dh1BOKcB0p/SMXhqADVYPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(19627405001)(66446008)(41300700001)(26005)(86362001)(66556008)(53546011)(71200400001)(38100700002)(478600001)(122000001)(91956017)(966005)(9686003)(4326008)(8676002)(8936002)(166002)(186003)(316002)(66946007)(64756008)(66476007)(76116006)(33656002)(6506007)(5660300002)(110136005)(83380400001)(54906003)(52536014)(38070700005)(55016003)(7696005)(15650500001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3VrCrcu9iUFSiOorvGfZpRQtBd+soDf7T1oz5SaQgdQqv/jAd2K7GhxScL?=
 =?iso-8859-1?Q?HBB0s+lAM8XC39uF57a8dFe+4kQG/C9onSQx0V7dDPjUEm5FZcQTWfmuA/?=
 =?iso-8859-1?Q?eXBGOaO62t3Xt/fhUgypqhVWKXBjOfIfSXLtPjNb3kzLSo7XcM7SEbv3Km?=
 =?iso-8859-1?Q?Z39fESep2n6TiQqHePXcOxbnBm8O+4H7SJARKl2H1vDHkrdOMEkEi6ahAV?=
 =?iso-8859-1?Q?mopfU3qyRBibqg6nGBKoHMkWot008zLL4wZOr6hLYMXSu54y/5uM3ZZqE1?=
 =?iso-8859-1?Q?fXORJpldhJeNzvUKLYdIpPn6uRxMIg2ojzSn6NMevoxkgIXv/vAuyX+RjP?=
 =?iso-8859-1?Q?Mc0FSVUR5osn1GdFaEgjG6sGpnKfGpF2tYk4KRz6wTmFv7miBGWFZYNcsL?=
 =?iso-8859-1?Q?YFcbRiM1vBz9DmhN/z2XIY9QrevYiuQSv+SRtT+kemPazrVwv7wOW4MQXm?=
 =?iso-8859-1?Q?Ap5t7jiZtX2ZkCWN1MbFu2TIgoGH1AQNmxn2sFR8fSVuiXMMuw316RFSaX?=
 =?iso-8859-1?Q?/2wVN0oMnh7Kf4oHkTFvOgUzNJusloOFwYM+yuBEW49cyFOZT/8lqXjwip?=
 =?iso-8859-1?Q?STSlkpnf2/tPmh4Efr5jaYYvl4Hsru7X7hFL62LfACPJP0qsd1IsiBNYSz?=
 =?iso-8859-1?Q?gsNYFhMT/8ijeB40AMNUPq3C4IFwffNBheE6iRZYRiyZ8gQMDXOI1VEteK?=
 =?iso-8859-1?Q?z/UF9AA1DzVU4nDcA3ldqtbqp5dhWj5uQVTn+NWqL6ETnnaWzZqnzC5rLc?=
 =?iso-8859-1?Q?E/Y1eStwnXyHlxcMKZp3BNDZx5LWpepfceABVzGkzqQ51Fo9ABKJGSodfq?=
 =?iso-8859-1?Q?Im67JaULgS3ZzcHScw/gOqpA8gMQbxur2/0vPcDaT7UQQG+wRrzmnh0s6S?=
 =?iso-8859-1?Q?sf7O9Mb6T2QrwB/A+c39cGv+bGBstRgWm+onSq9EEM7kuUmqMbipaKeJtb?=
 =?iso-8859-1?Q?vcgnwLGb+vlj5vGkZuPB0kIBSqATCMpK2UaKm97OcJgMY2oO3806bkFiWQ?=
 =?iso-8859-1?Q?2NjHWehy9G9kLk/4kZhED266HaCv9uKdhvjrmgNw5Fhu3oBOjuYWubgx1s?=
 =?iso-8859-1?Q?g3JY2qqrSm1+4rnbpbPeuvCC8Ab7sndZDRONWC8LHlfcu5nBYW3s39GtHS?=
 =?iso-8859-1?Q?kqbXrlVNKm0busgVGxdpthfGbY/6ll9dde/xpanNe34ZE9vVssg+X3zVE4?=
 =?iso-8859-1?Q?g4uquWHUwT2uwHvlGcu0Lbq5Sy66BwKzM6umjDqi/zhSFJI3C9xjdbTFec?=
 =?iso-8859-1?Q?B+WopIw8Zzf8UHNpDF+k7dtwghhqmSBDNKNEnvjqChE29WMxQwzQHBW3uk?=
 =?iso-8859-1?Q?+63tzP+GXvvNrSAg5WpLSSL1wuyneGxVUtRop6tNJmBCBFZgTeYQSPlLtf?=
 =?iso-8859-1?Q?ZmdONOUDScKI14q/IEXdiaIhV/R+d9aqBmJsDrdVDxqfmHPNz5nFI0/+/0?=
 =?iso-8859-1?Q?F2lizNZOin5J619TuDueoVuXJryj7QlZydUIBnIW1TJ+v2aD0kh9a7ACHL?=
 =?iso-8859-1?Q?kVjklb8rrvZIroJA5ajQXbiZtMJ3qG8aUJPtr9d+6FpvuPJJDXwSo1/iCa?=
 =?iso-8859-1?Q?07n3jo86liEZ/xJq4o3KojZ+de04AG+pReTT94li5kUejBXd5WIdzrnEwi?=
 =?iso-8859-1?Q?Syo69GQ/qNiNk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB3873DFD25AA068E593F046FEF606ABY5PR12MB3873namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3268fb-e542-4203-76dc-08db8f1c786a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 03:41:04.4729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9L3fBgAgQ0r8+TS7OSLqoFndPecMLZdFix8xc7Qc+GcXa4wZWAkpqG0jZZrI6MY/Xi3H9UbYMckTH6K5cfXjxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB3873DFD25AA068E593F046FEF606ABY5PR12MB3873namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Friday, July 28, 2023 10:39 AM
To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SM=
U v13.0.4/11

On 7/27/23 21:21, Huang, Tim wrote:
> [AMD Official Use Only - General]
>
>
>
> *From:* Limonciello, Mario <Mario.Limonciello@amd.com>
> *Sent:* Friday, July 28, 2023 9:14 AM
> *To:* Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend
> for SMU v13.0.4/11
> On 7/27/23 20:05, Tim Huang wrote:
>> From: Tim Huang <Tim.Huang@amd.com>
>>
>> For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
>> the firmwares will handle that properly.
>> Conceptually I'm aligned to this.
>> But, just to confirm, have you already run some testing with this
>> with current GPU F/W, BIOS and either 6.1.y, 6.4.y or ASDN?
>
>> I checked with this on my side and saw success but I'm fearful
>> that it introduces some of the fence expiration problems we
>> had in the past and I'm just not seeing them for some reason.
>
> Yes, verified based on current BIOS and latest drm-next kernel and the
> working FWs as the latest FWs
> may have some new issues.
> For this patch, it is asked by the FW guys, driver should not touch
> RLC_CNTL in S0i3, let RLC FW to do that. If driver programs RLC_CNTL to
> halt RLC, RLC cannot go GFXOFF exit sequence.
>
> The fence expiration should be still there by the delayed GFXOFF , but
> this patch should be useful to help debug it as it avoids the system
> hang when the issue happens.

> So in that case you think that when the driver programs RLC_CNTL  but
> GFXOFF was delayed sequence was going out of order and it triggered
> system hang.  But now with this patch it will not hang but fences expire.

> It makes sense to me.  This patch shouldn't be any "more" harmful then.

> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> For the delayed GFXOFF issue maybe we should revisit my previous idea
> for flushing GFXOFF requests.  IIRC the most recent version was:
>
> https://patchwork.freedesktop.org/patch/537888/?series=3D117965&rev=3D1

 I agree.  We can add this patch to the latest test build and check whether=
 the issue is gone.

 Thanks.

>
> Best Regards,
> Tim
>
>>
>> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm=
/amd/pm/swsmu/amdgpu_smu.c
>> index ce41a8309582..222af2fae745 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1581,9 +1581,9 @@ static int smu_disable_dpms(struct smu_context *sm=
u)
>>
>>        /*
>>         * For SMU 13.0.4/11, PMFW will handle the features disablement p=
roperly
>> -      * for gpu reset case. Driver involvement is unnecessary.
>> +      * for gpu reset and S0i3 cases. Driver involvement is unnecessary=
.
>>         */
>> -     if (amdgpu_in_reset(adev)) {
>> +     if (amdgpu_in_reset(adev) || adev->in_s0ix) {
>>                switch (adev->ip_versions[MP1_HWIP][0]) {
>>                case IP_VERSION(13, 0, 4):
>>                case IP_VERSION(13, 0, 11):
>


--_000_BY5PR12MB3873DFD25AA068E593F046FEF606ABY5PR12MB3873namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b style=3D"font-size: 11pt; font-family: Calibri, sans-serif; font-style: =
inherit; font-variant-ligatures: inherit; font-variant-caps: inherit;">From=
:</b><span style=3D"font-size: 11pt; font-family: Calibri, sans-serif; colo=
r: rgb(0, 0, 0);"> Limonciello, Mario
 &lt;Mario.Limonciello@amd.com&gt;</span><br>
</div>
<div dir=3D"ltr"><font face=3D"Calibri, sans-serif" style=3D"font-size: 11p=
t; color: rgb(0, 0, 0);"><b>Sent:</b> Friday, July 28, 2023 10:39 AM<br>
<b>To:</b> Huang, Tim &lt;Tim.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend=
 for SMU v13.0.4/11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">On 7/27/23 21:21, Huang, Tim wrote:=
<br>
&gt; [AMD Official Use Only - General]<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; *From:* Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
&gt; *Sent:* Friday, July 28, 2023 9:14 AM<br>
&gt; *To:* Huang, Tim &lt;Tim.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org <br>
&gt; &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an <br>
&gt; &lt;Yifan1.Zhang@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend=
 <br>
&gt; for SMU v13.0.4/11<br>
&gt; On 7/27/23 20:05, Tim Huang wrote:<br>
&gt;&gt; From: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
&gt;&gt;<br>
&gt;&gt; For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,<br>
&gt;&gt; the firmwares will handle that properly.<br>
&gt;&gt;&nbsp;Conceptually I'm aligned to this.<br>
&gt;&gt;&nbsp;But, just to confirm, have you already run some testing with =
this<br>
&gt;&gt; with current GPU F/W, BIOS and either 6.1.y, 6.4.y or ASDN?<br>
&gt; <br>
&gt;&gt; I checked with this on my side and saw success but I'm fearful<br>
&gt;&gt; that it introduces some of the fence expiration problems we<br>
&gt;&gt; had in the past and I'm just not seeing them for some reason.<br>
&gt; <br>
&gt; Yes, verified based on current BIOS and latest drm-next kernel and the=
 <br>
&gt; working FWs as the latest FWs<br>
&gt; may have some new issues.<br>
&gt; For this patch, it is asked by the FW guys, driver should not touch <b=
r>
&gt; RLC_CNTL in S0i3, let RLC FW to do that. If driver programs RLC_CNTL t=
o <br>
&gt; halt RLC, RLC cannot go GFXOFF exit sequence.<br>
&gt; <br>
&gt; The fence expiration should be still there by the delayed GFXOFF , but=
 <br>
&gt; this patch should be useful to help debug it as it avoids the system <=
br>
&gt; hang when the issue happens.<br>
<br>
&gt;&nbsp;So in that case you think that when the driver programs RLC_CNTL&=
nbsp; but <br>
&gt;&nbsp;GFXOFF was delayed sequence was going out of order and it trigger=
ed <br>
</div>
<div class=3D"PlainText elementToProof">
<div><span style=3D"">&gt;&nbsp;system hang.&nbsp; But now with this patch =
it will not hang but fences expire.</span><br>
</div>
</div>
<div class=3D"PlainText elementToProof"><br>
&gt;&nbsp;It makes sense to me.&nbsp; This patch shouldn't be any &quot;mor=
e&quot; harmful then.<br>
<br>
&gt;&nbsp;Reviewed-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<=
br>
<br>
&gt;&nbsp;For the delayed GFXOFF issue maybe we should revisit my previous =
idea <br>
&gt;&nbsp;for flushing GFXOFF requests.&nbsp; IIRC the most recent version =
was:<br>
&gt;&nbsp;</div>
<div class=3D"PlainText elementToProof">&gt;&nbsp;<a href=3D"https://patchw=
ork.freedesktop.org/patch/537888/?series=3D117965&amp;rev=3D1" data-auth=3D=
"NotApplicable">https://patchwork.freedesktop.org/patch/537888/?series=3D11=
7965&amp;rev=3D1</a><br>
</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">&nbsp;I agree.&nbsp; We can add thi=
s patch to the latest test build and check whether the issue is gone.</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">&nbsp;Thanks.</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">&gt; <br>
&gt; Best Regards,<br>
&gt; Tim<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/g=
pu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&gt; index ce41a8309582..222af2fae745 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&gt; @@ -1581,9 +1581,9 @@ static int smu_disable_dpms(struct smu_conte=
xt *smu)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For SMU 13.0.4/1=
1, PMFW will handle the features disablement properly<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for gpu reset case. Driver invol=
vement is unnecessary.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for gpu reset and S0i3 cases. Dr=
iver involvement is unnecessary.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev) || adev-&gt;in=
_s0ix) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP][0]) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 11):<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB3873DFD25AA068E593F046FEF606ABY5PR12MB3873namp_--
