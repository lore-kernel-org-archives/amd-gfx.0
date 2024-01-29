Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BFEC47DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 05:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059C2112497;
	Mon, 29 Jan 2024 05:45:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD43B112496
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 05:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO77WhsamAIy1jRJr6nraeBTeMPNSn/Zze6HXBnqBnlRiZrs+Qz1u+1ZTlXw0VYVdqBwmU/fzqvEFnndbhyZ8Fp20a0XFy/iNcwe0opK4UiDVLP+8yxFkemLNTsNV03eG5Gdh5c/OVhs+HXK6qURvcFug8GwVIn5Qtr7TQ2xDJMwf3ERkXV3MkIXdX91OeURuGHRr87c7Acz9DotU5MNQicmB9TwNrVGFKiiLD01pr7dTf+6pcLCuzDgj4na2AKF2XZH+AEvdr8lgi+Et2HML8gSAnK7L111HnbE6PLv2Uun5ovUMAGxO5e7yAtDyqPeaQ15TDoneAZ8OOFdzwTWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPMnLEoS7fPM3nzxovf1DJBrNw4nOa1Nddj4D9Ik+ys=;
 b=leuwHHrVjvY2rxfVEvN87HcoTeBOcOxGB418hlo3octypIr0WsC9NOQeOj4yUDmcpXq5j+j6bXBfLcOVswJZKejHy8EFp9gP5rTK/w266y0vDW6GbYBt1XkYo/lM2OYgpldKzpw3ttSB+PKGNSVXQHA9WQmD8xGQLyD3B+wPlWjZZGZECqYGqYg1zEXW7CQKSdCirR9hlqusuij97J72Z9jNKvuCzEnjAdE9eFEeDke8Vq8GNMpoMgBfbcDgpZDjpT4kk4K79FGGNo0DPzQI8EYAwI82LVF9kddHHNROzKLFGjFDx39s/jojsTqkKjLvHfKuq6M1EfjqPGWVMwDbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPMnLEoS7fPM3nzxovf1DJBrNw4nOa1Nddj4D9Ik+ys=;
 b=k3M2vVw/WMJTxHo1gJBZgdh2Pq/oGDRPfyIwYKO8cmVDf1Mu7WVrDaY+RZrnwkK87Sn6YTKTn1CeA9dnGb3USMRvJAIWVZEt7BBQD81xfUZdl96zRu6Z4nEADRN53AITQ29m+FyH+EjUh3IJfVOTHvGN3Dc0q9RazduTNsXApXM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:45:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 05:45:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable ras feature when fini
Thread-Topic: [PATCH] drm/amdgpu: disable ras feature when fini
Thread-Index: AQHaUmbbxOHpU9L9AEy8a0KuX6SXzbDwRuBA
Date: Mon, 29 Jan 2024 05:45:03 +0000
Message-ID: <BN9PR12MB5257E5FE383F0050638127D9FC7E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240129035352.292199-1-tao.zhou1@amd.com>
In-Reply-To: <20240129035352.292199-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eda961c6-c78c-4c60-baae-5dc49ce35491;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T05:41:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB7502:EE_
x-ms-office365-filtering-correlation-id: 3dfcd808-bea2-4917-0161-08dc208d70b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2Zx20AMHFSl2gcgN23l9Z7jXMFU0hpEcV0plzx1CFh2zsR0vpaLjVIXbAPrYm4WkrWvkTT5H1DUJpBElWAm9Veol3H0pxvsjZOdSdDW1tRSv8rDD1Y9NsqB5H8b71uYYNgpqeBmfNGaN+1cZxgLFa3Y2JTZV/VFnJgdw9wHBuMOIwJTcuwTEXCYF/JD3/jVLrwldGoKf0UCM//DSq2UNzLw6tKNATLxtGU1Ztbo2T/ONBXKTAP6tLmLvOxoCMEU6FoWZpNw/deo8HEpJwibuLn1z0c8Xpa4ES1iXbr1WTIiXgo79uF9/lpjb1btWlH4kJN0VrBrCseiRjv6s+RbS0Fgp6Oz6wdmxpN8gDSwr5gGdjjqS9DTJ0vyYYFex+frtNmAABPRK8b5l3b52N2aCfg1NFTsLZvXNgYk1DjvJkG6J6LHPOIxQ3bmbfDZnjBCtGCaTGsC+pxzbAcPQz3nECwo6b1DW41t2qj3FsF9cuMCNWgGVxxrlC/046Yl0HtXyThv8C/lCPKpFpBQABE+Tx2jUxlInM1VK8YaKAnxSW1a29byQAtst0QGEf7s00neukKsrDGClPy9liVmVXjep8zB5s/CF30hMioU6qQPBpDPRflR1qFSZnQN2RQnqt/W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(86362001)(110136005)(66556008)(66476007)(76116006)(66946007)(122000001)(66446008)(316002)(64756008)(478600001)(38100700002)(53546011)(55016003)(7696005)(6506007)(8676002)(4326008)(8936002)(71200400001)(52536014)(5660300002)(83380400001)(9686003)(26005)(38070700009)(33656002)(2906002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/lzmMOfkWSbyyhU4hfbNwnwTQoFkrLmV6OBBM9CIet4mDROtD8N+qiRfcsgk?=
 =?us-ascii?Q?Zw/ookorwwqNf7kVLoiyHkd6uOX19y/KtKNZguP6fV2IXxrvmFl5HlpWXstG?=
 =?us-ascii?Q?OMlZMCLNlGXKnQrf8VXjfdxWSEbaVckiGyvUx5i/uDoqUd8OvlkuaiRk9yr7?=
 =?us-ascii?Q?GtUV3RdFfC20Dzu9uw40ZhlxRqSvv8D7su2iYHv++4SHxM3f2KO1ev+D95GE?=
 =?us-ascii?Q?0gRoK/ILIQIP1tVsQhKEKYp1Nqbw1peQvNf8ai3m42gnwG/+z3nF1187WH/L?=
 =?us-ascii?Q?CyUJmO1HllBXgttEGs3G4JQ2b+X749VBLFMtweLM/wf0xm8B3L8aU278+T/Q?=
 =?us-ascii?Q?HCVw766sLV+hedauZP4RwMFrOhXQDlrPV9/5lA3ackeVB/L1D+NcqNJvjSct?=
 =?us-ascii?Q?YGO4XhtMdp1kEwdwgRljYwUaYwmcQRI20LKBl8K046weC3rVQmZOu27kmQTo?=
 =?us-ascii?Q?ogxXPkvK+YyN21hTWouNaEKHWyg7ATTcsoYLT6Amg6qDfLV0wsukIwGEAtCz?=
 =?us-ascii?Q?KCETWgIzRierr8xgKf6reEoK7QVFba6ydtQNvTTElane2I5zCcKZdgrQAXLq?=
 =?us-ascii?Q?HwWHCQHwhpF8pSwWcWm4GtCbi8fdujv5r3E0rh65c71l/rAdjf7ApiXPbWaY?=
 =?us-ascii?Q?IgnvRZyO3XmRFFeiqBd8HwGVncLKInMcuvSl5c8FPVBaGz/Yb1xgfy/I7y9J?=
 =?us-ascii?Q?G6kxZij8P/vthmbBNuw8kUvUqWILMl7/6D5cafjbqhHDlIsIFlgS36r3UY9m?=
 =?us-ascii?Q?2ufeGtmWdylZHM/qndZ+XceclBpsiejQrLRgDTlxcuhMoJgsQKOIgx1TboSO?=
 =?us-ascii?Q?ayG1PzPGpf1RiWMbHHYFanIJ61rK3CSL2TLIduO/lAYCypharsG7eQLyHD7G?=
 =?us-ascii?Q?JwmpXQygfMpb4gYwf1QXAipP4DYXdHwSbAu4Xt/x+IKFtIz2PU0Bhx95f3gs?=
 =?us-ascii?Q?aR2CFjNW0UROO430eeZgu7i/HpspzSfPbIfaF9eFxrJWj2jTvudUXdwa8r7U?=
 =?us-ascii?Q?XA5nquVt7q0z/dFtWSW9KoKDmKAZnqp51CLbUWwWWTrWd2DwgKERVUaiAerO?=
 =?us-ascii?Q?uJ35GVHMADV3v61tEwTqTNWCWXwkLsQhRXappis6vFEsFb4O54Lf8ODCe7h8?=
 =?us-ascii?Q?ixuWHFW8EmpvbELG/Ek1R5bk4LlSW2ewYOJbsOiZLgRXUBOtR6YRW5eaUAYp?=
 =?us-ascii?Q?ibjXOozZZMLU62Qe0NH1ugyiGBlcREURXZufB5uJGMPI+RhKzi+OQOxz5zpu?=
 =?us-ascii?Q?/xsL8mYSUuzVk3FebrnL3UeTBLD7xpkyg5F8Le48f0MLpCJ0ZqG/qZzD/p+3?=
 =?us-ascii?Q?2AaozcGgPM2/Stb+YdRY4Bxt94BfGd4xskxB4y+z8pI1T0Yo8jOr/r9VVm4e?=
 =?us-ascii?Q?tKeBHDx3GGVJ93cpnwByoY9pkON346U8ebwpfVgYY0ofeKiLvJihrAJNUq7Q?=
 =?us-ascii?Q?tRX3S+58/PrfqAvb1nFv5ii5oK2cEiUB9qe4rsZMb+jyu0x2aA7YpTlXR/L3?=
 =?us-ascii?Q?znkCTnizKjVaiLAAED68apHUxCB+O8k4wdAJHrcPG4f3FyNgcTMFZw7Q3fSj?=
 =?us-ascii?Q?QRBzXZx0zYV+I/cenLw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfcd808-bea2-4917-0161-08dc208d70b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 05:45:03.2419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UijwjQr1jpagfuvrLCHr4sBlQzykJA7bEsmdiZWyNa8aPYP9KqOF0U5MDcjYW8vDTwX9wvmYF9O+Gc7VJ5z0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

BTW, we could take further step to retire the if branch (bypass =3D=3D 1) w=
ith proper RAS_TA changes on legacy Vega20/Arcturus

if (bypass) {
                        if (__amdgpu_ras_feature_enable(adev, &obj->head, 0=
))
                                break;
            }
Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, January 29, 2024 11:54
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable ras feature when fini

Send ras disable feature command in fini.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Change-Id: I95f1d1e0a46fb613631e5cd77497e64c0551c4c7
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a249f24ed038..a9fa2d134670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3437,7 +3437,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
        WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not c=
leared");

        if (AMDGPU_RAS_GET_FEATURES(con->features))
-               amdgpu_ras_disable_all_features(adev, 1);
+               amdgpu_ras_disable_all_features(adev, 0);

        cancel_delayed_work_sync(&con->ras_counte_delay_work);

--
2.34.1

