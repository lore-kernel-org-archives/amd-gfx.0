Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95130D2126D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 10:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6EB10E1D6;
	Thu, 17 Oct 2024 10:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d4jNcQmw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3E210E1D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 10:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIjgZKV5DHpW48O3x9sRQJ2/znsQvvJFUjoDkjmBhVqGvxgK5f4lHVTmEdzC5CQhHWQp6wQUvXLM1glgt/dqdutH3hkJQi9hDYD/lAJpaYS/oG1ajBN3gDpLdhVPcM7Mm6MtGXlf2JHslNIPhwv62qnaJkh9EKWjchLbHWLOcxIu+VSjv8ShS3kca4RmKdJkIxaUJUZ0F21ygoGNpJUsc+o6sDLnztETPO8ZFWLmla9uSDFSpu1I3ml+qw46d79/+TXKUxyTguWKD65DuFGON4HCJmfTiN7L8whV4EmQTwFZ7RIZ6iCO0lQamLLP1UAlAVpMFpClcvteqzASHc8lJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXz51RpAExmn+qKZs9VfIEmu+KcT9v9OV2im/U2dHME=;
 b=o/yB6bHS+tgGTNj9Zt65gYzo/zTzUWlx8VF4MKWmJUSOZ/zYdzarR5xh/LGonUJ9Bc9ApJ69j2ZSQOQvuJ58/Et6l7vsVbK189njFOcq+0GifoStyC1MxrGbkTWDQeLoRficj0x/UpDOpx1ipLPHbLkuRN5zsVIqrCDQqfEwo4ZslZxLr0RWIrrcQ1eyXxA0bkxl0dCq5cxzwqRC3ey52qveXmijcWIcqoX/BGmTCsIbsukEoy0nnJXSkdfa43C3de7kJCw8MTAxK/AlPBooJWJ2oNuBI01LI1iEMLLKgiNmmsmlOGswo1GD2CUD+2RGwlDLXv+aSfhtWMnSxxUFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXz51RpAExmn+qKZs9VfIEmu+KcT9v9OV2im/U2dHME=;
 b=d4jNcQmwgud01Mt+YCYugf4BJ23BtlgzLhfB4dc7w6m5hXpSsskH/832STtfTG+6DF29muavENi6xVaCZ8H9BzsMNQo5su5wcChP9ehftfPkYqxTsZxVEWBSGR4QxzJBn0U90hCi2a86bPRjB3BdO/BJu54mnK7DOcjPpRdINnk=
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Thu, 17 Oct 2024 10:26:23 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 10:26:23 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the logic for NPS request failure
Thread-Topic: [PATCH] drm/amdgpu: Fix the logic for NPS request failure
Thread-Index: AQHbIHRe74858Bi60U6Wh/fikEHEI7KKvFMM
Date: Thu, 17 Oct 2024 10:26:22 +0000
Message-ID: <DS7PR12MB593356E92D8F0AF9F4463014FE472@DS7PR12MB5933.namprd12.prod.outlook.com>
References: <20241017090945.3069598-1-lijo.lazar@amd.com>
In-Reply-To: <20241017090945.3069598-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-17T10:23:53.2719543Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5933:EE_|DS0PR12MB7677:EE_
x-ms-office365-filtering-correlation-id: 35b3bc32-0796-4000-6dfa-08dcee9625ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xWv/Oo940tREgNCd9Z+kiaCi/6bn+IcOzUYK4zUJviF/8XlHHLH4KSmk6L8h?=
 =?us-ascii?Q?wfNGCunfQWMRuP7My8eLmvW3/paeFOJpcFyHOQeXQ5wNwHs6qw9pVTusiStT?=
 =?us-ascii?Q?dKYS47lff19O6OdaTpfVtKqHhYCLMBr6glxdGmOMTgGgTtjMIsBlVU1DW0d7?=
 =?us-ascii?Q?ZPc+MIIOpEm1+NPz+N5a3tWRXAcz/X4X2drCmHKVb0PuiCBGMUfHyKR3c/Qy?=
 =?us-ascii?Q?yblkMcApXdje20GSGKf4pWLfYSigkjgxjNkLY6nfrhrEP5UWlYAn2SsX9Mtc?=
 =?us-ascii?Q?H+a4rI7c1ypeL+I73CquubCzo0Bl5tX+a5vicquQTvcgsps73yEagJ1D5v5L?=
 =?us-ascii?Q?Oa0/D1dkBdRUNB0xaCGIV3F0JUMNc78UsjlLgEEtOWzHOgQ9YR6yQNbkB6X6?=
 =?us-ascii?Q?MI6fyACpqFqVFuL0gtwRv6zWSZDRhvtFZRk7GZsgtVTe91/HYkgOITmuhDAq?=
 =?us-ascii?Q?CMs4mZkgG/qGcNYD9gu2Owsqnjf7EjlKiDhmlpPIAaiZegt4z+s/7wpM5uvc?=
 =?us-ascii?Q?ZCGWeAZwWdEB6ZmG3SmljalL9aEzkq1OUmVqFPdL2DkTjTw0bfrklizzpYv5?=
 =?us-ascii?Q?9pRCLwU4ncLttkzb56/3Ji1hNuxBDojJhQLvrInuhfM1jCrjGTdYhZNZEDX6?=
 =?us-ascii?Q?fh/UQBQbjbAc4MWxwvZEjzjqD+YIEZ2CghlzBGlnFJ0WPYRqTjS2g8fBLQqT?=
 =?us-ascii?Q?LfLaxQngyo6kg4HwsrapnyBGt9j7zhkMSy5tL8JOC41BwjaicdtCxgELUUfC?=
 =?us-ascii?Q?IaI+ycg1ZcxKwnKE8K4LBrbhMvZ4PHbvrJUF/wDInb1l2/oDd1Lm9twtNR8x?=
 =?us-ascii?Q?7TWV9hxx2cSMxuu/X+zpwxUZnMUuxCc2sk6wrASTk1gEmJgy2YWng0Y1yPsz?=
 =?us-ascii?Q?vPVFb7kWPIsZudObjqBqh1JUlkQfkmOhvD+ySEggJVDHEyEEt9qBaO9JNLCS?=
 =?us-ascii?Q?/59/rbIVZ//u5Boj9FswtVVUICmDN3z8McqT8+yfqJ2uuZ27VWKALmTA1Sug?=
 =?us-ascii?Q?10D2aA3QatYJOcwFK7nEn1w2a2CEk6IHYNoLN56bc0R1OCbLZivMdPRzHWsJ?=
 =?us-ascii?Q?r9ZmeS1/e7Ix86ls8jU94giHwg5Hb/MX/0C4cj+qlSYIKIZfTrbaksG1GhXl?=
 =?us-ascii?Q?GGWVbYqMnWcr1ioJdnQ1hJYAHSVWdeswesZGbxzG/CEH8CnOK0sbFiTPYbeJ?=
 =?us-ascii?Q?IMf7RL7rT1upadN6r7GEzjl4BpsPwo8kEKsaXHmtQiJYXwKR6lSnfvz2vbmM?=
 =?us-ascii?Q?L0p0gpY8LBo3okDS9KKzNlUnJR0XDB3av6UkyeSimwmcSqWVHYl0ZdVvVtiA?=
 =?us-ascii?Q?UGaHFU9Ueuk0mQHwaxzkjZbSdJI24S8y64aCR862+SPCJzRwibfcJ49CyXJd?=
 =?us-ascii?Q?9ejPJUc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vsGPPtFUitMvbQzjP5IMRahmOE8ohrA0ndCq+hnk3pXF0u86R6lnPqFp7iu4?=
 =?us-ascii?Q?So5tCh/5J/MYubseDYUJaoFBcJynic0ev1s+YvK508+MVfkHfGDBSXxAqs4G?=
 =?us-ascii?Q?TSeJkfYMLCGcsgBWY36xNKAkGcbOp0lxBQMqQwuX3Z39FHtih94yfo9aqedj?=
 =?us-ascii?Q?scvcqxNuThm14zmdaxeQNFPjtZ9zM6L/VQfJsOI8HqatZlboNwC05lQJEI+i?=
 =?us-ascii?Q?Tf2wgmXOLIdLORrL+ku2BtXi44pHfjve/59xF2oouNizD1r7l4GkQ/22JNz/?=
 =?us-ascii?Q?my33NDUavyX2gyOZ+NDM3Yh0Bq+EgklJl1deIfJaU0JhrBSVIuUt+CA/nJWB?=
 =?us-ascii?Q?c4Ms6jMIk7W8DC7U6zO5fbvyei5eWwq8VJotWiRdNrFG0OD2YdYrY8T5LNBE?=
 =?us-ascii?Q?Nnj3vus3erE2euRe2yXyI1YArMG/+5PqH3zw/tbOOB5Qyo5HA+RZVFXedimb?=
 =?us-ascii?Q?HDuVB3QWkV1BUdDpPuIuOU3kdtWxDnDA9cinEpbv8dC6A6YWYYgSfdPIR4fM?=
 =?us-ascii?Q?P0jCNSpaG8MRsrQP73fVEsLraliB90CwPePKy+ZTRxg/SkhtJa5dPEuEZihq?=
 =?us-ascii?Q?ThMlh9TSAGsZb7MFgVHPw71ts1Q907iPq5PXoPxXufu2ZWpYQAl9AXLANEKF?=
 =?us-ascii?Q?0S+9+kkxdCgE+x05lzw4zOYwgPix1gSMVwtXCFGp6+L721G6K4XuiVIVqK+e?=
 =?us-ascii?Q?qciZOxYYOLieNP3elwjkgVuFEuJI5f3IH0XcY5hx5VBO6RdlX6Z0CmaAIFwH?=
 =?us-ascii?Q?STuXQXCAiZEJ7WXBqbcaEXOsMSRbeVBOxz2yh+x+I+cnh91WxjaVgq5AFSL3?=
 =?us-ascii?Q?96RkH+yyCQJyqf89yHCBRVQbW/+FyAWThZgaBdgob9ZkurKcNHuM6zFzEkFi?=
 =?us-ascii?Q?sDSX9E4s15+g/ll02OiXW3i8TcdBbgQzMEqmDCS0KwKoYNFt/IobgOU6mEOH?=
 =?us-ascii?Q?T0yU8fFvkW0rq+WNoUAmkt/Adg1vzUy0PKLK/pnCWR49qvG4cAb4dot+AKGW?=
 =?us-ascii?Q?tnrbOuCAAc+GSEXRUtF6JHangsf4IAB2l7PjIZm2zSmv6UYN93uTNJfNGAWp?=
 =?us-ascii?Q?guYOPDpHpCZ6W0cYK15NOOSBzdPiJhC/ORLi9J4mwSy2KfYIqEgCv23Z9hAJ?=
 =?us-ascii?Q?c/DxyZcEqyQ/a++OJc+nopJZAJL12R3fL8xbjdAU2PZd56ppSIkMa3Eb4LzA?=
 =?us-ascii?Q?HRWmGqTCzDhKHpQLTH6fDK3vWZrMoX05fvfyT3gs4nwE6s5EHIaRUYIO4jdO?=
 =?us-ascii?Q?tSi3dtnMf3ng6nulKV3xLIkwv965yLIJNA3MJlkWHLtl1N7kwtIiNPN2ZJFx?=
 =?us-ascii?Q?7KyFds1lT4fItaFZqVWXg5vuPJf4BgzdmxBPFiPoJCpVYHN2Qe+lADZXqA91?=
 =?us-ascii?Q?WnRZ98KcHGCxhKpwWElEysHesO4825oEbRKgvn4udPbQTiLKb/RObALAwHCf?=
 =?us-ascii?Q?x8030aPxcetWYeBwkp7aWTsqPjTUv2XptD/FiuyPd9HGo0cl7vxKC003LjZ6?=
 =?us-ascii?Q?b2PNb4xiEvasGhjmZirXazN98FZRPtwf+YcsXBLdncabxa5ykDP9oyJf6hT9?=
 =?us-ascii?Q?wXie9vveb6nRA2Dxg9CgDrwbX37JhjT2kWjAYX3jxTPTPO5Xj/PGhwaCxiWn?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB593356E92D8F0AF9F4463014FE472DS7PR12MB5933namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b3bc32-0796-4000-6dfa-08dcee9625ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 10:26:22.8466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diMayh+cFnLddVmmhKhOJVgT5iRSs+TNBIKON9hiacDmJINY6K6QIkU9JnBLflY/yRyZbAl3xe/b3QWFYaNwZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
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

--_000_DS7PR12MB593356E92D8F0AF9F4463014FE472DS7PR12MB5933namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

one comment belon, other than that, looks good to me. Feel free to add my R=
B if you send a v2.

Regards,
Rajneesh
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, October 17, 2024 5:10 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, =
Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the logic for NPS request failure

On a hive, NPS request is placed by the first one for all devices in the
hive. If the request fails, mark the mode as UNKNOWN so that subsequent
devices on unload don't request it. Also, fix the mutex double lock
issue in error condition, should have been mutex_unlock.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 44d5206ec07c ("drm/amdgpu: Place NPS mode request on unload")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 +++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index fcdbcff57632..d2c25af2c5fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1586,26 +1586,29 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_de=
vice *adev,
          * devices don't request anymore.
          */
         mutex_lock(&hive->hive_lock);
+       if (atomic_read(&hive->requested_nps_mode) =3D=3D
+           UNKNOWN_MEMORY_PARTITION_MODE) {
+               mutex_unlock(&hive->hive_lock);

Maybe a warning or debug print here is useful?

+               return 0;
+       }
         list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
                 r =3D adev->gmc.gmc_funcs->request_mem_partition_mode(
                         tmp_adev, req_nps_mode);
                 if (r)
-                       goto err;
+                       break;
+       }
+       if (r) {
+               /* Request back current mode if one of the requests failed =
*/
+               cur_nps_mode =3D
+                       adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_a=
dev);
+               list_for_each_entry_continue_reverse(
+                       tmp_adev, &hive->device_list, gmc.xgmi.head)
+                       adev->gmc.gmc_funcs->request_mem_partition_mode(
+                               tmp_adev, cur_nps_mode);
         }
         /* Set to UNKNOWN so that other devices don't request anymore */
         atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MOD=
E);
-
         mutex_unlock(&hive->hive_lock);

-       return 0;
-err:
-       /* Request back current mode if one of the requests failed */
-       cur_nps_mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_=
adev);
-       list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list,
-                                            gmc.xgmi.head)
-               adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
-                                                               cur_nps_mod=
e);
-       mutex_lock(&hive->hive_lock);
-
         return r;
 }
--
2.25.1


--_000_DS7PR12MB593356E92D8F0AF9F4463014FE472DS7PR12MB5933namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">one comment belon, other than that, looks good to me. Feel=
 free to add<span>&nbsp;my RB if you send a v2.&nbsp;</span></div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Regards,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Rajneesh</div>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 17, 2024 5:10 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Bhardwaj, Rajneesh &lt;Rajneesh.Bhardwa=
j@amd.com&gt;; Errabolu, Ramesh &lt;Ramesh.Errabolu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix the logic for NPS request failure
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On a hive, NPS request is placed by the first one =
for all devices in the<br>
hive. If the request fails, mark the mode as UNKNOWN so that subsequent<br>
devices on unload don't request it. Also, fix the mutex double lock<br>
issue in error condition, should have been mutex_unlock.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<br>
Fixes: 44d5206ec07c (&quot;drm/amdgpu: Place NPS mode request on unload&quo=
t;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 +++++++++++++----------=
-<br>
&nbsp;1 file changed, 15 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index fcdbcff57632..d2c25af2c5fe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -1586,26 +1586,29 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * devices don't requ=
est anymore.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hive-&gt;h=
ive_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_read(&amp;hive-&gt;request=
ed_nps_mode) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UNKNOWN_MEMOR=
Y_PARTITION_MODE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;hive-&gt;hive_lock);</div>
<div class=3D"PlainText" dir=3D"ltr"><br>
</div>
<div class=3D"PlainText" dir=3D"ltr">Maybe a warning or debug print here is=
 useful?</div>
<div class=3D"PlainText"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, &amp;hive-&gt;device_list, gmc.xgmi.head) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;gmc.gmc_funcs-&gt;request_mem_partitio=
n_mode(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_a=
dev, req_nps_mode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Request back current mode if one of the requests failed */<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur_nps_mode =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.gmc=
_funcs-&gt;query_mem_partition_mode(tmp_adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry_continue_reverse(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev, &amp;h=
ive-&gt;device_list, gmc.xgmi.head)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.gmc=
_funcs-&gt;request_mem_partition_mode(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev, cur_nps_mode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set to UNKNOWN so that =
other devices don't request anymore */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;hive-&gt;r=
equested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hive-&gt=
;hive_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-err:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Request back current mode if one o=
f the requests failed */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_nps_mode =3D adev-&gt;gmc.gmc_fun=
cs-&gt;query_mem_partition_mode(tmp_adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_continue_reverse(=
tmp_adev, &amp;hive-&gt;device_list,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc.xgmi.head)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.gmc_funcs-&gt;request_mem_partition_mode(tmp_adev,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ur_nps_mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hive-&gt;hive_lock);<=
br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB593356E92D8F0AF9F4463014FE472DS7PR12MB5933namp_--
