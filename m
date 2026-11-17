Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C98606A329
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CvNMLFD2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2ACF10F65D;
	Tue, 17 Nov 2026 11:40:40 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3521B10F54A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 11:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAWPleiadvkwsGgQ8UVmo7oU/ygRyYpZJGZJQQqupJ3G1qlXO0mQuz7AGF7eN9bWaTmcdC6qTy4wfXAN8Arbss/qdr/GN9ELJ5cY/rsx2aQoAXmMFQ0bcceT+tAfBGdPMWC/jCxRjtz46wBdKrVzAEvq7I8SQdoLlR7Zsq9/KUZKhV5gi2mSBdrsi97f8gAKZ1xO/X6UNXJvBYv2g/lWvF0S8Q157cemLgo8JTbfq9JV2I8BR2NJkxZYp77on/8IgomWwI4EB83QrBbjMppYyVp20cb+pzCKQAlpx8eTEBRcO8nZY2gkh4giUr6fgMZOzLXnMToSjI4P+CFCXLi1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdpYegRgjp+4wG1OHXRsTPnSFRjLGcSzW5jFs08kJTM=;
 b=LFRkUGWFLdBmR8/0IugIN8jnW9LnFaPDXu+11Iubx8vAoZswr2nbuQ7w3/ZmhT1aUfT99MqIRt4X0QO64jDYAML+QDSAn2g8n0Y9RXDkJC2wGhD+GsXa0BjU/RFmACNnc30Cu4fKj3+ZsnYNEC8R+LkhdE5h4C7CgRCdIclwf26Qtw3h/iGu+cjf95szUI4CBSylPa37DlWWFlcyP01wnWiyqDCGU8qxUxwS+Nau4nGVvCb+xoa3a6gjy3aO+D8N0yr82Huymp5TXT9zkr9hcjg0fpIMr3JW1nv6U+5Yjc5gYYiwtQMB+YGW3A5bwPkvhZPvKCmqgTm2xXHpzraGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdpYegRgjp+4wG1OHXRsTPnSFRjLGcSzW5jFs08kJTM=;
 b=CvNMLFD2Mv0foWb7A3RsiK/mu9VG9y3iTLu+qDGT49P+eTz2ULQ8NIsvtQQWKfo8p7JWtLBl0C5JRfUSRnMkNZTJcrXLVrdITBRcX03iAQKhisAHSu+6nSuNMHyuTy+KAIaECL60RMGIq2bjfkmrvIl2iFnfq4HtjyMU3TevEFw=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 17 Nov
 2026 11:39:58 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:39:58 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v3 3/5] drm/amdgpu: finalize partial VM range updates on
 error
Thread-Topic: [RFC PATCH v3 3/5] drm/amdgpu: finalize partial VM range updates
 on error
Thread-Index: AQHddohfaQENRaSFGEicJAm8thB/3Q==
Date: Tue, 17 Nov 2026 11:39:57 +0000
Message-ID: <MW3PR12MB457285A4036148B8A5C077C19E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
In-Reply-To: <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|SN7PR12MB6861:EE_
x-ms-office365-filtering-correlation-id: 6f5805e9-65f7-4f5e-b7df-08df449f81ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|38070700021|261026121527099003|261021121427099003|11063799006|4143699003|56012099006|261009223027099003|261021123027099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: bsTZrc0OoGOZL7wufd4Enmr82OOOhXiMQsmuHxeIW6/H6rqN2qGlMwNSy2oaa83McoigxVplMPiFDL+TryUmMTkT2ZUhJncWJ/Q8wbGiXqsd+djd0ianTPGRLkZwAQjeymzNzEvptO6H2APioxqJYXfE/0wApeqCQFF2mOeF1paKaUh6de4jUo2ZYf0kB2Wzw7pwyQb6T7N0uT1tlQUwd7MGf9/iBd5C+Mo8/3JZyslLkTDEMzAc1CunJIf6tkKx2jlpG2pMXViYA+addpJs6Rkz7L3X6FN0m6IpXrASoAtQvKHVinFHK+Fw8gVoQ/MHtAwqGkiOXASb5BGOklNuJhBBknPHmU9HgEasCb3PW4UuJyLXr+wL6a9WSo/cxjoxorp5YRXolC9n1E4nsDdHTujxHlDDIWtqm9lY2tgZGB9bsGBooMy8UJwjEfQlPyWFbwXi/O4fmFBJbwiTndoOC46vSHDmKK6UISBpiE5ASZZCl4+e+0kQed5ppHpY92DzQU5yhYAv0vtRYrB3y0WyjrnF2mJ8NOscUzU3xz9yxIunU1+HOXkNGzCRgA3uWM/0dGHfrTu56NJrPHWyHUhbBlLrPrOZjITSz9m7nX6tgsLxfKNeKALb0ZjFAwlWfjfb/ApKurhVDPQ+TbN4gOhYWDHkLTy8OZZ3hin1CYmwehQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(38070700021)(261026121527099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021123027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LEEqQZN9GhYcgcLErc1eCNnZw0IKKdIr7gxksk6BvvTQMlsQpa9tzzzBaqzW?=
 =?us-ascii?Q?nn72ofzKn+NrvZog9kRFLrfvXn0RyitB9+7TeRQuf8Vca5irSiEYtvg+wJbx?=
 =?us-ascii?Q?3gQt6K0cf10eRP2I9rxgSsD70nnL8JRH3weuBpqsJi9b/JIQtnOdeTjJi2wq?=
 =?us-ascii?Q?0OuoJVGbDEULsuz3yU107m0cifFjUAcQi3OyHX0bINtP9l1A4o0uIrW0FGHu?=
 =?us-ascii?Q?BjM5LgO9XISz5m4FiFkvmXt7a9he5L8YT6O4pqNyA7/JE+oowt7S+/gGy+/s?=
 =?us-ascii?Q?C777SpyjiS7kGizFirf4FpuYh+8Paa1NlpcCP7mzf9qFLFfXeUlzvE/P/DSe?=
 =?us-ascii?Q?ispk9tZDg7FavDJXUPQS/bgYpa3Y22bW2HIER6L4IMpmQxc/KNfx6wIfLL5c?=
 =?us-ascii?Q?zEnba/Fy2MSsc6ShHDOwtWFIs0E5jcfWUYFjJOakYShci+twC5FuruVQBezt?=
 =?us-ascii?Q?vzdD8P54TmlN3U2plHOhV99N/mMOuw/pfNKqPahj+if5tG0FT9EvPydqm6Vc?=
 =?us-ascii?Q?Yi7rT4nG+l78NVDCbMsH4RFmJOsM1MNrfgL6UqLBWUKmKrb61UdioHM+o/yf?=
 =?us-ascii?Q?SpBREskD7hZK6Ob/+VMUIiQOtKtErZQRpTQVLaQ4bAoIv8zuK06Te2bKWuQo?=
 =?us-ascii?Q?/BnlkSdfk+jtDIIgfgYE3MON2c0PTJ79UIJ5Ulo+N73W5ziumfuu4pT19j68?=
 =?us-ascii?Q?nW9Wl5PKB6x+4XkgZCUd8wadVrMx8KShrVh3Js9W2WDdEQOumEDlLFs08Wyu?=
 =?us-ascii?Q?UDbmWIh4b6wljicqAwqmE2pdwBl+za7j0UI2tzfGk8b2CEQoaL1IniuzATT4?=
 =?us-ascii?Q?Q+xqtOyUY0gmXR9wbfo6chXyVur0TJhBGX9sXsuTpc92tt8NoCq3cQ6VroV4?=
 =?us-ascii?Q?xL+T9aWYrGSXslm/dclsjmW9CjJFle5i11ork1wxmF0U/LJMswXdWEfOUoFD?=
 =?us-ascii?Q?beK6YMajrGkthqTisg0ZWHQyNMEJXGlL4L3ys8Omew3+TlIggombE9qLmVd3?=
 =?us-ascii?Q?1qgfytWJIW3I8079U2XVwXUYjQS6LbP5tf0DRWlHlO4OBDgjSMBssKu49Oyc?=
 =?us-ascii?Q?s32W0G0sXeN2b/e1yHadkFJNNurI9yq68aSX58Zp/EAL5wodGceP4KsuOLrX?=
 =?us-ascii?Q?uXqYWOe3dDdKBn2rnhLf7L0ODGtrNJnut2uLIcxko2ZGE1AChIl4Ksw5KCwP?=
 =?us-ascii?Q?EmVhbVSAJ/g+ZLv0Fbf05krn2FJ25Iv4k4HjhGNm3r9Nhr6thD3XqcB9SVpq?=
 =?us-ascii?Q?wWSIPhNbNZKbBMPhforQWqo5Tk9aCAPf0ajYyHa6iuB4P8jYtsycY4piKrHn?=
 =?us-ascii?Q?AXRj8U+QDu+NZIJ0URBMRA7KrruHQ0OYuAkKoc5vg0TH8qAiGY+vSyjbFKu0?=
 =?us-ascii?Q?kz6oQqScdfHamvzWGkShMYGByxa1tyL15I6/KXPgvIAvAsiwhDv04sby6WDb?=
 =?us-ascii?Q?YPfWj9K5xoszOKSeX6MfFeBoOwQWJ/rrY1mVNLLw59FAEq4kvlygYlY9snkj?=
 =?us-ascii?Q?9rL7joudql5437XgWzOV/Petc7S1himgPru9zB9vDf4cPDk6k+ZBnf0F/y+s?=
 =?us-ascii?Q?35bp/KolhqmtsRNeOkfBjBS+13kmNOHPgMVEpfYwsfFm2/6kX7RsuPYeyDC9?=
 =?us-ascii?Q?u2AESDF800t2CPhff/kTXhnXkP/kwo4SMsCxo4vMAi5TKdVJedqByUnZSJHU?=
 =?us-ascii?Q?crnDyC/OV2sNdegF2IIpcuYfUJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5805e9-65f7-4f5e-b7df-08df449f81ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 11:39:57.9940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxIIH8ClQA47kpIMGBVkw22M6EqHTZOmTBFQbzAdbz4Z9T6oX4ZwdNoygWw08XSL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Stop walking on an update error, then commit existing work and complete
the TLB and temporary page-table-list cleanup. The void commit callback
does not overwrite the original update result.

The preceding internal completion tracking orders finalization after
the latest submitted IB, including immediate and rollover submissions.

[zmu: Rebase on commit-void and the internal completion prerequisite.]
Link: https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-4-d6d8355=
91e0f@igalia.com/
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 3b4df22c5ed..3f3c5a82fc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1276,7 +1276,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
 		tmp =3D start + num_entries;
 		r =3D amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_free;
+			break;
=20
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start =3D tmp;
--=20
2.43.0

