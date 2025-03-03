Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F33C282C5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 05:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A70810E1F2;
	Mon,  3 Mar 2025 05:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAfDXzzV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2635310E1F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 05:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE0DRPxKzz8kaawbkijN3Rov7K+Km2QLRys1ktr7azfHKWELbya5Mlt3vXO5Gg0mPQM3mjiASLtKmxG0Ab2MY89D6fYdaXiKfk5jplX6Lnd+UWAKWkPLZFDzYQweLaujUGM9kH3mINV4nTC2R28QoDdRLElOdMdEIJ/f81BhUQlPZ5UakWT91iXhm9MCoI14Goiw4PZULksZcXud1OiJ6vAG/QmnQXv6PcASEcAQBP6uWR9pbP9EohRqk9FbFp5IpVe2cR6La9NTYPlC8e+vou1o9hnS1F3n+7hIw2RVhYJraPZCkyY9d5gTokfIizs85lEtvfSaesHpcs6LjTFfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNCGI9xdwauYlIwEZPGshKrnHkahoWYZuSdGDwNaDyo=;
 b=cpLHaTq7Z0yEW8uTz8V7pvPQhTFHmp5Z7K2rCsscwgDDGL2DVDluXx0ZLMlFueLHS9s+tuiFaQ+jVaow59NT0E4IJxXeq9HPNxGotQrvI5sZZ66UU42Q37L/87z14J0nHDi8NEZPLHEofdI+hoynSjlkJCr4rQls9KECu6wGCepf3kBhw4K2J8hSQjsnKczasswnlHeIbvRHq3ustUViQpZD5A8WvEEdrUNvp1xtbWpqislDpF1CUq/qcRx1BKbtxTBEgercQO4mCERyXpUp2riwIX31ZrSPrSzNsUczAxCfzPmlwOSbKt3P6uEnZqr6DklgFtYeX0sXEPFpmMkUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNCGI9xdwauYlIwEZPGshKrnHkahoWYZuSdGDwNaDyo=;
 b=pAfDXzzVw73mE9zIqlEzeXLf1u36hUJgl67lqYw6hpCB2AP3uxP/X6h5u5JbTJ8FIAYL+Wnz9j/Oa0PZJu5VUflQtn6pEtIRFJyivKPqUQE1FwfM0UKOTUwQJkyJYWXcrJ26iK1Y1j3bmaeMiAf/IR6UmNYPEhL5HT3YDSlbB4U=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Mon, 3 Mar 2025 05:01:31 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%3]) with mapi id 15.20.8466.020; Mon, 3 Mar 2025
 05:01:31 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amd/pm: Fix indentation issue
Thread-Topic: [PATCH] drm/amd/pm: Fix indentation issue
Thread-Index: AQHbiSjlZIKQSDg4HkC3zi4Mzk5IsrNg4D2Q
Date: Mon, 3 Mar 2025 05:01:31 +0000
Message-ID: <DS7PR12MB60719D3B3E85CD58682753518EC92@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250227150321.813265-1-asad.kamal@amd.com>
In-Reply-To: <20250227150321.813265-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=576a6e5a-9117-4dd9-9356-33559a76ed80;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T05:01:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM3PR12MB9285:EE_
x-ms-office365-filtering-correlation-id: 6177aad8-094d-441f-f1d6-08dd5a1076d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VcXOF9HloDpqA7G5p4tv4xtyyegnnrh/CAbrV6NW1gsqi3TZOrvSTQxseBKF?=
 =?us-ascii?Q?DC7aGqPOLGAwnqtdYl1OhebHg0RO0PmEVSnb+9Ws8+/i8l4TQZ2xuX7Mu7dm?=
 =?us-ascii?Q?JoBud7/fhwqsd6naZfJQMG61SQMPXok0YipoHzRh9oaCAlj5Lf2d1dYyuL4W?=
 =?us-ascii?Q?qnPxpN238U42sZtwfgF+gNnbx/o6uMU8aSoTfTR0NNlyPnjfIo7IV0EmZvzI?=
 =?us-ascii?Q?gtdeX04dzLJAbiwBXAAWuk7VLb5tPUhk9Lq+AmwLjGml0Mvy0z0kbGO4sQha?=
 =?us-ascii?Q?yICFy9jSXIWJDN/jS2iZaRku742lwoW4cKoOEhmGfb3HyZUTnS+lHQmXjnEs?=
 =?us-ascii?Q?+HkmIDBcc5oRJ5GF+gTohoHqkmFihrIRSmDrz6Cqrljbjqe66PVHzvzd5dwf?=
 =?us-ascii?Q?JnTr4PelYZOgpYpfzILgxpAHhIqpYVRbbKyOlKtS8R37GeIif22x0fDTN/pX?=
 =?us-ascii?Q?4qhXLE06ProtpiHCFaZdpJYDeEmRPxrJ9I2WJXVxj5KfGc0mxiSmsXoxvTAD?=
 =?us-ascii?Q?RmgYCr03nNXqmjeJwfsakBp65UKNbbkT5lQdf3Bg2VYk7agQY3IlfGaRW4H1?=
 =?us-ascii?Q?Z/Vr0Zj4NO06Fi5+hnWYiZqhbRmZmGjkVdmoyyFF6NDxZl43it3bGCThsJZY?=
 =?us-ascii?Q?Im6qahvqnH6vjBnHRLxa5aXHI/ZvoK/X4jQFAnx9yM8Zs08YJ1QE9m0AqWZq?=
 =?us-ascii?Q?d8XmIwfFMDwl5PFSSzyHg6w8i0M3hm/ymkYkCx82Jok+bHYwil+74KRvg83J?=
 =?us-ascii?Q?TUfV3rLqyEqxhUyqPyPyHnWZQhnqtOA7ovroXxAdZokfTVuxAyv6FmPYNzmU?=
 =?us-ascii?Q?YyMXzge3b7y89IFu66C/3gB34y97mRBNRhBev1nFICV2qFpQxVT7G988Lhhu?=
 =?us-ascii?Q?blJQFJtYc6vA+OSdjXSretRNeP88Wv0b3v4qm//ER1PJv0avtxw8XS6P0j8U?=
 =?us-ascii?Q?sMgWKE8mKIEbaHU5wYNJGQ70IHLsBzxneJazb57mACRsZ9SO3GkIix1txbx5?=
 =?us-ascii?Q?LvAaG9w7aZm3Yp+8+UuZhziv8P1CFTm7KM5MBFUjY51j4q6nejSBPNu+Vo4W?=
 =?us-ascii?Q?LHt4NuRaWVXlHigvf0Li+B3wUarF8oZx+VghMPPfcMAJSxneupGhs/bad04D?=
 =?us-ascii?Q?cuHoY3t3C22hL2f/1+D5FU14WeyFf0jefkI8LanxBRkAU4+pUZj70un06Un0?=
 =?us-ascii?Q?f5M1ROmDFqCyxeaMYaFVc2kOSZL93MoQIZBjILTVMfUIO3cjlh724zI4DMbr?=
 =?us-ascii?Q?/IJJql0MGRGcrD3q9r31awIainzw2PQL0Tg8g0wWjW8yoLnL8c+X9+GLOjql?=
 =?us-ascii?Q?wZ/Pwv4rlkOXfZRxQPwWNcGZwysx5AQUUpsnYZwBtnnhKAcZmqkPB9nep5C+?=
 =?us-ascii?Q?18vdaUCjc/5U/98GmpAGIiH+1S99WKVR5fVS8bXjVzfSh6mBZjzyfA6lCvYX?=
 =?us-ascii?Q?9k84Khdgt1Ia1Hb4dM5wSR3FNBMyhV/q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KPD0dYw8gZJKOjlZs7lUf+4dmkXHX4J8lHDDE9xqGrRFMvjesTZhBC++J0rO?=
 =?us-ascii?Q?NxCVcG2XGG/rUbMuMb57td0xG87vLRLyjYSH7IQE4ZPy5/PD/C4aFZGubTN8?=
 =?us-ascii?Q?AnDNpd9niCCSYIyqjjqiu79E4Wnds+PzIC/Q0yWDBQcioR4ZULJxuaqa31nj?=
 =?us-ascii?Q?5J8wVbr5HtVLUIWkdJzTQSsHwqWmneCkd8GWi4IS6jnJabEhDpihNa7Hyx5+?=
 =?us-ascii?Q?F6eMi1PavYlaAgX/wyI+XQD1o/UFTBgH7VO5V1japYrAnsc6Y4p3uUOF/Hz2?=
 =?us-ascii?Q?tmjy0HeTlRa6pAiCsdY9dbz4qdeqOWHAcWKxO9rh4r9VdjYe0jhe8gXnragf?=
 =?us-ascii?Q?i/3hZ5GweQd8Dn+p+n4tE+oBBZX/VoXp5hLU9r7QjNv+5tmGAbL2nujO+0Tw?=
 =?us-ascii?Q?GDzq1s2J7GCLYGSvBdkmWj8rUgjLW0Xkb10QHM+TOxbQSVtOLkBy++CQYZSt?=
 =?us-ascii?Q?gXs3C+G46n40QIIwkjxe9XdOlM3ZD4y7gHDDr9zMXzWLcAqRAvG9UC8YY5GM?=
 =?us-ascii?Q?3/Simb3Q7wCRVHCPdmI2EIWf/xhlt0I2hcS7egqL9aS5AdOXYgrYfWDCzfCo?=
 =?us-ascii?Q?yu/FWOSQBmCnfbi1z+gXP7Ud2aOQs+gJg34/+UurCMVIoZwUe5Kx8p378wqz?=
 =?us-ascii?Q?La4hSPakD0AwSWPO1dwxocqruBBX4O14rVCKVirRSgpDIvw8pxZPXzOJ5Wvb?=
 =?us-ascii?Q?gSSkgvOFjzfWVC3S8WfVTiVHWF2GzX3xCXHPqyU0Zx7UHotDdJBe3oO7AvgM?=
 =?us-ascii?Q?YfWFt4CTJQ2xxKSQ4yPBp/7BbxW5tfrHFjE8qrUwmUofK//YRDdwkbJmhMxw?=
 =?us-ascii?Q?npgqlR8zxnI2U2tauOvYk1BStc35Oko492yYOefcc6l/o+Li2hH+apzLTQbq?=
 =?us-ascii?Q?UCIvdLlWQ2I+S+DaWOtk1ochSxq1M42U8ojgxUTg2Bx7rqjb1DqC9w0e3fpY?=
 =?us-ascii?Q?KqbeUihcWn42cE2lcJlj9kELdGLQyTMzumx1pun9l0Z5lByo1Dvj83VO2V+e?=
 =?us-ascii?Q?AyidriejbjhGFIkZvndkArO1A69atbl4G72rDdd7+lopjz17R911Gm2Bki78?=
 =?us-ascii?Q?7cA7zNhi0h+ocfNS78Py3r7LUOWaCApenWSjOlpPVERXfXIiMfTyBMtWAhLq?=
 =?us-ascii?Q?nMiqd7BfUoONzWZ1BvTz2GpvbUiegBze+hT/YhSr06eUKU3b0lw/ToVq9FNN?=
 =?us-ascii?Q?9efCr8ap7eJP1Q4h0o4vL5//15GIpNHgu+H3aXq/yUzQ6kkjMpEfVAar0x3J?=
 =?us-ascii?Q?iP3Mgk0d//ZBfg2eFGb5nd1w7jpa+uxqjIaM86H2WrlpCZ4DP69wFpOD2VHc?=
 =?us-ascii?Q?Xe7nvmdhurT2czQVlb0a+ahpx9docoHcRAXgQSdE50e0bvisoEUgMP/dHgnu?=
 =?us-ascii?Q?LnrNU7nauM+38MqAGL59KpmLyqyVeGkUOQXV5+QSCx10fjOEuW//NllNtjCR?=
 =?us-ascii?Q?r0XhVho7N7En7a8ztvenro+csQ7DUHnxt4cwYWG6K2zTSDTtSZOOJCrBQBWr?=
 =?us-ascii?Q?f7PMKseQVqA++EF1i8iPNEYnsv+4XbKyzQEPkw+6QZywvWGoODSFASC8LH7x?=
 =?us-ascii?Q?5jhvXx78fI+KLeqxMBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6177aad8-094d-441f-f1d6-08dd5a1076d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 05:01:31.6192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xT5k7q7nbUtOucTYWGjdJa/zM+6/ma6RCu3iPPa5f9oVUGK+tuxbrlREqRSWoz26JsiJAMK28laTxJMfSDibkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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

ping

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asad Kam=
al
Sent: Thursday, February 27, 2025 8:33 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Fix indentation issue

Fix indentation issue for smu_v_13_0_12 get_gpu_metrics

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502272246.OISqUnC1-lkp@int=
el.com

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5e80b9aabfc9..285dbfe10303 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -469,7 +469,7 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context=
 *smu, void **table)
                                SMUQ10_ROUND(metrics->GfxBusy[inst]);
                        gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =3D
                                SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
-                               idx++;
+                       idx++;
                }
        }

--
2.46.0

