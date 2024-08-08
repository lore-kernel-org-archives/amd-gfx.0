Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE20C52D6F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 14:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34E610E749;
	Thu,  8 Aug 2024 14:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXFTIJv7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE64210E747
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 14:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Se3y2xAOus6sHFrzMbgjOvyGFl3VLmw8WCTs1OmR4XctIKlCFoN7IHCS5px7rZx8FUcBzmwUgJoJGpVHsDWJoooDwCtATrQKvP5gyk0KsrpvCun/2TKHSP39PRXOrJic5oA3pfwGxtxYtigX+w6q94eAEo/4LZ2AweVQY7hDwxMRJWNlDXw+/Zp/6+HZr/he2x0hUE18EFYlf0fd8tnwfoHsji8jqkG0S0nExerQL31vH7wqrkFrc442zNQgzBgalA6+h+20t/Zg4I0125PDR5CSyKOffHSd7qVFlE0wIYMKelr0I03YTgZO+22WOdneUsUFJvXcKVoFhSkbU+rQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YdlwX3wNQ/ETO76d0RAV0HbgkERgICXooQWqDORLkc=;
 b=md1UYZQbP6EvvGNiitFEZN0lli7gDYMEwKtWsFonsqPj/I5/cqY32I5Rx2qvFVYJpcxg5IdR6mmT2g5B/u55lkztmy48M3l3pgGH8CATEL22p4HkSiGP6FV1rE8CnI8ncoyDTinsGGKiZINYC109N+SdCpq5eSTo2/K8lPl7dtOhaQ40rKy8aIpKLUW+5fz0cFRmaleXEPNApdFjVrIEsA7S+1hB5btvfSAU4eZOJ95mE6PtizSQzgstjnIK1dqWVSkOizEXjNQ4uHSAnoManoG7BFg9ZbvlL0bP8HZ2FqdBzdkRP0cL79aKG8pNdMJXask2cKEmVQu4crxdIccNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YdlwX3wNQ/ETO76d0RAV0HbgkERgICXooQWqDORLkc=;
 b=eXFTIJv7q2IOgQfoJZmUB1CqvhmPEC2WWGMqkukqekaXQvkjgygYO4IA64ldf6uXbK2C/oEUddgoGQ9dCnggZgzFpXNuwnSZSMEXc/Cx2eIWuwmba92N2q8VOL01xeHqKCR2PpZxZTSPk0Bdla4UhVYGnBx1nu34WzHIlfFMDys=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 14:45:32 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.7784.017; Thu, 8 Aug 2024
 14:45:32 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Topic: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Index: AQHa6W9DVHqxalwqmkqtP15QR3xp+rIdcBpw
Date: Thu, 8 Aug 2024 14:45:32 +0000
Message-ID: <CY8PR12MB7099066850F032CF0AF32A038CB92@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240808084421.2755417-1-yifan1.zhang@amd.com>
In-Reply-To: <20240808084421.2755417-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c7ce74ef-11e6-4d51-ae5e-3b7353d05e3e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T14:44:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS0PR12MB8198:EE_
x-ms-office365-filtering-correlation-id: 3ab0287e-8345-43e7-1812-08dcb7b8c167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9GRP2FzM2G5ztuqKPsIZnz94+MzihsYbrpO79zIAhdn0ax1fdZttl+GcoZr4?=
 =?us-ascii?Q?3cGdbBcsetmiQkgbmivH8e3cgd5gk5qTTS9Wxn4baw3WtPG8ZAzRJAd0U9dG?=
 =?us-ascii?Q?C00ZfmXj2ZxfTq46HKHt3v5WE/funHY0SvJJfpXwVSGSV5If4iuN3P93X8zQ?=
 =?us-ascii?Q?d93NxJjpBioLDD/aWB3eJi66wf4CLf4WiiuscTeIqaDa/JIq0E5VuhujWSyF?=
 =?us-ascii?Q?7uG4EwKlpB5tIZ0ey+EfmrFOhQ7brQmRydHIQV7uSc54iEGRkquSbBUDUNlh?=
 =?us-ascii?Q?tms3ZBuYanaM1fd05Av6oWvD0W6s2X+JnjG1qnVEVJ11cy0E7xmRvTdzKq1R?=
 =?us-ascii?Q?WVTUPMuCBpTG3ZQjBbH44+rIKCMupbGUNI2ow0Kxdg4eWQeA0h9EpzNkZS4v?=
 =?us-ascii?Q?aJ7tIjmZNrfnO+l1dTzdedp1ZRR9UhtFCYVaUnI/rIWL0jFMTD4H9805mPFj?=
 =?us-ascii?Q?5+O3jR8yApz7GjaiUNjRCIsdPUvQX4cVFmpbfGDlomMVWJHU0KpqG5xHk3+Q?=
 =?us-ascii?Q?w+zpRzdC67+MeKEmJHddMvLBnLlCpHMPycyci6iP7ryU9K60oE36tV7FxS1M?=
 =?us-ascii?Q?/bfFrhSjZSKWH8kwTx3elRQiqjgxpCfQ55nRn+bSUSIN5Mpdi7mQ1ewFUBp0?=
 =?us-ascii?Q?nDQbKMV2LOJB/D0n2CEzcc2nCd4+U2q7HavWfV29bVySDpT2dWsdIZcAyOW1?=
 =?us-ascii?Q?jhAW+1SnEE5LHBqLp0UordwHcg8qNz4owNg9/MazWWeInNwPeiJaIf4K7Xsg?=
 =?us-ascii?Q?4KFLGIAbpqpFihRRQb0dt1s31dS8q01yBUARS1rfv9QJmn1xCRBfHOSRRmFq?=
 =?us-ascii?Q?uDXb9Jv58NldWmLuVWZre/ETlY/RXHZHdYCPfahLRhCLNfJpMjfUvrw6Vl/5?=
 =?us-ascii?Q?tqpdKLhulXr7ZszQIURDxtEvdqx5MJUI9A3o0nXeTsQGVX94TM5UcLjlMMGD?=
 =?us-ascii?Q?8LmXBXRQI7+6J34RlnG5f7HYrtH+9+LoWJHMeTaXDwuVNOTNYmbPHoL7oQ9P?=
 =?us-ascii?Q?5ZiYLSe7KbCEpvjW43k/exdkV7pKSAXgZuDou4ta/zbuHmKpCiXfNzu1dsOG?=
 =?us-ascii?Q?whA4TETND5byUZv7Xt4vjz9mt5UIfanHwa/xUwUdnHdkNfaNCeAQ2ZzMqS0F?=
 =?us-ascii?Q?pYhZxCDI191sRwQSHhpqVnJmxznTcJKM2M0rW5TK/7uoVr+pZ/q7/Z8g6SU0?=
 =?us-ascii?Q?vgT2+tVXDSis4qcS1I2WsEY1DxURlp/+4zSFdJzYfxYgPYErLbEP8e9dBgg1?=
 =?us-ascii?Q?YeKvtwW4rOjHb0vnHISLyvCq9F/ULAQ/2UMequ9nQuUQAaFjXKftmx3SXNz3?=
 =?us-ascii?Q?CFRXHkDx1kNrPjRokZn8r5P9dsHWXdbRd7jOm1vxXIb5neLmms4LANRhKV0b?=
 =?us-ascii?Q?7oGMJwagSoiCIRpIZnngED8EfdLKyfm5D2UxaaqEYJ+qSSTjew=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yAuSV3x1rxx7rfFkUlpoectKgm9CO76nZ1qrlPSGYFih94a7+H9lr7iHyISs?=
 =?us-ascii?Q?c+eAGGepQwiR1iq3ijSj+LQhcJ/F1v6flRj7VXRG7NPhfhTp0oiaqYeBCJbB?=
 =?us-ascii?Q?X0IPn+XkpTXmCNgEPKIhs6zlP/13pls48GBZv3xAMy5EswAGG+wujc7qp3QS?=
 =?us-ascii?Q?SK4zuWENYjuF56e3VOpF1+dKHkAO97bssY0MGBkIOACMFPCg/d2UFqlwTm75?=
 =?us-ascii?Q?TuYo8FSF1z54WorC2K+jGoD9wvqbLfQeZNW7WtGTcgx67oHByPzIg6/TPBH6?=
 =?us-ascii?Q?6QZcvR/kkuaQg26Ki01Y+ptl7kFsw4r7/hC3EXvgcgIqC46GXEhLhXxeFlDR?=
 =?us-ascii?Q?zoQf0rqhR0gXIrg/cnohMGwkJ6TQVkoau0KCKiWzIuSz3qOGpmiX/d2YsMQN?=
 =?us-ascii?Q?zs6Ojw8yfqeraiSliuaQuigWX/rvCNgppPon//aFTtnaDsH6FGU48JqZH3kj?=
 =?us-ascii?Q?LJRP0Pz+YmE8CqROES9aIgMpEozMWmfZ5Z4PLlzP+Y9Mn4rigWxoHj41op7y?=
 =?us-ascii?Q?E7RCF7tyFJ79Py5kIjSrrIiPo0xLUVnnWzcOkwfRBmu71ghlTsYbcD+G5Fct?=
 =?us-ascii?Q?etdTp8jNbRGE3Qp1B/Ea/dRAotX8aFu4Zztg+3V3JhaXt9DIlZRDZyIZMH3P?=
 =?us-ascii?Q?J7Z39S0li7OUeALHBGlYjQPFr9YF+qaPwweMat4qkmvCQahrhcSq6VonMWn0?=
 =?us-ascii?Q?IB6Ao/BvoT+9K89WOaeuEVC6BJQuXo6tjh7h75ZUmwq5fyuZ4pLzDqHutSU9?=
 =?us-ascii?Q?VPpg691nKX9lvALXs6pOg44WFGZjL6bdFMgFaHxsbKo5nSZo3hkQu1923Jwt?=
 =?us-ascii?Q?5hibbJit5q0mqDo55feUwDtanzhd7Nrag8GhXDI0EdiNL88fmctvnlK8xVZu?=
 =?us-ascii?Q?1cHZrVCzH+AnuIbjZxD9dWMtLp+FvcsNSHLhWIoBGAxs3yCc6L79LBhrVkON?=
 =?us-ascii?Q?Bvke4jnepQZ9vrkqMIOm3fo2R0ADmYALklPFyjVADnts0PkGQVzxWz/g9ubz?=
 =?us-ascii?Q?qrOjjyYDAO4wR6nqIsxErEJ7c/ITDAK3qLd2VHGtcao+IPMF47qBfmJJxQQ+?=
 =?us-ascii?Q?ud545XzmlQPSXLsxchh+dkAV5+Yhu+fMhabWekeG8rvYZWpI5Ixhtcu+PUoj?=
 =?us-ascii?Q?Krnr4lEBJz9NPnMCMweY1tPRxJQ6JTZarZ+6YzfCRgBJ61IxvI0AHJYADtuP?=
 =?us-ascii?Q?6zHzIdj2k9OBMg1y0rNchFhiPt46J1jF4BvHk4lS1gat3CfuLeLxnM9x4SyY?=
 =?us-ascii?Q?3VXI93SsPycNbjohsPOpffM97IJBLg/btmH6Vk7BHlGsFoA3xLEdJ4geF4vy?=
 =?us-ascii?Q?jiKC0o+ysKhfOruPkTvySf37CvqP9ZS9QiKCa06p2UQhvmb0WXpxzt3jgftG?=
 =?us-ascii?Q?TggvPBz5pLRI+GJsFw/0qNk/ukE9FA0czHf6vlcyAoJA6/cgFYz/p1IXRmUb?=
 =?us-ascii?Q?CCuxAMn1LptSUbstgE4VThe38cUiD8S6WPup7k7dcnviH9SUD/Bh1E4YZ5yx?=
 =?us-ascii?Q?4O3nqS4VjuWkPylzAjxwGfFOLzfC8sgZx+6Jc5hq7aVc/SSSK+h/lo3JAfyH?=
 =?us-ascii?Q?hqh5Rq3iqFCTgF6WaBw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab0287e-8345-43e7-1812-08dcb7b8c167
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 14:45:32.6081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16f5Bo1h816Y4mIVsfKkZx1Kk+KmS+GIXU8LEOzRryYld58Zdk5zv+dfvFu5z4i5z+f4S+69NifMhOY1qbBnSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

In this case, shouldn't larger of two sizes be used. Also, we should have a=
n upper bound check.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Thursday, August 8, 2024 4:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd=
.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: keep create queue success if cwsr save area do=
esn't match

If HSA_OVERRIDE_GFX_VERSION is used in ROCm workload, user space
and kernel use different spec to calculate cwsr save area, current
check may fail create queue ioctl. Change error to warn to make
create queue succeed in that case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_queue.c
index e0a073ae4a49..9f283aff057a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -295,11 +295,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_devic=
e *pdd, struct queue_prope
        }

        if (properties->ctx_save_restore_area_size !=3D topo_dev->node_prop=
s.cwsr_size) {
-               pr_debug("queue cwsr size 0x%x not equal to node cwsr size =
0x%x\n",
+               pr_warn("queue cwsr size 0x%x not equal to node cwsr size 0=
x%x\n",
                        properties->ctx_save_restore_area_size,
                        topo_dev->node_props.cwsr_size);
-               err =3D -EINVAL;
-               goto out_err_unreserve;
        }

        total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_dev->nod=
e_props.debug_memory_size)
--
2.37.3

