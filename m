Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749F1C021BB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 11:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D20310E648;
	Tue, 25 Feb 2025 11:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PCcKhicP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E872F10E648
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 11:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDw00kWbYCOrN92uN9VVNSu+ATFEyOpGZuLU18Vl6KUPfUMd6msfxh55lnrIwW0Z8xm2aHTlaNEIJ+4Lthx3fTLgi4viDG0uCSzVYz/rbCgWjLGNVqoExN/tc5OwhBKV58R8ymMl5TKSH3Nk06egCy8AE628y9HHdEeq27JI6VEFDAn/C+rPDfEm8nuj75Yw0F8hn3p+OWQCPZ4vIrnVMDK4UqaN2RhrgiLANK7DUipSngpPn9TVCEhaKa35L6fdiFXxBl8My5fMkyK/YZQCeGaPHda0qtusVfv6BtlNbeD8FQqnbeblFTCNumGIBLbW9Qe/+5aPjbYVIXBQPtaP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llN4NQTUJ9a7DMGaQwKUvaqGKPVwPg4+o7ycXAGJH/U=;
 b=HswW3LtzoM0niF8O2SMThmbjurQU44gZ0Yb71JjaFp7KqoYnlyjFK9jmLJ+QCjoF5D/l1Xuk13c3vQENTDvyYR80XWLpMJc//w1e0umneDBQyK0WJgrvjcQHiZKAuS6u7w6/0dYvqTJEbbpzyHO1Hci4Vz7EHqqfKGzkAtO1M4/W0vEVLQ7QZu8PL/agLT2mB2n+ei4SD/47fyuroj8FgQXHoHYBfP4byASjd2FPVpuWnBWtBbZQRbnB8p/qBl0S16bu66gp7oI2T4MwkHB9pwV1nG1dwMlKG9KofszCZFYhB/sUo+ygTGdg30RAigSNoAAWIdQkJPGlDqgsoMSjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llN4NQTUJ9a7DMGaQwKUvaqGKPVwPg4+o7ycXAGJH/U=;
 b=PCcKhicPT6MwU2eOVLGEcuQp15k+3VWhRJgB6yrv9C4vq4nJOyd1QguxrdQ/ROQd8dX2KGMwWUUAM6YqhlHS+o4q+EI/96j1z916sNI55oXLk/Zyx5EvhT1B9RDm/wR6XxsHUd50EvRjt4n4WOPnlS3TcS8NWE7MbTxOKzHhLTU=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 11:40:41 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%3]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 11:40:41 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use wafl version for xgmi
Thread-Topic: [PATCH] drm/amdgpu: Use wafl version for xgmi
Thread-Index: AQHbh3giHrL1R9VWsE+mOsdPaZ15ibNX5Tew
Date: Tue, 25 Feb 2025 11:40:41 +0000
Message-ID: <DS7PR12MB6071C1DCF0DAA0E49B516A838EC32@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250225112617.120865-1-lijo.lazar@amd.com>
In-Reply-To: <20250225112617.120865-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c6d8c71c-4630-4129-a6a0-1f4e497b46e8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T11:40:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA1PR12MB8586:EE_
x-ms-office365-filtering-correlation-id: 2a569eef-1690-4e4e-b7c5-08dd55913b66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wVPH2Rg2xFpqAuse8PEhqUmyRZHAf2LZ9/P7k4sigIOTv0u/+37NtLLCVE4E?=
 =?us-ascii?Q?uMePXdI/HalXCmTSIhJVHiJqZMc5hgbv1am12DV50jM3H0NmHe3XGozCDwxv?=
 =?us-ascii?Q?D2guEOp2acLh4MRQFhyILqjExA0LSdEXOfu0cgCzMjDKR3PFXdOeptwb1t+6?=
 =?us-ascii?Q?BjrxXA8RABIXL2/UWRaNAkBbGwok/4jC5AwHbDmIW2JBQi27/WAzZo7eKh47?=
 =?us-ascii?Q?PvpeXbc5psHgUEy+qEfVOk+n+efVbdD+7IP35gl2snT+jQ5otAAJ29XzJmHI?=
 =?us-ascii?Q?t1229/VqjH3e+8EhybpRcO7fnVwfVKdFv0qBKta5g/sf25LMj7kQKaWM27oI?=
 =?us-ascii?Q?RgVkoMDbfPDEoAMquHzUOGZqg1TLBxg4BNNyMEPwobqFtY/UPW0oT3DUKiFO?=
 =?us-ascii?Q?jgkFqVIcxulbtf4eeIBchMaNYoDBxqOp/bbDdheIJAMgPI3yx8Ros6eKGcrt?=
 =?us-ascii?Q?UwTC2U0dAjkgOUJmWeaj5VptgbERbs9/BxTDh7XeOKYecy9hU5QDEgJML+tT?=
 =?us-ascii?Q?xUFtKIDZBx5S2d8jZyNMLtyzfrBanfTBVgoNN89rb4VaKKuFFy6F9CUSqbB/?=
 =?us-ascii?Q?KhnKK9wjsCIPzyrMzUQLxi71ikA4mXyAadzGysP3atICXNbr4o1C0xWDg3fz?=
 =?us-ascii?Q?BAiR0q0qH1j4/akwxLgXYz0TukACxtahuCZKlpFaISejYrBOeXIrRvVpmB3A?=
 =?us-ascii?Q?FrF0gCb5aydMrnm2cLk+A3qOv8YvNokygmr8vrFC4xjQgQQwH5M8wbv6pjJm?=
 =?us-ascii?Q?hmB8f7Mjx7JnjOc0n3Y7yWZ1/2+CrGB/l+N4Scxkjochhv4rbV8CssII0YSa?=
 =?us-ascii?Q?iM2cSzC35sZAyqW+0vc4u7nJhyrIuZLDArXj1H3nJWDfp9ItInBNZbJpWx9R?=
 =?us-ascii?Q?lA8uBTr116OP/b6r4LAvjRTeSKWUWpA2c3cgB6pCb5HL/QPqzNVP33pUJtIW?=
 =?us-ascii?Q?4Vj8aXESArOhxNJPdECbrVJRfe2ALT+HHwx0jtHnq9PS6WpFFQR/Gm/ZtwoR?=
 =?us-ascii?Q?bZC4nMyrntBGvGCMFAcqLNF+XqudyGNblluNi41+VZF+r8jHVYRBDatJvOYt?=
 =?us-ascii?Q?Z8R2XR2hEAAKpXg6cA69AJd5hRkWd6V6CyFrcqvVZBM7vsp/mtiBhYoKq1JJ?=
 =?us-ascii?Q?WewyZAXrPzr5MKQwjAUiWCQ40eVVuq0DsL4AZTvDgvNpXD/E/LV7Fz3URw/f?=
 =?us-ascii?Q?rrVeegZS+LCriuz+VglIr3RYc62pYTRoLz6gA/MRFNoeCC82jAedC6sQE3cb?=
 =?us-ascii?Q?a2c9FiEax6jMsC0jqF/HDLRg08T+gnycoMWWhwnI80oJZDgNNkaWBUt9bngU?=
 =?us-ascii?Q?JF4ls6hkwn4nzAPMUzMS/1Rk+sqgMdbS+4u/P+a7qILPAMX+0+zqVaYJ6WxT?=
 =?us-ascii?Q?i6Kho6HSb2aHHSsHna59YuSP8j4xGmVp89w0srG8pV5qevQqxyhffYjCDeZY?=
 =?us-ascii?Q?HkKSgaCZb6zz00azejxWGV5+d7wn5WiJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mqIYwRobi/UZFESXfEqq+7wEAY85XACmkTsUFsUd4kLOssr2ZITxfJcbBVRO?=
 =?us-ascii?Q?tgguZxA7YLd6jrzaunxwhYHahhMzioHKXjrUQBQISd0mN6mhTyDWuq9xtSH5?=
 =?us-ascii?Q?4FyFJKVMsUNiwiLCUKC78zMSab1EwBFVcn0dxwJ1lDetx7+atQHu/JEdo4LX?=
 =?us-ascii?Q?STA6qD8P2stnloGRP2Ro8Jejabyc1piizOtwgm1rrpg8OOxqTUa9UHmTAl+e?=
 =?us-ascii?Q?jQ8sQUxuqI1ZCa1BG6PW5zcVRnHt1OK2nq4TwyWE5cUMqq5o0sTgkcVshAGt?=
 =?us-ascii?Q?lqjtKN9QpuW0w1yWJ/AVdAtdCuUVQRXducP5urK8AfxIqjghMohqciqHADYF?=
 =?us-ascii?Q?dbnfLvsFn19JL//7QuTv8NVB2LY7biWjTpCaqDNGx4xU8f08ojJ8QcxuawLP?=
 =?us-ascii?Q?Macs/T1IdsfwAfb7PBrSOM4I4RqKSVMcImtE/mFZNMEVa2BAxk/JgFIBoRiw?=
 =?us-ascii?Q?TMxsPLm9kUQoaYVewr9f+jiSndMeUwXXx/S9RhSYqn74Qr9tGo1R8MArt85k?=
 =?us-ascii?Q?mqPCPmbVnhyXXL88XOtxP80YWX7GObAyCxJwkgcThCfI0nuscMnb5Tq2Jlpt?=
 =?us-ascii?Q?GWJO/1G2bDo5SF8WCDs1bmJErijKtepCRM70r65/pkPeCjfy+ACp+QgWFqiK?=
 =?us-ascii?Q?OcB4pcoPLxBN0UbezZBN8qBsSC1hXtNYLMrDzbPzT2pP6Djd01GxMjhMrbk1?=
 =?us-ascii?Q?TZxs0eefh3YXn9DP2QxF5fQnb2VfXRJQe/FuNmEgh+ZJLcurtmSIc4lpEjj7?=
 =?us-ascii?Q?6f1zNb5WhybgO/evddG6gaAkAXNME5wAystz4VDLZEXS68+3gTfeg546Lgxc?=
 =?us-ascii?Q?im0e/FXOmJvP2OLITuU+DxHdEBYbHpfzPfBW9bUa3jrv5YVhgX2CgRoFAI8D?=
 =?us-ascii?Q?QPUaJlAOMeSJ0OvKde/4kVVlUhiav8f5xLBjUkC0CNIvLpVt02OOGpuNXzbc?=
 =?us-ascii?Q?Z8L6mWCumBFJ2cAo+S3LKRtn54iGTcydUHZ8ycxqybnYVHCXmm04vYtnFkHu?=
 =?us-ascii?Q?EQW/3O7f1wsEBY2uQ7O8nmZZ346KZcFeA6d/bMRaP1m1WTz86qd8o74rmmmg?=
 =?us-ascii?Q?RI3KzDb6LUsXyr1rRjfe3bh39Pe4FKMbUD0aQNLqas4u+TaGLODhLQus4iak?=
 =?us-ascii?Q?f45JUfAQ5+QVZqAn5RA67xGRyDb1qeEo0CZOBj8PKdiSViolkGKU//FNzkkA?=
 =?us-ascii?Q?NQ4V+EciNS1eZHow8XhTfk/kRozQ6Wx1DGw5nhUrkc0I89/uFmHEc4Zm+/tm?=
 =?us-ascii?Q?yVh7LhMuFfGJarCRkpyCTOSTq0yPCG6df2ve53k2vqKBwyLpB+EaQNwKvQtp?=
 =?us-ascii?Q?KsmALI1tuVDY6CQTmqaLK1I0Jg6+A/X7FtW3C5+KT8rGc3FNsD95ekmJOTwc?=
 =?us-ascii?Q?7X+ms3XZzMvfHfD0n3DFjPsM9KCUesNMaoUYenMDyUd5QFBrXaOaKRVLeeeO?=
 =?us-ascii?Q?KIA4+IBfYfMt96xbLJ/RVnBA1yfHtkBZtMyFqY7Ol54xVfxfY99VuvcgdIYX?=
 =?us-ascii?Q?VH6xalCLZWVihk0L37kXPnOU4BymSgduVKZgmM0kBivSbb40zuDiNepcQJzu?=
 =?us-ascii?Q?tvqPBst17HhtGxPyY0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a569eef-1690-4e4e-b7c5-08dd55913b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 11:40:41.1497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjq4MsN1bpYDRTS3bw6B8T/Kg2nnjj5/+wpCXMVNxa0ELzOXInXzuzDOIkE1vdZL/PDTtG6J7VyiLTueHv7x6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, February 25, 2025 4:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>; =
Zhang, Morris <Shiwu.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use wafl version for xgmi

XGMI and WAFL share the same versions. Use WAFL version if XGMI version is =
not present in discovery.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 967a992829bd..8425e5dbf80e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1290,6 +1290,7 @@ static int amdgpu_discovery_reg_base_init(struct amdg=
pu_device *adev)
        uint16_t die_offset;
        uint16_t ip_offset;
        uint16_t num_dies;
+       uint32_t wafl_ver;
        uint16_t num_ips;
        uint16_t hw_id;
        uint8_t inst;
@@ -1303,6 +1304,7 @@ static int amdgpu_discovery_reg_base_init(struct amdg=
pu_device *adev)
                return r;
        }

+       wafl_ver =3D 0;
        adev->gfx.xcc_mask =3D 0;
        adev->sdma.sdma_mask =3D 0;
        adev->vcn.inst_mask =3D 0;
@@ -1403,6 +1405,10 @@ static int amdgpu_discovery_reg_base_init(struct amd=
gpu_device *adev)
                                adev->gfx.xcc_mask |=3D
                                        (1U << ip->instance_number);

+                       if (!wafl_ver && le16_to_cpu(ip->hw_id) =3D=3D WAFL=
C_HWID)
+                               wafl_ver =3D IP_VERSION_FULL(ip->major, ip-=
>minor,
+                                                          ip->revision, 0,=
 0);
+
                        for (k =3D 0; k < num_base_address; k++) {
                                /*
                                 * convert the endianness of base addresses=
 in place, @@ -1468,6 +1474,9 @@ static int amdgpu_discovery_reg_base_init(=
struct amdgpu_device *adev)
                }
        }

+       if (wafl_ver && !adev->ip_versions[XGMI_HWIP][0])
+               adev->ip_versions[XGMI_HWIP][0] =3D wafl_ver;
+
        return 0;
 }

@@ -2772,10 +2781,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                break;
        }

-       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
-           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))
-               adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4, 0);
-
        /* set NBIO version */
        switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
        case IP_VERSION(6, 1, 0):
--
2.25.1

