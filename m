Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC68E7AD77
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 17:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D7F10E30E;
	Tue,  3 Oct 2023 17:03:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF53E10E2FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 17:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S640rEdSj5dm+GicaWdGsNbPx2P/pyu31UADewKMJkejao2/etlW3jHx8oieGyvkDbQF4lXe4dk6d1fgeCos5Ed2Qp7Ufi4XuD06sxkLYed/FyCV40yAD0Za1TN5HI/qOvwk5yIf7fxtF9o9Sonh3DA0x0A8JwCB/3LlmfDrU3AyGI/7pAtlHcPrMNMLDkK8tbUBgsnRsQnkJQF/mjY1Wmg5daqpIO3pFYSYRKh7uvy/VEWnALcoSiGYqUWex7kGQzc/t/UL9VY0JLswf2GHJ4s/Zg8390HmbTvJnKmGSlDc8dOysOgjUKitxKyOVKt75kb+aq0LlNH6CRduaPnToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfvjaZ4OgeRhh7xncjQ5ZCD9pfFnRPaacW57Yhols4Q=;
 b=WyA+0Pa/KI8NjWu8Tb3h5P6Jwj00i/H01z6jh73QYcqqtGU5jQZhlfBbu3GIe7S3EMOnI9J7AaHRsIEY0DvhF5EC8//oQ4mHV4Dn/HAQmdSNPtiHuQaxgDhNRRRJwScETs/ctBvPzZq1BuQoAINe3ZMpbd/AsOjKeoXnYUfhkQDO0+j4WTRofl2WPqzthxiOi4iDbLEU5oUZYL9kEI+1+10Qh6WZ9IMXGZ6jNerBtrcZUk5/1DApzR3UTnDdjanYRsEMHhcQSyiFElKKQLAqu9dybq0bd7S1Prf9OUsJzPTq4WAPiAMFpfRSwaOToyzrws2086ddGN/SPZF7TYTa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfvjaZ4OgeRhh7xncjQ5ZCD9pfFnRPaacW57Yhols4Q=;
 b=vfK0j4j7viZV6y530HpUfPQr3iU5oRlkkwvMukOnnXUF6EsURBmeBhpS2bZamDK1BdfVFS6JfxvbdUSuyOBkJXyd0TdPHVoOC/cRVic5KnvJSuCJTMfEjPYXs7PiX3lFRhKHQ9fCL188TWM+hrmCscGQVK8o/Bhdvol/Twtzsso=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 17:03:53 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58%4]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 17:03:52 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "LIPSKI, IVAN"
 <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Topic: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Index: AQHZ9VihCmnTItEhi0W/ARmiJPwWwLA4LUKOgAACTICAAACuqIAABPAAgAAW99A=
Date: Tue, 3 Oct 2023 17:03:33 +0000
Message-ID: <PH8PR12MB727924F9B244B9526CFC11F4F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20231002174754.1596197-1-ivlipski@amd.com>
 <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <284d3f39-071c-4451-839e-8840aecfc2a7@amd.com>
 <PH8PR12MB7279526F77BBC201BA660529F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <8fc58d31-a882-46b7-8852-c54a997af7fa@amd.com>
In-Reply-To: <8fc58d31-a882-46b7-8852-c54a997af7fa@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T17:03:32.426Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|PH7PR12MB6739:EE_
x-ms-office365-filtering-correlation-id: 8a2a1503-48ff-4f47-6b5a-08dbc432ad42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDPupqY7p3lSVbu6sc3PNH2HK3Xa+C/oArIWDmXHsA/hdpUR0TtpaebXCbYG8ra/wAuGr1mIoO/mWAm0GQRzsdI6E+7biiUYTJuPNx/80YwITOWfAkfF4f40cJ1DTT3Q4o5/t3kcEPg3SHlekVk0ccXdCXEemRdFTGxouKS1TRHmrEdOrrBiO/edvuDtuGUOdQQ4zhdHa3XUzk9BNdGdO1GMn8V2vDF4k7V0fVR5VmIF9x61WnZjICTNio5tboO8X9rO8tIMo7rGAO7dy90HApXTXp0Cb57VydLfWXttc7nbt3gslGrGBCZnaj4A9Lb+r+6LfppQ1OfWDGB02c1zRNVlYQOUrX05OAfJ/21MgqcR6F+Ts6Nn5ZDl1wkJGgAgapUaNbtTw9ccAfeuah80HAm9WgsuP3qjmAyvr5OrQ+QCe34Ahd+DKUjRPaFaVPKyjrwt5D5nxozEEYzC/PsaMnu77JsjvQzxAp+WFle/SANWZbXNd5pN92UJb8WRbMs3d5zv9FquQaBUiCm/WOf66LRj6fZyfPYcFZWGM4W+cqdbfF3EnX+4ZBV0W+pCJ5IE3Q8ITt/JEI+tWPvkdpWnqw/DuFb91W+MpShu7OpPINcxLxrKky8PS7aQGcqhxh6L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(55016003)(52536014)(54906003)(66476007)(110136005)(66946007)(91956017)(41300700001)(76116006)(66556008)(316002)(66446008)(64756008)(83380400001)(19627405001)(6506007)(122000001)(8936002)(8676002)(4326008)(7696005)(26005)(38100700002)(38070700005)(5660300002)(86362001)(53546011)(33656002)(6666004)(9686003)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EE1qlxag7D4cicfQ7blwTrkrQBlFvCL75rq7wvLKw3Wq7Xs5V3iD4uVt6PTJ?=
 =?us-ascii?Q?+gQfGHyJIIMdOfxs7kCLzOBmW4yP+5d3V5BFPzOmin8x+sqn2XcnE1mEUef1?=
 =?us-ascii?Q?FeVwRmdGQzbot5GEbr6WC3fGG74zfja+haxqZcwczUeNJ0+HSFmQFONQmsFi?=
 =?us-ascii?Q?Ifz3yQ4gjMfQp1szTA6sIIcOBwbGD4crOR4a5E/Rukfp/kVTJ+DAxyHyDVdw?=
 =?us-ascii?Q?RErHk48sU3q027jOh5RJxY/GOUTZPfcVUw53as+WOcYdEUcbXki8aqAgav1W?=
 =?us-ascii?Q?vTlBJoPm9TGvn9xgTJLDGfYdRwUx26dMiBOYr6pUaZXyXyDtvN0TlC7exDaw?=
 =?us-ascii?Q?g7QGuZxeLaJYlspgdxtus/7RPXCoralSh/DRNb1o2ZBni0lM1xFgzEa0/VYo?=
 =?us-ascii?Q?hkf8FLdJl7BySt7ZMU7/klIlPkzm5taicdu85CIm18Y+nDOY0h6gu3fWX3PJ?=
 =?us-ascii?Q?Qd0HlfV3fGsuKOJT7GHLsNNMiD9TRgI44DMa9YjwGqRIC0I+yAcM0kePaMDu?=
 =?us-ascii?Q?3yzx0dFTrgFcPNMkM/vtBn6gon6zv2/AWWUYSzRpNujg4me5nI2YGipo0dSA?=
 =?us-ascii?Q?sI8f3pSc4POM+phovaXMCwdDqy3T5OkTKKQquWSHC6ZTtfDqas3cOU+ncwHz?=
 =?us-ascii?Q?eUnVatxrL43DSFI/BYQgXKSYMmvt50WUDuTl7nyDYrhAbpdsdBvlAwf3cW5O?=
 =?us-ascii?Q?sAXLQknTbalkzPLs0iFvJXvCMN5Rbjoa831JVsSUFhZdKGTT1AWMWMUHn32C?=
 =?us-ascii?Q?5vKFBqlh61gCHXfDqqogCS2DgEbKqRZuFZEGKVz7DG+ZUn7MJUQ4+a8mpqJs?=
 =?us-ascii?Q?yCVhoV1R2YN3+VRgRwiLdhpa9W121o60erGQ+++wUA2eJUVH3r9womMVw3Ys?=
 =?us-ascii?Q?9CIhJhbSgwgfOwNmYiyYBitiXAo1NeAOokhJXN2cjgzN4/g4OXW9PpMwXZPo?=
 =?us-ascii?Q?1ejsRAVncmBQ+MmydFykyA+kWZntuwW2a4sx+UbrZaz1A3yq9SLZX8ABf06V?=
 =?us-ascii?Q?k+ZNVcg5rgLvuEq/Pak9/Cf24asayfQE4ZSmYeA/i7JWQNY6jKztSArvVq+o?=
 =?us-ascii?Q?3DtoKSFfeEYaaxw4p4C9PXvyIRdXMJace+894c1RuFw2/mH/qn+KDRWztM6s?=
 =?us-ascii?Q?yiI2INbKu6JTbx6UgXl3N8dU+7bqCvx3F1PATZyxscPFsFV9BTsxPDc6cC3P?=
 =?us-ascii?Q?/+IT04ZEJQuoBN2IXbD6L2bpYKVt7bb/IOLVtm4lO4qZ0fuJVcYUmdAkwL0j?=
 =?us-ascii?Q?cx2Ll+0WYHXAkX+Lq4jaOb+qTpf85BEq3VVxuDSShrkw8VAGF7XPgA5uBtOH?=
 =?us-ascii?Q?Ft6Oo+0yoToyxb3sBdQU6ljc3kT1e0VQtas/Lsn/uIFItC09l3B45Cp6vuqH?=
 =?us-ascii?Q?ia0Sdl9836nVNu4aCDbXWYouLHBoDlnWOqg4ZFSGav6o1/mBzyrA43bGzSrz?=
 =?us-ascii?Q?QD9pS2QUmHzbrgdFJ6XLj/TlrrcTp8bytVcedOAMnrgrGnr5SAAEfaIU6zoM?=
 =?us-ascii?Q?GnqdFU1BhZbpcssrrJwPbt9Ec4Ux9dCOxpEVdM+o5Q0yLi3MQ3ztigVZHVcv?=
 =?us-ascii?Q?wa41WXu4Gf2QkvVlNsA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB727924F9B244B9526CFC11F4F9C4APH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2a1503-48ff-4f47-6b5a-08dbc432ad42
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 17:03:33.6946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYho6H4bZdKnFJhlcXq8jBw0sc3WjV8mX+Hs5ITlbOzpSunzR7o+szcORtanfxeB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH8PR12MB727924F9B244B9526CFC11F4F9C4APH8PR12MB7279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

yes, it will disable replay.
________________________________
From: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Sent: October 3, 2023 11:40 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN <IVAN.LIPS=
KI@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.c=
om>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static s=
creen use cases"



On 2023-10-03 11:23, Lakha, Bhawanpreet wrote:
> [AMD Official Use Only - General]
>
>
> Why not just set replay_feature_enabled =3D true; to false?

Would that be the right fix? If so, we can send out a patch
with that instead.

- Leo

> ------------------------------------------------------------------------
> *From:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> *Sent:* October 3, 2023 11:20 AM
> *To:* Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN
> <IVAN.LIPSKI@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>
> *Subject:* Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for
> static screen use cases"
>
>
> On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:
>> [AMD Official Use Only - General]
>>
>>
>> Any reason for reverting this instead of looking into
>> "amdgpu_dm_setup_replay()" and "replay_feature_enabled" to see why reply
>> is being enabled?
>
> It causes a regression in amd_psr. Unless there's a quick fix, we should
> revert for now. It sounds like this can break existing support for
> PSR/PSR SU.
>
> Acked-by: Leo Li <sunpeng.li@amd.com>
>
> - Leo
>
>>
>> Bhawan
>> ------------------------------------------------------------------------
>> *From:* LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Sent:* October 2, 2023 1:47 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza
>> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
>> Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
>> Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; LIPSKI, IVAN
>> <IVAN.LIPSKI@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Subject:* [PATCH v2] Revert "drm/amd/display: Enable Replay for static
>> screen use cases"
>> From: Ivan Lipski <ivlipski@amd.com>
>>
>> This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.
>>
>> V2: Reword commit message
>>
>> [WHY]
>> This commit caused regression in which eDP's with PSR support,
>> but no Replay support (Sink support <=3D 0x03), failed enabling PSR
>> and all IGT amd_psr tests.
>>
>> [HOW]
>> Reverted the patch.
>>
>> Signed-off-by: Ivan Lipski <ivlipskI@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
>>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>>   3 files changed, 1 insertion(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 32156609fbcf..f69b2e9ecd98 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -66,7 +66,6 @@
>>   #include "amdgpu_dm_debugfs.h"
>>   #endif
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>>
>>   #include "ivsrcid/ivsrcid_vislands30.h"
>>
>> @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>           enum dc_connection_type new_connection_type =3D dc_connection_=
none;
>>           const struct dc_plane_cap *plane;
>>           bool psr_feature_enabled =3D false;
>> -       bool replay_feature_enabled =3D false;
>>           int max_overlay =3D dm->dc->caps.max_slave_planes;
>>
>>           dm->display_indexes_num =3D dm->dc->caps.max_streams;
>> @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>                   }
>>           }
>>
>> -       if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
>> -               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>> -               case IP_VERSION(3, 1, 4):
>> -               case IP_VERSION(3, 1, 5):
>> -               case IP_VERSION(3, 1, 6):
>> -               case IP_VERSION(3, 2, 0):
>> -               case IP_VERSION(3, 2, 1):
>> -               case IP_VERSION(3, 5, 0):
>> -                       replay_feature_enabled =3D true;
>> -                       break;
>> -               default:
>> -                       replay_feature_enabled =3D amdgpu_dc_feature_mas=
k
>> & DC_REPLAY_MASK;
>> -                       break;
>> -               }
>> -       }
>>           /* loops over all connectors on the board */
>>           for (i =3D 0; i < link_cnt; i++) {
>>                   struct dc_link *link =3D NULL;
>> @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>
>> amdgpu_dm_update_connector_after_detect(aconnector);
>>                                   setup_backlight_device(dm, aconnector)=
;
>>
>> -                               /*
>> -                                * Disable psr if replay can be enabled
>> -                                */
>> -                               if (replay_feature_enabled &&
>> amdgpu_dm_setup_replay(link, aconnector))
>> -                                       psr_feature_enabled =3D false;
>> -
>>                                   if (psr_feature_enabled)
>>                                           amdgpu_dm_set_psr_caps(link);
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index fb51ec4f8d31..440fc0869a34 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -29,7 +29,6 @@
>>   #include "dc.h"
>>   #include "amdgpu.h"
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>>   #include "amdgpu_dm_crtc.h"
>>   #include "amdgpu_dm_plane.h"
>>   #include "amdgpu_dm_trace.h"
>> @@ -124,12 +123,7 @@ static void vblank_control_worker(struct
>> work_struct *work)
>>            * fill_dc_dirty_rects().
>>            */
>>           if (vblank_work->stream && vblank_work->stream->link) {
>> -               /*
>> -                * Prioritize replay, instead of psr
>> -                */
>> -               if
>> (vblank_work->stream->link->replay_settings.replay_feature_enabled)
>> -                       amdgpu_dm_replay_enable(vblank_work->stream, fal=
se);
>> -               else if (vblank_work->enable) {
>> +               if (vblank_work->enable) {
>>                           if
>> (vblank_work->stream->link->psr_settings.psr_version <
>> DC_PSR_VERSION_SU_1 &&
>>
>> vblank_work->stream->link->psr_settings.psr_allow_active)
>>
>> amdgpu_dm_psr_disable(vblank_work->stream);
>> @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct
>> *work)
>>   #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>>
>> !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>>   #endif
>> -
>> vblank_work->stream->link->panel_config.psr.disallow_replay &&
>>
>> vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>>                           amdgpu_dm_psr_enable(vblank_work->stream);
>>                   }
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 314fd44ec018..ce75351204bb 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
>>           DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6), //0x40, disabled by defau=
lt
>>           DC_PSR_ALLOW_SMU_OPT =3D (1 << 7), //0x80, disabled by default
>>           DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8), //0x100, disabled by
>> default
>> -       DC_REPLAY_MASK =3D (1 << 9), //0x200, disabled by default for dc=
n
>> < 3.1.4
>>   };
>>
>>   enum DC_DEBUG_MASK {
>> @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
>>           DC_DISABLE_PSR =3D 0x10,
>>           DC_FORCE_SUBVP_MCLK_SWITCH =3D 0x20,
>>           DC_DISABLE_MPO =3D 0x40,
>> -       DC_DISABLE_REPLAY =3D 0x50,
>>           DC_ENABLE_DPIA_TRACE =3D 0x80,
>>   };
>>
>> --
>> 2.34.1
>>

--_000_PH8PR12MB727924F9B244B9526CFC11F4F9C4APH8PR12MB7279namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
yes, it will disable replay. <br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Li, Sun peng (Leo) &l=
t;Sunpeng.Li@amd.com&gt;<br>
<b>Sent:</b> October 3, 2023 11:40 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; LIPSKI, IV=
AN &lt;IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsu=
an (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 2023-10-03 11:23, Lakha, Bhawanpreet wrote:<br>
&gt; [AMD Official Use Only - General]<br>
&gt; <br>
&gt; <br>
&gt; Why not just set replay_feature_enabled =3D true; to false?<br>
<br>
Would that be the right fix? If so, we can send out a patch<br>
with that instead.<br>
<br>
- Leo<br>
<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;<br>
&gt; *Sent:* October 3, 2023 11:20 AM<br>
&gt; *To:* Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; LIPSKI, IV=
AN <br>
&gt; &lt;IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org <br>
&gt; &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za <br>
&gt; &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; <br>
&gt; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsuan=
 (Tom) <br>
&gt; &lt;ChiaHsuan.Chung@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for <br>
&gt; static screen use cases&quot;<br>
&gt; <br>
&gt; <br>
&gt; On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:<br>
&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; Any reason for reverting this instead of looking into <br>
&gt;&gt; &quot;amdgpu_dm_setup_replay()&quot; and &quot;replay_feature_enab=
led&quot; to see why reply <br>
&gt;&gt; is being enabled?<br>
&gt; <br>
&gt; It causes a regression in amd_psr. Unless there's a quick fix, we shou=
ld<br>
&gt; revert for now. It sounds like this can break existing support for<br>
&gt; PSR/PSR SU.<br>
&gt; <br>
&gt; Acked-by: Leo Li &lt;sunpeng.li@amd.com&gt;<br>
&gt; <br>
&gt; - Leo<br>
&gt; <br>
&gt;&gt; <br>
&gt;&gt; Bhawan<br>
&gt;&gt; ------------------------------------------------------------------=
------<br>
&gt;&gt; *From:* LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
&gt;&gt; *Sent:* October 2, 2023 1:47 PM<br>
&gt;&gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.=
org&gt;<br>
&gt;&gt; *Cc:* Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz,=
 Hamza <br>
&gt;&gt; &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@=
amd.com&gt;; <br>
&gt;&gt; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, Ale=
xander <br>
&gt;&gt; &lt;Alexander.Deucher@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.=
Li@amd.com&gt;; <br>
&gt;&gt; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; LIPSKI, IV=
AN <br>
&gt;&gt; &lt;IVAN.LIPSKI@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&=
gt;<br>
&gt;&gt; *Subject:* [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static <br>
&gt;&gt; screen use cases&quot;<br>
&gt;&gt; From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
&gt;&gt; <br>
&gt;&gt; This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.<br>
&gt;&gt; <br>
&gt;&gt; V2: Reword commit message<br>
&gt;&gt; <br>
&gt;&gt; [WHY]<br>
&gt;&gt; This commit caused regression in which eDP's with PSR support,<br>
&gt;&gt; but no Replay support (Sink support &lt;=3D 0x03), failed enabling=
 PSR<br>
&gt;&gt; and all IGT amd_psr tests.<br>
&gt;&gt; <br>
&gt;&gt; [HOW]<br>
&gt;&gt; Reverted the patch.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Ivan Lipski &lt;ivlipskI@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; &nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ---=
----------------<br>
&gt;&gt;&nbsp; &nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_crtc.c&nbsp;&nbsp;=
&nbsp; |&nbsp; 9 +-------<br>
&gt;&gt;&nbsp; &nbsp;drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 2 --<br>
&gt;&gt;&nbsp; &nbsp;3 files changed, 1 insertion(+), 33 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c <br=
>
&gt;&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; index 32156609fbcf..f69b2e9ecd98 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; @@ -66,7 +66,6 @@<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_debugfs.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#endif<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt;&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&gt;&gt; <br>
&gt;&gt; @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(s=
truct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_con=
nection_type new_connection_type =3D dc_connection_none;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struc=
t dc_plane_cap *plane;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool psr_fe=
ature_enabled =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool replay_feature_enabled =
=3D false;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_ove=
rlay =3D dm-&gt;dc-&gt;caps.max_slave_planes;<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;disp=
lay_indexes_num =3D dm-&gt;dc-&gt;caps.max_streams;<br>
&gt;&gt; @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(=
struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_dc_debug_mask &=
amp; DC_DISABLE_REPLAY)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 4):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 5):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 6):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 2, 0):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 2, 1):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 5, 0):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_=
feature_enabled =3D true;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_=
feature_enabled =3D amdgpu_dc_feature_mask <br>
&gt;&gt; &amp; DC_REPLAY_MASK;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* loops ov=
er all connectors on the board */<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D =
0; i &lt; link_cnt; i++) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D NULL;<br>
&gt;&gt; @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(=
struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; amdgpu_dm_update_connector_after_detect(aconnector);<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_backlight_d=
evice(dm, aconnector);<br>
&gt;&gt; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable psr if replay can =
be enabled<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (replay_feature_enabled &amp;&a=
mp; <br>
&gt;&gt; amdgpu_dm_setup_replay(link, aconnector))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; psr_feature_enabled =3D false;<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psr_feature_e=
nabled)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_set_psr_caps(link);<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.=
c <br>
&gt;&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; index fb51ec4f8d31..440fc0869a34 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; @@ -29,7 +29,6 @@<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;dc.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt;&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_crtc.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_plane.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_trace.h&quot;<br>
&gt;&gt; @@ -124,12 +123,7 @@ static void vblank_control_worker(struct <br>
&gt;&gt; work_struct *work)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fil=
l_dc_dirty_rects().<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br=
>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vblank_=
work-&gt;stream &amp;&amp; vblank_work-&gt;stream-&gt;link) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Prioritize replay, instead of psr<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if <br>
&gt;&gt; (vblank_work-&gt;stream-&gt;link-&gt;replay_settings.replay_featur=
e_enabled)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_replay_enable(vblank_work-&gt;stream, false);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if (vblank_work-&gt;enable) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (vblank_work-&gt;enable) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; if <br>
&gt;&gt; (vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_version &lt;=
 <br>
&gt;&gt; DC_PSR_VERSION_SU_1 &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_allow_active)=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; amdgpu_dm_psr_disable(vblank_work-&gt;stream);<br>
&gt;&gt; @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_=
struct <br>
&gt;&gt; *work)<br>
&gt;&gt;&nbsp; &nbsp;#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; !amdgpu_dm_crc_window_is_activated(&amp;vblank_work-&gt;acrtc-&gt;=
base) &amp;&amp;<br>
&gt;&gt;&nbsp; &nbsp;#endif<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;stream-&gt;link-&gt;panel_config.psr.disallow_repl=
ay &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;acrtc-&gt;dm_irq_params.allow_psr_entry) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_dm_psr_enable(vblank_work-&gt;stream);<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/include/amd_shared.h <br>
&gt;&gt; b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; index 314fd44ec018..ce75351204bb 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
LTTPR_DP2_0 =3D (1 &lt;&lt; 6), //0x40, disabled by default<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLO=
W_SMU_OPT =3D (1 &lt;&lt; 7), //0x80, disabled by default<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLO=
W_MULTI_DISP_OPT =3D (1 &lt;&lt; 8), //0x100, disabled by <br>
&gt;&gt; default<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_REPLAY_MASK =3D (1 &lt;&l=
t; 9), //0x200, disabled by default for dcn <br>
&gt;&gt; &lt; 3.1.4<br>
&gt;&gt;&nbsp; &nbsp;};<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;enum DC_DEBUG_MASK {<br>
&gt;&gt; @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
PSR =3D 0x10,<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FORCE_SU=
BVP_MCLK_SWITCH =3D 0x20,<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
MPO =3D 0x40,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_REPLAY =3D 0x50,<=
br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_ENABLE_D=
PIA_TRACE =3D 0x80,<br>
&gt;&gt;&nbsp; &nbsp;};<br>
&gt;&gt; <br>
&gt;&gt; -- <br>
&gt;&gt; 2.34.1<br>
&gt;&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH8PR12MB727924F9B244B9526CFC11F4F9C4APH8PR12MB7279namp_--
