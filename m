Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AD4C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 15:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F1C10E158;
	Thu,  1 Jun 2023 15:45:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F11210E158
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 15:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd+2todUPAcs0RKA6NQuO1J2Ioav8lPhellJhc3FCNfstVzFKHYfHthYip3CsyC3Xl9rLaEZwptASn3kk16yeC/gc/2lZxiRKLik6cDwtF6+kxZGWusyYNfNFyW9ki8z2b/KjojkK8G+HbLRByrPzmL0ErDroHZiAr3PpSqgOVrI6FYir8EFFzywUJ6pEnHSbePEulbpytBdLn/0+RFsbWuY5P9buk0lPltNH3t8YM8VxOswy75omYdfpgDAIMmaaf11RJ/3DD4OoaimbCOq8Pjulsi03DW0JN40HgDkuNg4WMZj7KfCjsLwsK9tHEd5QcS8G3JGz+wqJXkf0gVLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0bAExGeCrF9AMWMCnZnS0L8rintU5YIqSQ+QQq14Hg=;
 b=Nzly0YTk1t9KjzjedZAdyajG6tiYMxXGM1d+iW1hUGo9NLzQDkvQIq1xC7R9RxDD8IjpSI8hkeSkDeLZk9UQ4ngP+dXgEEUVkf3kdIEYrdXZ4FDvVG+Jnud6PfEQAqYOVlTiYvGd/m2wybFAAGCqfp9Dag/xZn8zPDWcKLp2YZj8XWoLmx/+urbwthgPp3tBK3iqgYgC/TtXCix67oRt7g1IpoVsuIPhlqMXycVIprUrumoeKUjWUtjg9scR+F5gGqU1VCrNs4ji86s//x0hlcGdE56jQBy72KalemnNvmmI6V2Tz756H5IbCgqDVG49iWQTJoCnpzZS4s+NSt5XvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0bAExGeCrF9AMWMCnZnS0L8rintU5YIqSQ+QQq14Hg=;
 b=zeN1nToyULQ4dsoio/zoX9yYir/EfiJWeh1t6Qk9+JMTXqsN7FQhJgwD4bpuRXh4tzxku8VRMoVdfnQ7OSl0Vg7mZZb4OizSWRXqpv/38sJxbqriCC0mWGktRDuTUT08n5E67Wpnqfkif1XqnxwdnxKOHUsjwn8Si87E4E6/SNQ=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 15:45:42 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::eeaf:2747:9c3b:cabb]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::eeaf:2747:9c3b:cabb%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 15:45:42 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, "Zhuo, Qingqing
 (Lillian)" <Qingqing.Zhuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chalmers, Wesley" <Wesley.Chalmers@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Topic: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Index: AQHZbulXfd4e8U1ZekaELAq8to+gF69R7OCAgAChUyWAAAglsYABEDIAgAB+wQCAAKsfAIAgSsEAgAE6T4CAAAfJ7w==
Date: Thu, 1 Jun 2023 15:45:42 +0000
Message-ID: <CH0PR12MB528437770699502A9A26F3A38B499@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
 <9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net>
 <CH0PR12MB5284513F3548D749845BD7B48B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284BDF5F23009597E1503E38B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <714c875f-21f1-7e29-fb39-4a1f97eb712f@daenzer.net>
 <14582e0e-58cb-02df-50ae-1af22d194b29@amd.com>
 <ea2f979e-730a-4bea-4092-3798f718ce0d@daenzer.net>
 <8e0d6d87-0f73-1ae0-bce8-8b6231e6c068@amd.com>
 <aca2a2e5-76c3-4df9-336e-2d9060333389@daenzer.net>
In-Reply-To: <aca2a2e5-76c3-4df9-336e-2d9060333389@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-01T15:45:41.070Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|SJ2PR12MB8944:EE_
x-ms-office365-filtering-correlation-id: 67e81561-a729-4804-b806-08db62b7418e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQ9eo7Y0sYemVB35DzhMELXGVFxowsaGzi5GOygMV277tRHWLnN+3K6tzj0UiXQrJKl+w7sfYsp/U88Z6n2NW28DxlyCppcG/LVBfSQ2B6fXQ51ueiWfocISYZtkTPtNTMco7TLEJLktSuyahpmZT5q6d2xg7rsfYPKTJGv324BrB5ZkveFSNT+b4NXCZDeDtwTbb8/sUbkbWWFQMrvd3/m1HSQYCOhY50jVFntd9tx02ytWTqgqms0qpl30qTZeEyxLOoiaXmfchd2J2SM0ZI9bVas9vL661nSVa2VPxObwnKhW2YD0v7sUVd4lfUTc8xqlHtmH8QNvKHxWZ1ztJDWbq0A1wg8JuSazGeX+jS8dmPSpjzGdSq05BirvriTN9TqSMkknHqIXxBwT7c6MhXxXljMRcZ+fARTmLvXWzICNhMlL/pRmOXcu66B/7fqFrleILLWKcQYrL6DY3P4vHbwjKvjxMw3Ku6mjBiydwFH5FLX72UV1xz6q/vE4TwFCJx1RtFiheISeNWoGJ+dtSzrUeYSvG+ygwoA0RPiFuMGLI2wzshPfiBfRL/oH044pe14SlVBIDYHvwBzLKl7LXIvRmAq9ZMqCP/drltERHh4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(166002)(52536014)(8936002)(8676002)(83380400001)(122000001)(41300700001)(966005)(38100700002)(4326008)(6636002)(316002)(19627405001)(38070700005)(66946007)(64756008)(66446008)(66476007)(76116006)(26005)(86362001)(7696005)(66556008)(91956017)(110136005)(54906003)(71200400001)(5660300002)(66574015)(186003)(9686003)(55016003)(53546011)(6506007)(33656002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vw+Mzz4cF/Pm6w/F+aWTJS9SlKHRN36KJ2440U/A/GVgJ8lHkojKDBKqmV?=
 =?iso-8859-1?Q?BS6DpZr3tzbjVxSGSlcP3wvLCFTakXna3s9+AyF82DrwMr673B4kexBXg7?=
 =?iso-8859-1?Q?dkEUKX856Y3oRA1pkwz6wGQuiFO82sQok3wYpYUCRNaUJrNEXFiV19VGXp?=
 =?iso-8859-1?Q?ELm/aqnDRq95xMlLvN6DpI5nHdaEZ1Rro6nGODEBe8TakuMSLDYGqxlI+i?=
 =?iso-8859-1?Q?uu5dJj3ZkS8+iBsS1Z4P1q0UdYUjIKn5R0CRiBZLX43J+gLqcplpqoNHqA?=
 =?iso-8859-1?Q?WBWPCrqHE4gWPgLwUQspbFC+3bsPH5BWxRnJTVa10TWqQMShN9ah2R9rcS?=
 =?iso-8859-1?Q?5/3URlL/cLJyhH5SNiomzhlfcxyDcrMyDsXDElhTSYLXrJGyKPDdFy+CNu?=
 =?iso-8859-1?Q?dtw77EmoiN5DxsyxSZWKexIRfMzuQ49NOEKX7qVHPIHEp0TsLpodpCoj0x?=
 =?iso-8859-1?Q?8I7xUEzx1kqtyjzOQJBlRaHAfafEtMnWDdP4tYBTPY1xcChrzfed45JRxj?=
 =?iso-8859-1?Q?By40zbecaW8fI14teEFbj8isYEbSQnCiy/ixJA/QhetUIbDMgIhk0HthBm?=
 =?iso-8859-1?Q?U36gl0ndg9LJtc2e4edOIsm2UTl0Dz3cu61T6ui6EvBJCoHlTfU28FmbGy?=
 =?iso-8859-1?Q?SRznVz5EP2JxhOChTvAXem0AnyyMcPFNWtwJfLDZKzrHpcytcQSwcLvG3f?=
 =?iso-8859-1?Q?2YGnJgqeqN6hVlRwwzU0/bqxG1ms+M0buvAbAEutOXjcIcdMbkDhtAhkGz?=
 =?iso-8859-1?Q?L3GTAEhzlZe1CPc1sfgDhAV7AurGQyijclAJ6nCEBehL1SM1RBGd1DwkFn?=
 =?iso-8859-1?Q?RnaQJYsdNqE1dN8m+9PvHzicfaz70D1BoigXRwgs0yrc2XjIGRBdbZUPW5?=
 =?iso-8859-1?Q?xiJYN0tyTxyJeaPV3kgtwcma8DVOIEJi5JIoSW9GdtfM3aWYuahh2NsTtE?=
 =?iso-8859-1?Q?/vRbhIYo1B4dxqRAMTcMmhlcn6fPN6UON21weMIAbKCx26Pw2cLqXmRHE/?=
 =?iso-8859-1?Q?lQRRd31HQAFOIscIp5b9ZDX4xtGU3PCjX4y93zBNdlVMYVelpJdZrX2BGj?=
 =?iso-8859-1?Q?qwHnGbusxxIWOojDTxvMm/mFeNSn2rVGYQMnscDQGkHc3cMRWSWu1sAW0f?=
 =?iso-8859-1?Q?P5rlxMlJc+PPimOEPl9RMRfbLAq5AF/3y81xxCdAtONjAAK61F2swtdERr?=
 =?iso-8859-1?Q?m84mRneVUdsG9MWbCiStW3SZua/L9b5jLiG3eKQe4f6s7DDFw+e08945qk?=
 =?iso-8859-1?Q?2kTQUn71lRQXM2/LzruubT/uLUOLhBv30LpbgRWwCvJJRBvbUCW3YIYE/1?=
 =?iso-8859-1?Q?StBa5pIIBNbSs36/vPqQZ3NYOAvCrvdrLdxVUiciFnw3UvrBbB4PrsVQXq?=
 =?iso-8859-1?Q?ajLx30fPkh83L7B/euDHqKdz3/cbedBVvTrSypA6+9Nq5knVg2iimr1VuF?=
 =?iso-8859-1?Q?yRNX/sl9yfyJ+WIMMxNsNi4xbxgdpnMZptqQGfLu7qjeIya5OoeeFNwg6H?=
 =?iso-8859-1?Q?+FXoUPxnOpaZ9+Z+6nJ6+ZIIDoYnni3RRZpOzP1AxX7vGleJiLm8fHl78e?=
 =?iso-8859-1?Q?vX/lxtChWdJKQl9BsXOxe2RwBKzjUuxka1zv0TUth5HE6hNkjdZS5c/Ed2?=
 =?iso-8859-1?Q?krHIl1Ajy98vI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528437770699502A9A26F3A38B499CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e81561-a729-4804-b806-08db62b7418e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 15:45:42.0894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZ8yPO6pICJxyNMW2RuqV7HAaQgW9+Ijl4Ioy7/17/4gnHhxSFT5FA/KaosFNuXSKL4qQsPLnbejbeoFwddbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB528437770699502A9A26F3A38B499CH0PR12MB5284namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

I see, thanks for the info. I'll try repro'ing it locally. But do you have =
the open userspace stack from AMD's packaged driver installed ? If not, cou=
ld you please try downloading from https://www.amd.com/en/support/linux-dri=
vers and install just the open components? You can run:

sudo amdgpu-install --use-case=3Dgraphics --no-dkms


--

Regards,
Jay
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Michel D=
=E4nzer <michel@daenzer.net>
Sent: Thursday, June 1, 2023 10:59 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing (Lillian) =
<Qingqing.Zhuo@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freed=
esktop.org>; Chalmers, Wesley <Wesley.Chalmers@amd.com>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrig=
o <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <=
Solomon.Chiu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <=
Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>;=
 Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit

On 5/31/23 22:14, Aurabindo Pillai wrote:
> On 5/11/23 03:06, Michel D=E4nzer wrote:
>> On 5/10/23 22:54, Aurabindo Pillai wrote:
>>> On 5/10/23 09:20, Michel D=E4nzer wrote:
>>>> On 5/9/23 23:07, Pillai, Aurabindo wrote:
>>>>>
>>>>> Sorry - the firmware in the previous message is for DCN32. For Navi2x=
, please use the firmware attached here.
>>>>
>>>> Same problem (contents of /sys/kernel/debug/dri/0/amdgpu_firmware_info=
 below).
>>>>
>>>> Even if it did work with newer FW, the kernel must keep working with o=
lder FW, so in that case the new behaviour would need to be guarded by the =
FW version.
>>>>
>>>
>>> Agreed. Were you able to repro the hang on any other modes/monitors?
>>
>> Haven't tried specifically, and this is the only system I have with VRR.
>>
>>
> Hi Michel,
>
> I've fixed a related issue on Navi21. Could you please try the attached D=
MCUB along with the patches to be applied on top of amd-staging-drm-next an=
d check if the hang/corruption is gone?

Thanks, though I'm afraid that made it kind of worse: Now it already hangs =
when Steam starts up in Big Picture mode. Same with the new DMCUB firmware =
or older one.

This time, only

 amdgpu 0000:0c:00.0: [drm] *ERROR* [CRTC:82:crtc-0] flip_done timed out

appears in dmesg.


--
Earthling Michel D=E4nzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--_000_CH0PR12MB528437770699502A9A26F3A38B499CH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
I see, thanks for the info. I'll try repro'ing it locally. But do you have =
the open userspace stack from AMD's packaged driver installed ? If not, cou=
ld you please try downloading from
<a href=3D"https://www.amd.com/en/support/linux-drivers" id=3D"LPNoLPOWALin=
kPreview">
https://www.amd.com/en/support/linux-drivers</a> and install just the open =
components? You can run:<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
sudo amdgpu-install --use-case=3Dgraphics --no-dkms<br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Thursday, June 1, 2023 10:59 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqi=
ng (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; amd-gfx@lists.freedesktop.org &=
lt;amd-gfx@lists.freedesktop.org&gt;; Chalmers, Wesley &lt;Wesley.Chalmers@=
amd.com&gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;=
Roman.Li@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Lin,
 Wayne &lt;Wayne.Lin@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@=
amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac,=
 Pavle &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe c=
ommit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 5/31/23 22:14, Aurabindo Pillai wrote:<br>
&gt; On 5/11/23 03:06, Michel D=E4nzer wrote:<br>
&gt;&gt; On 5/10/23 22:54, Aurabindo Pillai wrote:<br>
&gt;&gt;&gt; On 5/10/23 09:20, Michel D=E4nzer wrote:<br>
&gt;&gt;&gt;&gt; On 5/9/23 23:07, Pillai, Aurabindo wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Sorry - the firmware in the previous message is for DC=
N32. For Navi2x, please use the firmware attached here.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Same problem (contents of /sys/kernel/debug/dri/0/amdgpu_f=
irmware_info below).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Even if it did work with newer FW, the kernel must keep wo=
rking with older FW, so in that case the new behaviour would need to be gua=
rded by the FW version.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Agreed. Were you able to repro the hang on any other modes/mon=
itors? <br>
&gt;&gt;<br>
&gt;&gt; Haven't tried specifically, and this is the only system I have wit=
h VRR.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Hi Michel,<br>
&gt; <br>
&gt; I've fixed a related issue on Navi21. Could you please try the attache=
d DMCUB along with the patches to be applied on top of amd-staging-drm-next=
 and check if the hang/corruption is gone?
<br>
<br>
Thanks, though I'm afraid that made it kind of worse: Now it already hangs =
when Steam starts up in Big Picture mode. Same with the new DMCUB firmware =
or older one.<br>
<br>
This time, only<br>
<br>
&nbsp;amdgpu 0000:0c:00.0: [drm] *ERROR* [CRTC:82:crtc-0] flip_done timed o=
ut<br>
<br>
appears in dmesg.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://redhat.com=
">
https://redhat.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and Xwayland de=
veloper<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528437770699502A9A26F3A38B499CH0PR12MB5284namp_--
