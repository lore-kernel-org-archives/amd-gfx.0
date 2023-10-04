Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A949DE7C4E9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 18:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB8010E342;
	Wed,  4 Oct 2023 18:31:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AEA010E342
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 18:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nyzj6fkDq2fktoPK7W3VxjL8Mw0/kgEVx3TmhOH4IPjYfWsCCxvWcCA9belrv9nMOuUeocp/D4wK5zCmE2hWWrVd2Yrs3w4812zPLgwj9sijTTz+cTcpAWnm6GkUoEaW4WQq15uq0vGoDcX6Gcs4xZwTvI5pLcvaoTbX0PhrXAzIX/RNNiRiEw3CDNDxVoRSTkqYdCX5dbOi0UdMA3kYQ8bYIxGYA7MtpAJEP34r2kJ7Aqdw+cFPv6yGMygwAQIIPUIUn9PTtL33+AO/hZS5lPhGJ+cmjziDUcMLlNEDr+SLFk7to3hpwblI1QOhinxg6f3LwImqU3yjzAyzNl54Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN0VCclrNyul6+cdFA9MJD2iYGht7sWqFsGGXr4g4GE=;
 b=ji/LlBgLMapo13ZvR6Nfe90zTGP/0FpIwMv3dH0iSUIMRRWvklLDoWzCob+wT1DqQ0M7Sp4uYplQLPMmHVGuJ+1rfyyiZF9WwXng9V2I2hp7TUynINyTKfQa1GilGJC80fQpBW3NyEjaEjWo8NIQQZazWtstg4e4rS+2y/mey3qVHTXXKcE6681AoRPTT9DAD9sEoSlgTlSkUSDC70MQH8uCMWL4kjR2QU3HFN8johjSrKOYzsfi+PMGbYAWCgiWYJ/k/ni3Fsi4pjsu8JPv9j8lulgFVd/xd0wqImq0ztz3h/EcKGMT8XggqExoFBOfYGDF/z4NKtpxN8Gy/kw42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN0VCclrNyul6+cdFA9MJD2iYGht7sWqFsGGXr4g4GE=;
 b=wIQKrqMxzrIuXoN41TwJHqQNhg8au9sTP1rpxrIqaIZa5tbTlD1Ibg+21r6fu33LUjI7x+zcJLi7krOttgGp51uAa2vubHXMn1q/KvzvlAXk96Ju6Byz021bd1CfqYddSwSCMQoIWlY5aY4mxkpq2wEoEt4KM3Dvgqsi6BVlqy8=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Wed, 4 Oct
 2023 18:30:58 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::5c4b:b312:5533:6381]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::5c4b:b312:5533:6381%7]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 18:30:58 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Improve MES responsiveness during
 oversubscription
Thread-Topic: [PATCH] drm/amdgpu: Improve MES responsiveness during
 oversubscription
Thread-Index: AQHZ9tvi8h40xpmGWUKF31y/3OoP9LA58/TA
Date: Wed, 4 Oct 2023 18:30:58 +0000
Message-ID: <CY8PR12MB709952D74005B9ADDFE5F71B8CCBA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20231004155950.1194972-1-jay.cornwall@amd.com>
In-Reply-To: <20231004155950.1194972-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ca139108-42ae-48ee-9236-b15271e3fea1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-04T18:30:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SJ0PR12MB8137:EE_
x-ms-office365-filtering-correlation-id: 5f3693cc-24b0-4c16-2377-08dbc5080dd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: humiFg+81o3ZDACaNNkrn5p4uW8jgzCXTIoD52WYRh0n4yPGBC/jBEkVekt7e965Gk3eFq/PGQ0jwrW+74MHvzPGQIXiNWkSPpB2FMy8nWjV/zbaEbsKL7vLDF+p4DnnhQNq8hPltyA1A/5hjcA7fTjBB4kbVap7FDCYy+BgMAIxWoZhEWat2L7nrfoIFO7oeFQKdkWn3+qYEh66SBl35vJ6cGD47RKxBHy2hi5HIY3EjelznKbNniAPB29yA90ta31FXV9rYseffRPEfpg/B8dT8JgbTNoYsK+4I+zUn3tHnVYO16CH+335v0qcV2CzjjdiNTgiRkIfNVC1/ivYKJdVyWjTEY/IO3KOOa6ZoNbblhZqoM/UutLxoA1n6SIQY0zbGcUkdZZFBoou4t0bgvqqHyiBNJQmjHyaDMl9RYrcLj7HDbmrKnHXi/EmBhDTdwykamDshUpGT06sW+HDfeOvI1tP531f/7/4g92crkzDCWNc9z9CbrJEjqHx5KZjJTy+GY/mRGNxneC6sQC+wMLBfBn0y8DQei9i9+ynBe5xLthh4WLEXMjWCqu4Co95pjMT4KPM4Z5gDbjBwrukO+/LyvZdeH69Ejiw3wy+v2dqRDMhPOKhO12A8SiBMUGn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(110136005)(2906002)(53546011)(66446008)(8676002)(41300700001)(52536014)(8936002)(316002)(55016003)(5660300002)(54906003)(64756008)(7696005)(76116006)(33656002)(478600001)(86362001)(6506007)(38100700002)(71200400001)(9686003)(66556008)(122000001)(38070700005)(4326008)(66476007)(26005)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mjDjf3fiD2sRo46c/HFCV3HV2wZLffPOy4GiSde8+NXOecPpoKYL1tXRgJpV?=
 =?us-ascii?Q?rMr6rR6APri4bYAiU3FNmeeveYUtrs5Dmax7JpgYu6AnydrlsBtE3op26WZU?=
 =?us-ascii?Q?Zr+mROUtG8TrowpZjqCb69tLBBP+7XvH7j5633S3/MGIxaSogQafgx7qUHO4?=
 =?us-ascii?Q?LVH+zGQyK4+96/MhZMYvgofCNhPEKqy4cvtq4Ob7ilyd6pMFlT/Vato0D/oD?=
 =?us-ascii?Q?pYIhmxpeUCzVRpQI0Gx2b2Xnh0Ao2c4IewWroJgIr8nAtWwP2SYt2CRQ6bcq?=
 =?us-ascii?Q?UR4s0RJLSRy/iUuJ5V/Uo2J1voayTdSDDeItTXyBH7ejVLkAU0Knio5XUxS4?=
 =?us-ascii?Q?U4rKm8rWRaZxu2UWa8oQm/LTkaRNpmdD/OpfAKo4yg8OhrTFMCjDpESvCy/I?=
 =?us-ascii?Q?w89w23W248ZVeB5mzbJv2+DTjyLivt3lg1ltVOVoTdoEqem37Rgz5Y2pdJtL?=
 =?us-ascii?Q?2zhxoXVGra10utCUiAbfB6aLJ9YaABNtLYybl1jZz8UZGyVfmKzkU/N5mflg?=
 =?us-ascii?Q?KHXNB3s3YBOvGPQ4gpVWBzeseu+ZrpSa+xNH7v55o3dyn5BZFxqROE3oytxp?=
 =?us-ascii?Q?+ueTOpWNXk385ElbFahAhADN5jrwn64+JUZbmc1qCT0ljT6OQrEJOr/9+uiB?=
 =?us-ascii?Q?WIEgeituSDBju98O35dvXm+PTuJ2VM9UucrqGwFTHCL16ygqZiaNOlvpnHVD?=
 =?us-ascii?Q?in+e6jGfpScBVO05ADQ97mQOsXrsgSTL8HPsAPlkfylAXLhvpPk2VBQ/rWRm?=
 =?us-ascii?Q?l0hMv7IE0HcT+ob4kTyfnJoEujfRena0ssYLffinfzJ06g9sOnZLBRD7sWqh?=
 =?us-ascii?Q?JitnqvpODuP4B740K4E1s2G9VpdpETcGfJYuB0DnmSn6H/ZCkD9FR+xlpueN?=
 =?us-ascii?Q?zoCeZVPp26mLbN/PyYjbhmsO0ijG5Hr7IALlZUJD/nc5gOOOtLWMFIgdxeTj?=
 =?us-ascii?Q?S6Guv8EFNDSINeQrZ1MqAdd/9lHZ/Odi2aJ95o1eqW7qKYUVqCdVnwIu/s3E?=
 =?us-ascii?Q?Bxx/jdKPzD00UjETNTtRcvLd+CMudz5geEnop/fQffH5LdCmyKe9C1OCl5GM?=
 =?us-ascii?Q?1lCz47nSOHQD/+IULRxuk2OfRzhxtry36tQ0sESrK7qQ385vFTf2QFnpHosw?=
 =?us-ascii?Q?Ro+dp8SKj5Y9Wftk/xpAUeCkrSxXoBJFw1uxj0xizAZ8tlU9GJRaYO9VZW8j?=
 =?us-ascii?Q?TQFd6LsEf2otKsHC8GTiRFyW3sBtBG7ipNKjOIpLXEZ5wzdUPndt9GNl8vCH?=
 =?us-ascii?Q?7Q/QD0yEjHtoglmdC5mF2sjX7Lb0Wgm0CIOc+NXQkpjlpkcvELxtJalnVX+q?=
 =?us-ascii?Q?hazbmAyFEO9oQ5fswexqg7H2NMOg1NdTuqB34vnZRWwQR7RJv1CY6lH68pok?=
 =?us-ascii?Q?tiy57A2bXs5UH7FfrnjiZMJdhzR9CSNPDMZdNhZMj7+a/ByQbvUoduJbFeHb?=
 =?us-ascii?Q?8bjpg9L2IgWBIbUNxjopaHKn1zyN4ss3iItvLBAu5IuCsGX7fftA6vNbGsPR?=
 =?us-ascii?Q?csVPG+35JF9CCTp3bNbnMhW2xq8u4uODgbV+dGxecf9oo+ofHWCj0YXCLeye?=
 =?us-ascii?Q?lDBnVXISITa4aXzDzOs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3693cc-24b0-4c16-2377-08dbc5080dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 18:30:58.4915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvVEhjlWLkqHgF4Dz6xCdYcwvEG6i6MOTLMjWl9oKDDb6XBxjcmkLIaRb0riM2lLZMIHr8WS8POfxlwTebzVMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Tudor,
 Alexandru" <Alexandru.Tudor@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jay Corn=
wall
Sent: Wednesday, October 4, 2023 12:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Tudor, Alexandru <Alexandru.Tudor=
@amd.com>
Subject: [PATCH] drm/amdgpu: Improve MES responsiveness during oversubscrip=
tion

When MES is oversubscribed it may not frequently check for new
command submissions from driver if the scheduling load is high.
Response latency as high as 5 seconds has been observed.

Enable a flag which adds a check for new commands between
scheduling quantums.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Alexandru Tudor <alexandru.tudor@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 4a3020b5b30f..31b26e6f0b30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -406,6 +406,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes=
 *mes)
        mes_set_hw_res_pkt.disable_mes_log =3D 1;
        mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
        mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
+       mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
        mes_set_hw_res_pkt.oversubscription_timer =3D 50;

        return mes_v11_0_submit_pkt_and_poll_completion(mes,
--
2.25.1

