Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000A2C05027
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 07:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9C010E69E;
	Wed,  8 Feb 2023 07:24:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB12D10E1F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 07:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqdpx+VTfAuE0fk7xu8kv/89NywlmE6O0ZTD65Kj839Y/8n/LzCTdoUKgcgEGOSLqC+z9vXiInrykQEfmIhUEzwSxQEisd2HcI+30GUZh58fvZ/9qk2l5OwobB2K63WVojlzd2F6gZTTOWHIxGimmjR9T9HPJfpbuYMCFu56x0gNts0Wi/DacSsIcDSM8/hzFi7hHTJuHcClFAiEAbLSwo80RsCsC4UgqOzSpkTDgYgiOCEyKK7BbPo+JXJq1VIl+VgdEDYf4dTq5hU7eOEfipIk2eQ31ovxbEE2GQqeYbiavRyGg/HK7pD1nKqJzbd2Qejb3zIxvA4VXb3kqvwzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SllOu65PVCXWPBaHizS4hDcqWs4iWu/uJW7YS3nSyio=;
 b=g/7Ah0BbktIe7hAaDqsNIME9Xalj353P1d0wEjpwEaTJ/EO97q+om99IS4D2MuOvBU1hfFhu5h19UsooM4p8BhNH8kXHEW1+H2JTptRHTSRiLnNQiDwiiurkIN/qR9fA0Y1n6Z0PA9VRL6DtQoCq2uZz3hPL5z8PYO5g/JemAu0fZ+Iwh5cUx1nXVboX6siDz7V6vyGzKg0XV1zfZWTPvw3pfHCzkWb3NUzParMbu9Y+1KCs2Y+/k+yw35zZNV8jwxeZ0KgT8eBRlkw9k24L5CwYw19cFYLPrN2y2lgD502BJTqYsvy0xesw9rECZgnzRqnnZw6LaFODCCZxHGtsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SllOu65PVCXWPBaHizS4hDcqWs4iWu/uJW7YS3nSyio=;
 b=YsosNZZGSRVkjo4pL2N2wTiDjdvwJLp5FTqWSYTaPncjYTJb6DotAwHXtOa8Jy9Y9WYAJHt2iPJVZvnHbhKGgs0Ndutan4rJ/CD7SAZcV/i1oWknebOvdgeZwtJeNLI7rkj4G89J/IuDGvSm7rTUToiijpgiuqGmvhPHcJOjx7I=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 07:24:40 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::9f2c:ea32:ce3f:8e3f]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::9f2c:ea32:ce3f:8e3f%3]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 07:24:40 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Align num_crtc to max_streams
Thread-Topic: [PATCH] drm/amd/display: Align num_crtc to max_streams
Thread-Index: AQHZOqmLwZa5fBc1kU2dh4hTxSQxRa7Dcu2AgAAZaICAAALbAIAAG0cAgAD6EOw=
Date: Wed, 8 Feb 2023 07:24:39 +0000
Message-ID: <DM4PR12MB52941358E6107112E350A6C195D89@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20230207040524.4020763-1-tianci.yin@amd.com>
 <8d9869ff-a674-fef6-5422-db444ec2d125@amd.com>
 <25a2f7fb-f701-fd32-a37d-4222b6242a11@amd.com>
 <803fd250-a96e-96ad-f1f7-4f867e7b74fd@amd.com>
 <4f49d41f-2bd6-af90-f469-01df9cc43317@amd.com>
In-Reply-To: <4f49d41f-2bd6-af90-f469-01df9cc43317@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-08T07:24:41.012Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5294:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: c727d693-5f26-4347-7048-08db09a58a6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qm/mOIYGJ429WRZvVRY3OlDDlgx49rV7ITF+seiysmSfBWHnJ73nGUuDpv5rD5F5y8Dp5EOC98HdrM6Mejp61+Ig+1dLRLVnva2PPFXmkzZw4QeRt6TfPa1bSKEupygnWbLbN/IOBshwdEGRM6BUPtFBx3Y2Sd9THtMl5HtFdkeNkJeCzbPoCw5VRmG7/8sANVpIdUqc0g4xd2OLAJsAbVHElNjjz0mkiiLXzTbtJZhDnsoxCNsiox0l6ddLPp8P+U8xGv2oGMBF8eXrFEDVuybYdnDWC9jQEAP92Zuluy0Sph7BCctBtzYcpvQoQdFoRPIqGrSjg45WNnEfKK3YDotdpAtymQTexd6gcsWJrIEVJCpuT8UNvKpW1y51gBqOm4guX9dDJmfmB/fNa5u59AFcO7euCvu8GQ4JHSe+1OPCpuVTd0QSxXxUcQUdKBdJAtVxxFdj9YhoAWf3kE2Td7EmS0CY5pzqvO2I3Qi10O3sZ2nP1+m6CE2IAaKH9woouh83IAN6SLSQti4Jrogl2XNty9+y9+NGxOx7hihDwWa4lQtN/AGbZOyeBTAIznR59T38WL6bzYAgiSpDNaPI5BZWsRacpQ4H/VprFOPi2C7GRkdF0aFF/hwtsK8LmfEuxmkGId1eG8pHcygiyGuyY+R2ldhZh9xbLpR5lylZu6WhNNc2KvUMZbwnvlm2Q8Cwrl7cVTaJ/qWVlRrTkelidg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(5660300002)(6506007)(86362001)(19627405001)(53546011)(38070700005)(9686003)(26005)(186003)(8936002)(2906002)(8676002)(66946007)(64756008)(66446008)(66556008)(66476007)(4326008)(76116006)(91956017)(122000001)(38100700002)(41300700001)(316002)(55016003)(52536014)(478600001)(71200400001)(7696005)(54906003)(110136005)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BfAJwheFLNBtGsyoxTKjrqiCgCv2I652J66FuZlK+ji3tnulW6IbbvjQFZrv?=
 =?us-ascii?Q?8L/vm0tyAblrnwJAbhIxZTto/mInUXu7REgNvb3N6y0s1KaQcEwNibmp7JU3?=
 =?us-ascii?Q?wtSbCVikqmb5V25XKwrQ+7ZHAw/ZG7/bY7df0RAyQWbboBA+rH0qKVemh0hJ?=
 =?us-ascii?Q?EWHZ1K/zyxm4+hGhqiKTnlez3IL2EMUSUIqeDwYNCNqwHJxVyqX6I/ZqaK1P?=
 =?us-ascii?Q?sGadZxYLypP7o6tQUC+HnaZSjI4Ce9dDb8jSUp60nBaayV4TV7NNbaJyvMm7?=
 =?us-ascii?Q?PRmmQTdSXnrQCVS92zWhkv03wF/bxWz0haHY4inrZOV0VVL24ACqZ77fMz4R?=
 =?us-ascii?Q?9o1i53UTqXMSelRMnJnDVEdTzQzUkAbOKG05LuPncFIgw/7lmfhhMI77Yzvv?=
 =?us-ascii?Q?Ixor+fzYypbVOdkGGFBT+arMsQd82XSgwoDj4u+RSuhk9x4WPIL73jyvwP4x?=
 =?us-ascii?Q?ynacDYkbpZMcUVjiOC39AmT5bmetw/8iHCNycfJb6+5nGQyVc/Fabm1D8VvO?=
 =?us-ascii?Q?PC+1IK8AWDXuiwmrq6o2nAaEje/DJwDMB4/7NgBATaIpQyzlYy2Se/xtcfg3?=
 =?us-ascii?Q?J7zzdYYazQ3Ed0GTvtNjvruersYrVbdgtvUdQDIiBlEBDa7OZqDkEgGBywB4?=
 =?us-ascii?Q?Cv2IlhK5GzE6prWNsRR/Hj0i7cyWHMGrrC9V5CJ6/MiCzszlMPDD0TOFf8wj?=
 =?us-ascii?Q?OS6ZnEVQK4FaAD2YYcyzlfxvRsML6jRJ8I41fEKQSEn27jfussommj+wpaLA?=
 =?us-ascii?Q?WYNkaMKIC2UaJqGSTGd6coGO2gawcfLm1cdT1ZU8B+2KkCYWv3C//66hr8uE?=
 =?us-ascii?Q?or0rioSSekBA0NqLMghu5D+9ubJvD6rev+bhR87kajE1MO36eDGIOAnm4Te6?=
 =?us-ascii?Q?oinjf5WcBFU7hft5G7JW6DrYNjNTwjle/Jwt5RWZ5jydZjoKuf2nO4aRJ5Vy?=
 =?us-ascii?Q?oUG2tA5Oeam00+aFK484lpUTKQVRhzqQMszEapcLgY/9TjeP4sUvLJeaG9Yz?=
 =?us-ascii?Q?4OsarBTgCihaYFey2n5lBQLTDipAjKGX3b9PSg9zF01G2ys5JkCuPq6V4qop?=
 =?us-ascii?Q?Un1mpqRPM4sPaodU8eQoA61xxGFUnx9mX6kpw7n/hr8mN0mlreAu2B4E3Mub?=
 =?us-ascii?Q?8Qn1i3oXxrcMND+8QKz/r9agjXjFbCgYpXhAXrnZUA5CQl9ySEYEPYePqo/T?=
 =?us-ascii?Q?4shJ8SUcaI21/4gka8Mm+VTKtLjg2ECi8SBu5Dcn0QsO1TWUnwmHeDhn6r2h?=
 =?us-ascii?Q?x12e5/s04++LtbSDoQb9wBEDrcXlVL1pIfPVS3SC+5MttkYvx+IzkJdq6wra?=
 =?us-ascii?Q?re/BD8q9FK5t0HMmt8u12CKVm1boOFukWvpAz3ntYUyjc4xH1PffGUmXRiff?=
 =?us-ascii?Q?CXYvD/ZuOJqg8iTl5jqyy6sksjizYSc35ZmqCWnC9//5dV03hMRtb73z/vDf?=
 =?us-ascii?Q?k0GIsK0OaF3ix/Vuvnu/wQdJ76GVdGpQ9LYaN6L4b3sYXexzB1w8zWy7oD4c?=
 =?us-ascii?Q?hksndYHiuavN5engnlUoQyjaTdHxgcjJ6Fd2S3Z0eK61rPlds7lvAx8VFVFA?=
 =?us-ascii?Q?Y8yIHf2/FP6/xLyBMUg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB52941358E6107112E350A6C195D89DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c727d693-5f26-4347-7048-08db09a58a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 07:24:39.9360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xnj/A89O5Iiz+3ZllXa/vGuuiqy/5esoqHsyhtn55ts9QL0hF/DYg5sYcsZhQzP581GxhRYMszKR7JNV7MWHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB52941358E6107112E350A6C195D89DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Thank you very much Harry and Hamza.

You are right,  adev->mode_info.num_crtc has already been updated, the vari=
ables that really need updating are
adev->mode_info.num_crtc, adev->vline0_irq.num_types, adev->vupdate_irq.num=
_types and adev->pageflip_irq.num_types.

I have made a new patch with title "drm/amd/display: fix dm irq error messa=
ge in gpu recover", please help to review.

Regards,
Rico
________________________________
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Wednesday, February 8, 2023 0:19
To: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@=
amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Yu (Charlie) <Yu.Wang4@amd.com>; Siqueira, Rodrigo <Rodrigo.Sique=
ira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: Align num_crtc to max_streams



On 2/7/23 09:41, Hamza Mahfooz wrote:
>
> On 2/7/23 09:31, Harry Wentland wrote:
>>
>>
>> On 2/7/23 08:00, Hamza Mahfooz wrote:
>>>
>>> On 2/6/23 23:05, Tianci Yin wrote:
>>>> From: tiancyin <tianci.yin@amd.com>
>>>>
>>>> [Why]
>>>> Display pipe might be harvested on some SKUs, that cause the
>>>> adev->mode_info.num_crtc mismatch with the usable crtc number,
>>>> then below error dmesgs observed after GPU recover.
>>>>
>>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>>
>>>> [How]
>>>> The max_streams is limited number after pipe fuse, align num_crtc
>>>> to max_streams to eliminate the error logs.
>>>>
>>>> Signed-off-by: tiancyin <tianci.yin@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index b31cfda30ff9..87ec2574cc09 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -4285,6 +4285,9 @@ static int amdgpu_dm_initialize_drm_device(struc=
t amdgpu_device *adev)
>>>>            break;
>>>>        }
>>>>    +    /* Adjust the crtc number according to the DCN pipe fuse. */
>>>> +    adev->mode_info.num_crtc =3D dm->dc->caps.max_streams;
>>>
>>> This would introduce array-out-bounds issues, since there are arrays of
>>> size AMDGPU_MAX_CRTCS that use num_crtc as a bounds check.
>>
>>  From what I can tell max_streams is always <=3D AMDGPU_MAX_CRTCS (6),
>> though we're not checking. Maybe it'd be good to check and print a
>> DRM_ERROR here if that's ever not the case (e.g., if we ever add
>> any new ASIC that has more streams).
>
> I have had UBSAN warns before commit d633b7a25fbe ("drm/amd/display: fix
> possible buffer overflow relating to secure display") was applied, so it
> seems to already be the case, maybe due to virtual streams.
>

Interesting.

On closer look I'm not sure why this patch is needed. We already
do exactly what this patch does at the beginning of
amdgpu_dm_initialize_drm_device:

>        dm->display_indexes_num =3D dm->dc->caps.max_streams;
>        /* Update the actual used number of crtc */
>        adev->mode_info.num_crtc =3D adev->dm.display_indexes_num;

Harry

>>
>> Harry
>>
>>>
>>>> +
>>>>        for (i =3D 0; i < dm->dc->caps.max_streams; i++)
>>>>            if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
>>>>                DRM_ERROR("KMS: Failed to initialize crtc\n");
>>>
>>
>


--_000_DM4PR12MB52941358E6107112E350A6C195D89DM4PR12MB5294namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Thank you very much Harry and Hamza.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2 ContentPast=
ed3 ContentPasted4">
You are right,&nbsp; adev-&gt;mode_info.num_crtc has already been updated, =
the variables that really need updating are</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2 ContentPast=
ed3 ContentPasted4">
adev-&gt;mode_info.num_crtc, adev-&gt;vline0_irq.num_types, adev-&gt;vupdat=
e_irq.num_types and adev-&gt;pageflip_irq.num_types.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2 ContentPast=
ed3 ContentPasted4">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2 ContentPast=
ed3 ContentPasted4 ContentPasted5">
I have made a new patch with title &quot;drm/amd/display: fix dm irq error =
message in gpu recover&quot;, please help to review.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2 ContentPast=
ed3 ContentPasted4 ContentPasted5">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2 ContentPast=
ed3 ContentPasted4 ContentPasted5">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2 ContentPast=
ed3 ContentPasted4 ContentPasted5">
Rico</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wentland, Harry &lt;H=
arry.Wentland@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 8, 2023 0:19<br>
<b>To:</b> Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;; Yin, Tianci (Rico)=
 &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@list=
s.freedesktop.org&gt;<br>
<b>Cc:</b> Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Siqueira, Rodrigo &=
lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd=
.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Align num_crtc to max_streams<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 2/7/23 09:41, Hamza Mahfooz wrote:<br>
&gt; <br>
&gt; On 2/7/23 09:31, Harry Wentland wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 2/7/23 08:00, Hamza Mahfooz wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2/6/23 23:05, Tianci Yin wrote:<br>
&gt;&gt;&gt;&gt; From: tiancyin &lt;tianci.yin@amd.com&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [Why]<br>
&gt;&gt;&gt;&gt; Display pipe might be harvested on some SKUs, that cause t=
he<br>
&gt;&gt;&gt;&gt; adev-&gt;mode_info.num_crtc mismatch with the usable crtc =
number,<br>
&gt;&gt;&gt;&gt; then below error dmesgs observed after GPU recover.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_crtc_irq_state: c=
rtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_crtc_irq_state: c=
rtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_crtc_irq_state: c=
rtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_pflip_irq_state: =
crtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_pflip_irq_state: =
crtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_pflip_irq_state: =
crtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_pflip_irq_state: =
crtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_vupdate_irq_state=
: crtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_vupdate_irq_state=
: crtc is NULL at id :3<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; *ERROR* amdgpu_dm_set_vupdate_irq_state=
: crtc is NULL at id :3<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [How]<br>
&gt;&gt;&gt;&gt; The max_streams is limited number after pipe fuse, align n=
um_crtc<br>
&gt;&gt;&gt;&gt; to max_streams to eliminate the error logs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: tiancyin &lt;tianci.yin@amd.com&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c | 3 +++<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; 1 file changed, 3 insertions(+)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt;&gt;&gt; index b31cfda30ff9..87ec2574cc09 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br=
>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br=
>
&gt;&gt;&gt;&gt; @@ -4285,6 +4285,9 @@ static int amdgpu_dm_initialize_drm_=
device(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; break;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; /* Adjust the crtc number=
 according to the DCN pipe fuse. */<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_crtc =3D dm-&gt=
;dc-&gt;caps.max_streams;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This would introduce array-out-bounds issues, since there are =
arrays of<br>
&gt;&gt;&gt; size AMDGPU_MAX_CRTCS that use num_crtc as a bounds check.<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;From what I can tell max_streams is always &lt;=3D AMDGPU_MA=
X_CRTCS (6),<br>
&gt;&gt; though we're not checking. Maybe it'd be good to check and print a=
<br>
&gt;&gt; DRM_ERROR here if that's ever not the case (e.g., if we ever add<b=
r>
&gt;&gt; any new ASIC that has more streams).<br>
&gt; <br>
&gt; I have had UBSAN warns before commit d633b7a25fbe (&quot;drm/amd/displ=
ay: fix<br>
&gt; possible buffer overflow relating to secure display&quot;) was applied=
, so it<br>
&gt; seems to already be the case, maybe due to virtual streams.<br>
&gt; <br>
<br>
Interesting.<br>
<br>
On closer look I'm not sure why this patch is needed. We already<br>
do exactly what this patch does at the beginning of<br>
amdgpu_dm_initialize_drm_device:<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;display_indexes_num =
=3D dm-&gt;dc-&gt;caps.max_streams;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update the actual used nu=
mber of crtc */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_crtc =
=3D adev-&gt;dm.display_indexes_num;<br>
<br>
Harry<br>
<br>
&gt;&gt;<br>
&gt;&gt; Harry<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; =
dm-&gt;dc-&gt;caps.max_streams; i++)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; if (amdgpu_dm_crtc_init(dm, mode_info-&gt;planes[i], i)) {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;KMS: Failed to initialize crtc\n=
&quot;);<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB52941358E6107112E350A6C195D89DM4PR12MB5294namp_--
