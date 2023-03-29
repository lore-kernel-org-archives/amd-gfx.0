Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DE7C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 06:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E6210E4BD;
	Wed, 29 Mar 2023 06:14:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1D310E4BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 06:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TECuG1Rp/zyEJBp+42PkVU8/e1JjuqpSeAuTu6vwV+U2sce2eRFQVrD9ZzwAwlQLru/gLuX4ATHg1dbcTl3P2HilQNiG1X4J9xyEZY9q7CUEQOXdB5/aCbDD38+68Z9m5uR37uppgvdX0mNdmFfqsoh5aseywT6NWbthSLy2SAfb1UiHaVoF8rjVGZhSaLafVjdrm6I2hmZ1ipRqP2hqxjAMgZND2CJ+qNzvHOjP2l//pQMjlgD4wVdyCEXPMz39mA3UWEcFYMdpT3fuGSd/TQK82b8VrteF4FsTxD59s8ELdVo0VahezXrUxRwng4oHn7zX2uonBfOK1POff8tM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXxMV0R8g60dNCwAgbwTQNRuNvpkDICu+f78dxRyl0M=;
 b=e/WR+GtaQIUj/w2ZO6MIZu/Wuou0oKQK+5OPxqjRxVjBNtQzLJv2jYcB3pBl5foVzXHt4JiuLssqxd4aTCI8hbl4GyhDf1XB+Y+KqIhjDq0ZHlCKXjgfYjZ6bJ9MCVu0wa/4cP98YJQZv5SiHPY1Dw7ZvY8pP+ZcVomdMmHlUYgYI1BOJUjfdMgSbkyK5yGg/gid6lRAW/Z6S1H4MSF5sxLfiKN9nofgZ+Wpdw+sDOM9VVzrb8qXDKzksQZI08V2NBpI83eoPsMG+vewhu8O3AQFKLJ8yVZef1t6nLPtZFkZJSo4+Z/4hxpu6UJfVTm090VMCQkI7dUXparDJeFTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXxMV0R8g60dNCwAgbwTQNRuNvpkDICu+f78dxRyl0M=;
 b=TOJnvL4w8PysHNs4+Dn4t7xi1vsxMO54F+5MIyFthIALp/kxjjnyiFzgmIzEu9Pumu2yM2Wa94MwFoJjsPnwOvuAUuhCC0vqmKN/4pBxTOfIoPuLnvFTSZ+Y6BNEd5Myn52LF4ucVizEUySom29JJsFOgKAnWvWX1gb7ZUqbtn4=
Received: from DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) by
 CH2PR12MB5002.namprd12.prod.outlook.com (2603:10b6:610:6d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Wed, 29 Mar 2023 06:14:06 +0000
Received: from DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::e17b:54ee:be6:3593]) by DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::e17b:54ee:be6:3593%7]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 06:14:06 +0000
From: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some asics
Thread-Topic: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some asics
Thread-Index: AQHZYWpSuafeTmQ27UqwjB9a0xhk3K8RBLmAgAA80DA=
Date: Wed, 29 Mar 2023 06:14:06 +0000
Message-ID: <DM4PR12MB6134C483BDAD2B93CE4610BD90899@DM4PR12MB6134.namprd12.prod.outlook.com>
References: <20230328114141.1154742-1-Tong.Liu01@amd.com>
 <DM6PR12MB26192C4687DE015320972F2FE4899@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26192C4687DE015320972F2FE4899@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Evan.Quan@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-29T06:13:57Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1df8a165-5084-4641-a497-290ca4465b34;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-29T06:13:57Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bb348fce-e467-40ee-b819-5d7c9e06a196
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6134:EE_|CH2PR12MB5002:EE_
x-ms-office365-filtering-correlation-id: b088d183-7e6a-4265-954e-08db301ccd4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dnlmZTOCZWBej5ZKdATOjJVZJjikssHx5GViJu6m+M5kTGeuu1+2yVJwoeOaAbhf+uQNkJIpybVkw+8+5FbrGbP6IzY0TJ/Y/br36DFcKPkI5g3aWfq2rANtTEGbw4/9bHRMVVGCruGesEWqvL4o35NBkqn2K+uT4zp5psnx5uLq06BE08flzzaPLfFBPpS1kZYNlO3TCsjmhzOY8OVuuvFvfKeoJs32xjMrQKx/Yv9sYqWlfgA2vmKFfK8WrVqz6mI3pfhN8G0WLKYjH1Eth5GbHQcxTi+SsFeCWuYv27m5pNUTmQb1GscP5e09ik5bGupecGDTKjxgUvBsv8wQ4+oz2/MnDdpDIXHMNSO8D31MMGFwiFUqLOGQz5lPR90J80JXKMphQLoCmuglEAcCJ2i9McFYFmMZPGOSIovGkwN8KADkf67dOPx1HPrhHftF/wmgsvg3LbUe7kCwGD1mr4Qmg5sH3EHGjaua8Ef+HtEFcoU0Xby00bMeC26AcvSPw6zZoOyrrytJIlhAuFbFA6HDvbFOzfGHM30Qlrso7DoNh2kt7Is5QsuM3roiWYNAknUuIq1C5doIciPXVKAvZhOqUOBO1aJ1MYbWijcYT0dKq2DwVetI7fqz/4ukZkl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6134.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(26005)(8936002)(54906003)(5660300002)(83380400001)(55016003)(53546011)(186003)(64756008)(33656002)(122000001)(66476007)(86362001)(9686003)(76116006)(66446008)(66946007)(38070700005)(66556008)(38100700002)(4326008)(8676002)(41300700001)(52536014)(110136005)(7696005)(6506007)(316002)(478600001)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WnNIbVpGQTZmU3Q5c1JIRGhnOGd3YmJwUlhjUENHUjdvNnNuTXcwSFY4?=
 =?iso-2022-jp?B?MWFuRVpaSTh3QUo1YkxESnBoUXMrVm55YTJ4M1pBbG8zT3V3akszNG5u?=
 =?iso-2022-jp?B?TjhrVzc1cXoxWGF2bU1oYk4zZVVRRUd5Ui8rV2N2WlNiVlgvWjd5eDV2?=
 =?iso-2022-jp?B?azVmY2w3WUJaMFJiTUVEOXJhV3NEdmNNV2EyVmR4N0xBemg1ak0zQm9t?=
 =?iso-2022-jp?B?aFB3ckJJV1hpRzFVVjlvbTlrL0xadHFoK1FYOWNOVW82RTRHV0hwcGo3?=
 =?iso-2022-jp?B?cFVoWmJLR29pOWN2cVZ6aW9jZVZ5c0VRK2VsR05QTEU1em4xQ1YyUTJ4?=
 =?iso-2022-jp?B?SE9LMDJCNHBBYVJaY0hVVVRLVGNvMjdUQTk5YmxHWDR4c09MZjNVZHZV?=
 =?iso-2022-jp?B?U1B2TkdBamZjYUlrSnRVdU9LZ1htNE9SR0lhYzI2MGlVclp2L2MxcXQr?=
 =?iso-2022-jp?B?WUZhY1JNYzR3enhWQlJNc1l5YW0yNHNLdlpLUTRCRTY1NEd0b3B3ZUIr?=
 =?iso-2022-jp?B?aXYvUEZsWWJmRndLdmRmbTNPbmJXc2lESmg5NTQxM2s0SU9QNWlmYnRP?=
 =?iso-2022-jp?B?ZERmdlZvWlgxUmNidEFCbGxXd0g4dmNWelFHcE9OUFZtcU41VXRKTmNE?=
 =?iso-2022-jp?B?QTlxSHJIMk1kdC9HakZLV0hBT25rTjFoQVQwZldkUUEwdnJ6UlRmN1Jn?=
 =?iso-2022-jp?B?OENVamxQa3cvcmNraTFOOWFhOVFFWnlXNFBjZHR1ZzRSSENNM3hudy8w?=
 =?iso-2022-jp?B?bXpSYVF3NVpqbzM3NExKNFRLTFRGYmdKVk9FakJKa2xja2dicHpBQloy?=
 =?iso-2022-jp?B?NHd5Q3IxQXVkNUV3a2tMZ0thWGNhVktqdjZlNXF3c2hIV3VwVDBKNnR0?=
 =?iso-2022-jp?B?Wk1RQURXVzdFdWtkOHhKSHROeW1mRm5UdGJwemxGVk9zRThaeVJwQVZY?=
 =?iso-2022-jp?B?eEErcjJwV1EvK1hscE9qbzE4eDdzT3lKTGZGSWg4QXpGbWNGS1BtOWZY?=
 =?iso-2022-jp?B?NEhrSWZaSUtxZ0NOcUhTbFdUT2dIUnh5bjFFZzhwekxyUEsxc2FxM25B?=
 =?iso-2022-jp?B?WXdKR0xwOXZlQi9teVZRempmRGMwNW1yWTdGVDRPdWM3L25XV3oxSi9v?=
 =?iso-2022-jp?B?MjY2T2dnMTVkV0hxSWtHY29JdnVWb0VFM1lpQmNvT251c0p6YksyNWU4?=
 =?iso-2022-jp?B?ODNMYml0K0g3NTR4VSt5V2d4ZU4yRGw1eU44QThxZnNhY1VDd09nV1Fh?=
 =?iso-2022-jp?B?YWVveExFbnQxN3JNb3AwcFBNMlFmc2lwOVVoR2JGVElFU2ZsQVUxWm5i?=
 =?iso-2022-jp?B?WmZTOHI5cWNEOWFNcFFDZnExSmhmcFkvV2gxaUxMY1I5NC9TODE5WHU1?=
 =?iso-2022-jp?B?TUlBYkVxdEpvRE9XSTNDWXgrb29wT0IrSG80QldObE1WeGRmc1hRalNj?=
 =?iso-2022-jp?B?SEFndm9ldnNQU2xGRVpiUVZTQ2cvRjhmWUlUTUVMMHlnNFd0WkFFMHRv?=
 =?iso-2022-jp?B?QlJ5OEFDaHFqRXZZVWQ5WmlYOWJYRFBXRjdlYTV2N1NCaHdBRG52YWpE?=
 =?iso-2022-jp?B?ZTFFeTR5QndyaDJ1MUJsMmFudCtuRFNhMHJlcnlCUmEvRlVkTFV2cHJQ?=
 =?iso-2022-jp?B?QnRRa3JjTGlsUzdPVHVEM1BYQytBT3EyamI0bVhQRTNVUng3Z0xuRTRT?=
 =?iso-2022-jp?B?U1ZZSGlNcWdORTlBUDI5Y21qRWM5TjNaS2NKUjdHeTNPNjdXdEdKeUZB?=
 =?iso-2022-jp?B?emljaXg2SjAxVmgvZ1AvbG9uUHlNd0ZldlZ4UUZ0SkY4SGhhYXJpK0Y0?=
 =?iso-2022-jp?B?YW5nblZodFRKU3dNRlhtN2ZpSTdCTHFUVThmeVhGNjJWN1hKR3hDOU5z?=
 =?iso-2022-jp?B?MVdkaWc5SzQ1UEo0UW9NRlFza2hvcTNxY0xsQTBidXViM2RCNHhkVlZ2?=
 =?iso-2022-jp?B?Z3AraGgrUFdUcG1aUlE3TkpnZkxXdzh3cFpyWkgxekwyZFJyVEFiTk4y?=
 =?iso-2022-jp?B?YkkweUhSUEhIU29tbzhHR1BuUHlyUFdVUFErQ2tUREczRkFwbjcrRXRT?=
 =?iso-2022-jp?B?L2RYcS80TXJCVzhnaUhLaEd2M0ZOZE80dmZlSVdOaWZlWC8vK0JtREta?=
 =?iso-2022-jp?B?MzQ5Q3RLdDJxbDB0emIxbFdLb2h3bVNJeXRyQUtJeDJtbk9XY2VZMUJO?=
 =?iso-2022-jp?B?b2dRU3ZUdFJoclpNYWlXNEZBMkhYbjFCRVJrN2VTREx6bm12eHNQVGVH?=
 =?iso-2022-jp?B?bXVPWnFYcldtcHRxNmZHWHkwQVk3em40VT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b088d183-7e6a-4265-954e-08db301ccd4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 06:14:06.4349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42pxwviO/2Vq2akJHHIgqtRIHppErtpvyhGBFxsFYVk6P5/iofWMh5bRS4ZSNA4tH4swBMf2nbIPSU1sBBnr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5002
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi @Quan, Evan,

I checked pp_dpm_vclk and the new added pp_dpm_vclk1, the values are not ex=
actly same, please help check it:

root@ubuntu2204-RPP:~# cat /sys/class/drm/renderD128/device/pp_dpm_vclk1
0: 513Mhz
1: 188Mhz *
2: 2934Mhz
root@ubuntu2204-RPP:~# cat /sys/class/drm/renderD128/device/pp_dpm_vclk
0: 513Mhz
1: 25Mhz *
2: 2934Mhz

Kind regards,
Esther

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: 2023=1B$BG/=1B(B3=1B$B7n=1B(B29=1B$BF|@14|;0=1B(B =1B$B>e8a=1B(B10:12
To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.or=
g
Cc: Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com=
>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexan=
der.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.=
com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Ton=
g.Liu01@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some as=
ics

[AMD Official Use Only - General]

IIRC, the VCLK1 always have the same frequency as VCLK0 with our current im=
plementation.
So, is it necessary to provide another sysfs node for checking vclk1 freque=
ncy?

BR
Evan
> -----Original Message-----
> From: Tong Liu01 <Tong.Liu01@amd.com>
> Sent: Tuesday, March 28, 2023 7:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace=20
> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig,=20
> Christian <Christian.Koenig@amd.com>; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,=20
> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,=20
> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)=20
> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
> Subject: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some=20
> asics
>=20
> Add sysfs node pp_dpm_vclk1 for gc11.0.3
>=20
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 22
> +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ++++
>  3 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 86b6b0c9fb02..fe75497eeeab 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -104,6 +104,7 @@ enum pp_clock_type {
>  	PP_FCLK,
>  	PP_DCEFCLK,
>  	PP_VCLK,
> +	PP_VCLK1,
>  	PP_DCLK,
>  	OD_SCLK,
>  	OD_MCLK,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d75a67cfe523..1da6e9469450 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1180,6 +1180,21 @@ static ssize_t amdgpu_set_pp_dpm_vclk(struct=20
> device *dev,
>  	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK, buf, count);  }
>=20
> +static ssize_t amdgpu_get_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return amdgpu_get_pp_dpm_clock(dev, PP_VCLK1, buf); }
> +
> +static ssize_t amdgpu_set_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK1, buf, count); }
> +
>  static ssize_t amdgpu_get_pp_dpm_dclk(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -2002,6 +2017,7 @@ static struct amdgpu_device_attr=20
> amdgpu_device_attrs[] =3D {
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,
> 		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -2091,6 +2107,12 @@ static int default_attr_update(struct=20
> amdgpu_device *adev, struct amdgpu_device_
>  		      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
>  		      gc_ver =3D=3D IP_VERSION(11, 0, 3)))
>  			*states =3D ATTR_STATE_UNSUPPORTED;
> +	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
> +		if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
> +		       gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev-
> >vcn.num_vcn_inst >=3D 2))
> +			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>  		if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
>  		      gc_ver =3D=3D IP_VERSION(10, 3, 0) || diff --git=20
> a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..bffbef3f666d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2006,6 +2006,8 @@ static int smu_force_ppclk_levels(void *handle,
>  		clk_type =3D SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type =3D SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type =3D SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type =3D SMU_DCLK; break;
>  	case OD_SCLK:
> @@ -2393,6 +2395,8 @@ static enum smu_clk_type=20
> smu_convert_to_smuclk(enum pp_clock_type type)
>  		clk_type =3D SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type =3D SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type =3D SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type =3D SMU_DCLK; break;
>  	case OD_SCLK:
> --
> 2.34.1=
