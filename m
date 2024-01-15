Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB1CC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 06:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9438B10E1FC;
	Mon, 15 Jan 2024 06:14:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BB810E1FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 06:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtvyOb9j96xoJMOTrDQliFur5a8e3EGtX9amIxy6axzttQsNKKpUcgncEX7FzYQ5dhiggMgpRvOAHGrn8nHuNhJ1MB+Jj/I4/F/5hYbdEIknlUXKoMzguK+ljUi8I0GCF6UlRvdL0MXXRFZTZl3jSm7GkbzNIWJExe8BY4OY/O1MXeAwanwBfBX+yjvXpcXg6AC0jv/2IHf2nbKLLZZzVbIbBk6GFf34X8554fRv+oixgPS20phwytldb94GCKaUGAGU1o+a3BAuL4g8LmueYQz9ifr+uHPrnKO0D1n8OwpPApsRhyjR8FadH3N6brohrUR+BQqxSFKIQn7qk14Q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hsRjaf4fx2PSCqKnVK6LciJ/9HjkxMasTXkohGDEDQ=;
 b=hfJHVqkAzfyV73LOpHmLxZ0z7wKJrC+PqjFmLItLDsDqZ8dVajcQQFpDQitDLW2RMdPz0k6KkxqgtLJ4PQbGDGQPnU7v5vQdRvNyhPjITvrEujCYyjVZTNj6ws0PqNolk/CEhH5utFFKlNyX90ZT0SjtSyDPkZQkFdUyzZCBrElfgBoL5dY4n915TQpd93kyMMLUUKZuv65Ov30JAFrU5h+uxXkbEvJUmQOZuwOWUNoEYMlaxUxFivgihYjsE1S/X4OVpZvzxhgtEbTw2b1I4fXxs7Ts01Rcixy7/kZGjOzCYRvRcVI3EqBxrnS6AS0VWnnQIxpxXZjMC8qN/MycoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hsRjaf4fx2PSCqKnVK6LciJ/9HjkxMasTXkohGDEDQ=;
 b=mTDTqKCJGsk14Q/DV266BeflyQY1WRXg8wtg5T1Kt01+aBtMfkslUhCxUfTiAuZWbdmUlQcsDvQIyfuhLNJzkD0Fq/Y1oE3lBsXmf7ErMGPUdNbYA3X5xbIxP2W3NsPcNaAqYxpVmD+poMHXgCXM7xCOLQ+SGBbKZmFjemqqSQg=
Received: from DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 06:14:20 +0000
Received: from DM4PR12MB5118.namprd12.prod.outlook.com
 ([fe80::67b2:2ffb:5fd8:c0f9]) by DM4PR12MB5118.namprd12.prod.outlook.com
 ([fe80::67b2:2ffb:5fd8:c0f9%5]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 06:14:20 +0000
From: "Cui, Flora" <Flora.Cui@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: init drm_client with funcs hook
Thread-Topic: [PATCH] drm/amdkfd: init drm_client with funcs hook
Thread-Index: AQHaRS5S2ssOXjWxb0CvzQ6OabN277DaaV/Q
Date: Mon, 15 Jan 2024 06:14:20 +0000
Message-ID: <DM4PR12MB5118ED3073D6738AC0FCD9EFFA6C2@DM4PR12MB5118.namprd12.prod.outlook.com>
References: <20240112080516.291675-1-flora.cui@amd.com>
In-Reply-To: <20240112080516.291675-1-flora.cui@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e25fc128-2b4f-469f-b9fa-76303cb526a0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-15T06:12:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5118:EE_|MN0PR12MB5857:EE_
x-ms-office365-filtering-correlation-id: 5ebc7ad8-0e46-48e4-3360-08dc15913619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AUO1ykpVeIZXkq7SVOAIF4MNNCfX/Bsu1MSN8BR4IMoxXsiVRUWOXAH0/P+bqxnrccJEA69tgEioZZkGMU1RwtTdPK3kQ6mKsPRpU4EBBx7QBFFeUCHq/tPIRo0bVuPG9cL1J8NJhH55v561c2Xs7tYezCR4/4ZSGrJSc5qq1dkWjcv6Zvfq46CUeT0nwMKODqOC8YKXVRTYerLXVlKIYoNPLa7zBDsoiTLR9OKa05k3uPCj62FPAuPp3fpB8yUhnrs6GiJJUc0jxHuQrpzDZYTQPPLpevPoY0HWvaLzC9y2DDJwE56J4TOGKuIiMogbGX0+DA1kl7PilI7SJEEciz5fwdPb81gWNe9oXR6YCS7xNm/v7yvlAO0Zm7KF3//yZewheWz3aXxwGnmp5xowoCtPB6WpNopWhGr5BTIn8B9753YG3i1vwiKSIo4MCQLvtgon+sQTCDwl+TzvZx6datmPnHU+0jmXUo0ZSkFLcOSGt4SPadfYNpddP3DZqc3WTKEKxFQ8ud8fCSQB/j4LCN3TEOxxN7ePJ02AsZ4JIX0mm7x1eqJLMgUhLFqrZb3oiwmXA9FuKvFRLmk1S/kF56sODaBcmYRYhv0IEz1U9PEGmAGTSBtokYG0MAMqcLE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5118.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(71200400001)(122000001)(41300700001)(8936002)(52536014)(8676002)(54906003)(76116006)(316002)(6916009)(5660300002)(38070700009)(4326008)(7696005)(66446008)(66476007)(6506007)(66556008)(26005)(9686003)(53546011)(66946007)(478600001)(64756008)(2906002)(83380400001)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gp6HD9zC/V6yFbmDYa6bb4Ur+R9oe4Ivngd3/8a6qFEGPQUvOYHJ2QAGdHBe?=
 =?us-ascii?Q?tIRBx8sfJYcBsCA7m5VcRB6DlByraqf3Rkzkilfd21JCM+slBPsQ63n9jVHU?=
 =?us-ascii?Q?4CN7eytqDObFa7DRZk28+QyC0ensj0fICa/Ggo41VvIQLTDpS88o8mnqgVSI?=
 =?us-ascii?Q?I/T2hpTPZZgIcEGYZ80VviuXBO6cAELVpYaspCccMG/YtpHfMYQdhBVZdJjA?=
 =?us-ascii?Q?nLrq7c1vlkRfBl7qRSYt28FxeVwhxO0Tc3GZ0AqLQBuPmt5BBrwbOMHXGdDd?=
 =?us-ascii?Q?ZolMXBs/9EoPzJd8aji2a8k5L5bx78C+Qv/UbEiPUw4yEQJirgvJrLKm2OHJ?=
 =?us-ascii?Q?xDtPrbQiM5eetILSNtwnCs6D1XPFj9OFKQ174XNy54ub62QSsLKAp2dnXBTQ?=
 =?us-ascii?Q?Wevf/a35kLjdfd4jBRJGlrVI6zfbZbWE/Vyk4fDmppxpxsFZmft+H/vRvNpL?=
 =?us-ascii?Q?LZCcvGpupPvabVi0J9CDJpv0E3z5uMZ4sRHroR/n9M6CxWS1LGmJE4cJfhb/?=
 =?us-ascii?Q?phj78gJCAEQ4gQLoGHukwu7X/sNIKyObRWHmSshGX7s2LyTCBYUg2pP6c5tG?=
 =?us-ascii?Q?cwtWAlMrG9q0wCFixEQQLdNJfMSU8DCWvrnNXNIV7HDWFadXFN7JTHBcoBvV?=
 =?us-ascii?Q?REbu1dwOYy7ZQTiypefN5aSfKz+xCYrxq3UFpQHkh3Z1kEpUW7mlgqevQ2Kh?=
 =?us-ascii?Q?sZvXX/uvKz8yDdIQVoV1ESyedj0I4fA7f5HGscoxoqSDZyIFlyMJIYt2D+2D?=
 =?us-ascii?Q?kOn4bYxlALPu6dEXEH6Kc/mzHDvBDPyT7vtEu/X8vK50DNs9Q2Nn002YBbJm?=
 =?us-ascii?Q?AvHJ3gXJj/AdQzW+BTNeds6pgjJPnUFoXW0S8o07uCVFN+0xxVEwsFzoX1Al?=
 =?us-ascii?Q?ZFHL2N/R1VM3Z6zu/9V1gDza4NF51cjbUfU6A3nauBLZsj9iZKw0ZVBNFbRB?=
 =?us-ascii?Q?bbvAorUZy+fvtgbu+QDvJPg6u9RXEPo+PkGHdhUPWNNZT1mOetw1lU98e8Nj?=
 =?us-ascii?Q?lLPrhZWkKNCZyBnrcs//mS7Ljdbjj3mFXIcCm7SpJZ6k5GkJZBv3Bj0xCN7w?=
 =?us-ascii?Q?JOhGqE3sl5W5VnBceNjuJF9OaMKKa57c20ocgWnt+vkU/hSBk0QsELtQT1Zf?=
 =?us-ascii?Q?fNRdfTRdpt3GErT00qGY4Fnxc+P7TKotVfAq7woifx1eOBG6Uwtp6VzRJ+r3?=
 =?us-ascii?Q?Rk6nR6h5R+4rEG3oRIiBk17wECZhLbRnP9kRCME2LbCyG0FFSX/72DZvibWe?=
 =?us-ascii?Q?4SsfiLTAzaZ4rc56BUspJZkiioAJr545hvoSNU5QZPc5R5AsYpLs9iVUlxeI?=
 =?us-ascii?Q?tUozi2PrYiqnizTo50OX89S1u0hOYH8iL/8GzsdMk8AqluWZ5B//bHQVuBD1?=
 =?us-ascii?Q?DKm8iylYb70RpZsBEf2XW2i6KDHw2HtZd2C9f7DHMxmi7vQjQq0sKbv2qQZ3?=
 =?us-ascii?Q?X6xnM5C8iC5pfn0m+SNoydfGjrA4KwOTP+HX8gGVXGJ8ADZTw6NRd83NEX6e?=
 =?us-ascii?Q?cl3wo8W1A+v0WYOyON+3WUUmPU/ibtvoe7jp27UpyYaQc+QBvySm/XS0EbTk?=
 =?us-ascii?Q?GGcRbDuw0O2qIIL9WNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5118.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc7ad8-0e46-48e4-3360-08dc15913619
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 06:14:20.1755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT3RiI4qxaQKmLJCk0x5n08/bOEPpk8NlgARBijv6T+sAqz9S9TM1McW+lYIWdd5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Song, Asher" <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping?

-----Original Message-----
From: Cui, Flora <Flora.Cui@amd.com>
Sent: Friday, January 12, 2024 4:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH] drm/amdkfd: init drm_client with funcs hook

otherwise drm_client_dev_unregister() would try to
kfree(&adev->kfd.client).

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 067690ba7bff..81af6bf2f052 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -138,6 +138,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct=
 *work)
        amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }

+static const struct drm_client_funcs kfd_client_funcs =3D {
+       .unregister     =3D drm_client_release,
+};
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
        int i;
@@ -161,7 +164,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *ad=
ev)
                        .enable_mes =3D adev->enable_mes,
                };

-               ret =3D drm_client_init(&adev->ddev, &adev->kfd.client, "kf=
d", NULL);
+               ret =3D drm_client_init(&adev->ddev, &adev->kfd.client, "kf=
d", &kfd_client_funcs);
                if (ret) {
                        dev_err(adev->dev, "Failed to init DRM client: %d\n=
", ret);
                        return;
--
2.34.1

