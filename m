Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D16DC25B10
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5188E10F40A;
	Tue, 30 Apr 2024 14:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HNsH9H/T";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8F210FED1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkXtYWLfVrS6jhV8Tb5zi4gy2tL4N0ZKMnkFLxOOJeNOWda6joCb36K1q80OFGt74C+QzYu08kOMkMZaV3kiQ79X2jf0VNQcr61MY/j8m6BNHKpcsksDBqeVCc2jnzorUwTcPS2FE7WeYpxTcFz0zvLhcD6MivHfRVb812k+Crwqo/rzChcO9Xk1xQdkbTPxGYYulOZowbK0794BilyKz6tpQIYA95uUUXbE0JGeCuoHXj5r60Reajs2UnNUiN57jH8uXu919qThxJ4wbgyD/+aqIESsCJPKTRJCUrhuTMDNl5Bg1RoJ7DjIEeHpxcUjOiOR1Z0YPKo0pU3KBLUUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21TAdNrUUwsi/m7gLOtKM9OFigG1BzYPg94iq8PfuIs=;
 b=nfoqJaKGQMGDFwEl8GBO8hn/ymZOSdQPY+uWcbRpesxYdSXNdBo1nzc2hkb+rmp9ogVVVCCKRxhhU9Lmv/8hgpX+F7Uryt7dtR9NB80lEmBWkP6Ht0PGi2gy5hoTk0TDmoHAl7V3YzH51M8TxlZ71BiYUC9SDDZNpRnwG1V2d2F/8zokZGxENa89WPjCvePiK/iKCLNXUQ9cfa6u7VidMqthg/CTGlJrlqzqVdvFGnSwKBBS3TFyEvf+3nIc8LU2r/gr+4rJvzVKb/xPxj4r7QSYvlVnXtOCXkObW9WoN5b0HOQNn3qrV7TmHjVnoOx5vUtsWryg3jtSgwx2Z3U45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21TAdNrUUwsi/m7gLOtKM9OFigG1BzYPg94iq8PfuIs=;
 b=HNsH9H/TcwgPQxtNWGEsh96Y23p1BC2Re0gpv7eMI1GS+ztxKGTlhNXuc4vYJIbsE098fetVvsz4ZKkYYR2aFOQJ1GNIY0b500yj/D1lg1P1aYDjZ7LKrkz8XzGEHmW8tTpD503qbXDDF6c7kanghnepB6QKWKQcL1Xl8JAKJEs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:43:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.023; Tue, 30 Apr 2024
 14:43:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Saye, Sashank" <Sashank.Saye@amd.com>, "Chan, Hing Pong"
 <Jeffrey.Chan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid reading vf2pf info size from FB
Thread-Topic: [PATCH] drm/amdgpu: avoid reading vf2pf info size from FB
Thread-Index: AQHamwoXT9zgsw7xgUGjSdn0W2N8lLGA41Uw
Date: Tue, 30 Apr 2024 14:43:20 +0000
Message-ID: <BN9PR12MB5257FDBFC52126133134A2E4FC1A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240430142356.23489-1-Zhigang.Luo@amd.com>
In-Reply-To: <20240430142356.23489-1-Zhigang.Luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1d34e8d3-1d3b-48d5-8d64-5d801d3f6e1d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T14:43:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB7545:EE_
x-ms-office365-filtering-correlation-id: 481fb7ee-6d71-4e63-47e1-08dc6923e121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?M3JXCL1rkHkIgYEAIOhLfskzOEyW0vd+8Uh6kI9PtJ9/1SdK0X32QkJ16a1z?=
 =?us-ascii?Q?2TNq9RwOhhqJ3g5s8uXJjVDG63bHvsDb5jopTM4jIFTmwjzCglmKvmpC65r3?=
 =?us-ascii?Q?8wtL5TdzX+F8G6otdqlDdykF5UfSZEJWO5Bf+vJ6IBC9neso5Sp+zPna+yyA?=
 =?us-ascii?Q?Zo7UEbCUst6awGpR5hEpOTj5z3TtlO3pVoSPxJiutMdBS06nk/LnlLhY6+oL?=
 =?us-ascii?Q?7yvOQRT2lHL2YombLN9bL3KnxeJt47UaB2PEbbjSwrcrWAWvMi150gb3oIxW?=
 =?us-ascii?Q?sujwL5sH1Xrl41Mm5QGguXFjgBufbQpf6lcYBp4lRhbAUPQczl6yx3zRhOkd?=
 =?us-ascii?Q?Ot0VHt+C41XNMkRzzZ1ag1/H4pbqKucvThsXdIs6TEJJKEbR9ylBxYQD5UO3?=
 =?us-ascii?Q?aUadyVdAnU1yXpVe7QrA94UVO1m5HUl1MzQS80O2mya8ypvULsujFjFjJVqh?=
 =?us-ascii?Q?hGbIWKsRbIkI0N/GNLRkHZR2qonkkExsZdoOv5XXjL4I9Wxckiyk65gZrCoW?=
 =?us-ascii?Q?28IIMYewChlA22bGOKRNOGOuAAeyx01j6KwMTwLjoXHynTT+fxFkMTHBKpeR?=
 =?us-ascii?Q?WN8SFDaM2YtdBVQ1F7CnleX8bu8VxSik7CPYbOrbDRaOiUlsL1s7yyzmOLwj?=
 =?us-ascii?Q?M0qG91cvJoVZBHubtAXUWwDGDPbn1cqdOwI5nmjUzpswaITwC9UJ+uBfQfMa?=
 =?us-ascii?Q?q6XOgc4DSaSQFujx5+rsnSmWFPu4VlPSEFxCs12RY+KfyKZV0OrMIdxq+QR0?=
 =?us-ascii?Q?bVQ11Hc/b9hhuPJVIRzQ85zs72a9vGH6lNzmGu8fC7+M1LNJ7J+orl2DGMeq?=
 =?us-ascii?Q?gQuo0tJZdQw4s0fPC/d9qwb9wLRmmfHBeZ2OOAEBQp960eQtnG8rTtUEBxvj?=
 =?us-ascii?Q?ZiHYaaTyLYgtu6TmImvGOAO04q9/WFJ/K1sgBwh+sj779NY+KcKzE/L4CRJe?=
 =?us-ascii?Q?UP5kW5SgYCATKUpg1WuIhNlRmBkFHR1IM+ftnqK6st11eR0/eNSsLmZBqEtQ?=
 =?us-ascii?Q?+8lZePY5eYPVmgvZyJpd1tZsltQF9m6tyZ2abn/bfqq+97DwhfT+dAleqK8o?=
 =?us-ascii?Q?1hUicJnOojXFr72xzN00a5mAr9XvrZL4vYAXUtz5jjsuuu1KSu8KXGZPN7Pg?=
 =?us-ascii?Q?m6azHu6diHG0uC8gtT7MzYGMVWZ8uWoDAAnu2y+uNL8C5HyjSgoNbaxdx0vn?=
 =?us-ascii?Q?/wxfgDxAjGq/FOyFR+pjWXqjyr0XQ9y3xidM3Kvn+8iEXerlkUEo1l1DurZd?=
 =?us-ascii?Q?7ukB3mVP2GpojMnDqDnK4MK7+HDd/xQWYudlnAzvVCuVxEOrsKc5QPKsNOrJ?=
 =?us-ascii?Q?DeFsZgD+zxSjOaOtXE9ovy0QGp08E6ZQFA8VR8Rw2XKFfg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?na/tg7/ETjRo+4iFc/qDyuelpwgdjZdCtIEqrAmmhzyIe1kr6//xjjt+Yy0z?=
 =?us-ascii?Q?jTCN8LCFEcJ+3d7NvTn/ppXIU8/EZgIyCqVb6ts39hSE/thRyfNtAIJc0ncU?=
 =?us-ascii?Q?WlQeIebYyQSu71XlLLf6jUNU5rRDjwodzEoXzbvK5ZVcvu9QvB1bm2URUO8q?=
 =?us-ascii?Q?RDZIioL6mIo7978H2PiY7a2nbMJUDRsziMKenmmm4t8laF7RhM6vbQ0QlR2o?=
 =?us-ascii?Q?a0XLuP3UJwn7juMpSmx0WwLv3RBPf2tB0BdjdaQ8MBonB8/I17NUXdy8oVU6?=
 =?us-ascii?Q?ctm7HqSqaKiXLJEL3gp/rZuaquUBsWdb1yUeI3/sRJ56cYj+bmALVKi1S9xN?=
 =?us-ascii?Q?boSNVJ7E4NnpvXhfY9O5ml+iOJSs7bC3n3rFtI9AWDcx6+hKJVhq+P09wQQk?=
 =?us-ascii?Q?Or3R/Km4RMAZGLP8F6ByLZIRG9zFRKu+ZVkU2BjaxgqtuZkom0nmlDSiRD8R?=
 =?us-ascii?Q?Ah4SbwwTU3ogcJSrt2m0jmga4y3B/AssXBM+NwziQ4T1ffYNXEEHFaRL9Ms/?=
 =?us-ascii?Q?EJYlJXet2ceRwEg4Av/CixTHEFHO2epnKf3qBKHfPOEzEIjJMMPA/rNVZTwt?=
 =?us-ascii?Q?mR5rZeBpwpg03HqPeK1HhLhQgMgmQW31wbN0cZf44q/06wnJDWQC0tpwg3ho?=
 =?us-ascii?Q?TxkTBwkZ88vPKVym9yzuATJ7Rc58jyLbT+dhZwVwNQ85JX373OmgRyronFpp?=
 =?us-ascii?Q?0+E6BvUMcp4BETHKtw/c5eFDhCt8V9ib8wdcm9YhKD1W1xz4tKZrgKULcQzp?=
 =?us-ascii?Q?eJC2ihhDm4v/qgsUlC2ls7ZMExW2x4x6yTeUCnG0YSuChUkFnlG2Lol9FVCl?=
 =?us-ascii?Q?taLhZOzWfKUHYUMfh5e6SkN5MAK03a8Xix45uPtQmEQbZpy4CfDbbN2niD7O?=
 =?us-ascii?Q?SrztY2V+DTalWJy3b3tGHmsnxFmDWhIrl+uvM4VXhe7USJJDkDzjCFyXW6q2?=
 =?us-ascii?Q?dOxkaVHn/xxQ72UPOTmsIzMGN0aEEJIRSiSaw6lBR8Gf+4P7+HiDiWMRWy22?=
 =?us-ascii?Q?jI0ggVIDdu75DZQGJ6JlXw4jTHe8VNdoULl2YKqh9213CtLPWwsvJHJpdXdd?=
 =?us-ascii?Q?uCWM5ctEtEJrxpV5WpUyjzfBtYoUkX3y0a5LIuRvyW8fuTp7u7MHp/JB31If?=
 =?us-ascii?Q?Qbek5B8otroFVngXBdK16B6s3Z72Ovt3sXLOZHCzuAM4eBahKzje0iY9kKGr?=
 =?us-ascii?Q?fYD+pS2yHKVwlXtzAePF//a5s/7I0fWNwTxhNzn4FbG4hkf9Osz6FJU0hY+p?=
 =?us-ascii?Q?W/PKs+CTOU1rjOFrvGhFMfELQhaTdEenRf1oK/5N4chKUwv2U6gn06J036m7?=
 =?us-ascii?Q?9QXpuzVFFlPc5srHW6R8YX6LKwJvIMMkI7sHjTNjjiNoT4vLr5dCBLoWL0Qd?=
 =?us-ascii?Q?KKY5n9aEtHPrkSuh2EPb5yaBzhldJG98yhQMFNnzYssiCDxdPi3hk6oqDjWm?=
 =?us-ascii?Q?RLFtyeIrxeLMR9RzPijtefgzdCyR0LPKBGVVGZEAP3PRNdNRK9vUnqsLRKdL?=
 =?us-ascii?Q?QDlLFfqHLIBuOCxX5rp6p9HlE67EX1nDhgm+zfy1O6T7vBxIx65hdoxTXkte?=
 =?us-ascii?Q?5vqgxtbWrGkEtNRIDhI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481fb7ee-6d71-4e63-47e1-08dc6923e121
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 14:43:20.1291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKiUcP2arx/iGQchNFqj0i4CIZX/12QHFBln7ckIWH5JbHB2SqnjG/mc2YkzWyK8r7L3yTzMd91yswVK3kHHBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Luo, Zhigang <Zhigang.Luo@amd.com>
Sent: Tuesday, April 30, 2024 22:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Saye, Sashank <Sashank.Saye@amd=
.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.=
com>; Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: avoid reading vf2pf info size from FB

VF can't access FB when host is doing mode1 reset. Using sizeof to get vf2p=
f info size, instead of reading it from vf2pf header stored in FB.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 54ab51a4ada7..c84d2217005e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -583,7 +583,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_d=
evice *adev)
        }
        vf2pf_info->checksum =3D
                amd_sriov_msg_checksum(
-               vf2pf_info, vf2pf_info->header.size, 0, 0);
+               vf2pf_info, sizeof(struct amd_sriov_msg_vf2pf_info), 0, 0);

        return 0;
 }
--
2.25.1

