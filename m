Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FF9CD3427
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 03:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D2710E2DD;
	Fri,  8 May 2026 03:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zlLFpEZg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CC610E2DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 03:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXLwWA0FDsy3MbRLhHhvC9CDZZpKDyQKiGo/r501IAj74pWksv1JNfhfMo3rrSS+v8m5BWs1dDeh6DnXLPuFk5RJpaKSWXlv4ZaSdTponft3pAgWILDXZ2N7/bIZhn8G35mQ426qsr3UES3NvOUxpisNqvmNtoZEiACd+L65GEv6e6D3ZJoLNb4q4SjmTPf/Rx9DTQ/H8bf0CGmw4n2KkAq1o7McaUQAQwPX8f4CYoimSUPn6welG8i9FWqsSyrYCW4xLbJmTiQNTk5TrPVe3TXurTV1lwXBezIyu7kowgW0a3fl/zVZ4GPr6EBF7wfsVbS5XbrEUFIgU5VpYv4rTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBRQ/3lgK7iG9jEP0txGaSmAeVX3+oL7O0t/a99YPgk=;
 b=DVTJ/hur0cGQpLvh8RqvR/U0WXUbPEqqejLRv/tfk7R23OIuMdKXDh+Qx/i7a2ak0zOLv68LAtlqP5IiRRhqduzqTlBTZGe93sLQhvEbLh25Ieo7vA/vjF5o/xFp7urULGHCqm+nhWr5WJunQvKk5yaum8fKtAeCCsYIjX8I/zLU0nT6ZDbeNxMZEss2srAaVxnhJopvvZHjm5Z57wv5yhIyy04xeboWnMfGguTPbjfJXSNNF1GPYo0dJV+Kcj0gyUhnkQmyP+bz7+fzpG8sMc2P6Mme0Tl2C7afpxtnUk9y/G+FdI2hIvvWSyOUmJYdUlRs8tcrObwyUdSp7b0KVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBRQ/3lgK7iG9jEP0txGaSmAeVX3+oL7O0t/a99YPgk=;
 b=zlLFpEZgVM6YT8rTYl1liGKhcnUFUrp0otQR4JDK5aBijKQTQACn4DXcf5H0mL4MOOF73QXdK2DdkPsjNl6r5goZi2PPAuXup4hhmYUoxfe+rQu3IxHRa6ci4QJEwix4a9tO7h3o5rk0r6PoFq8/jyxkKgiW1YDPBS2CqfQrE2c=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 03:06:22 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 03:06:22 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Xie, Chenglei" <Chenglei.Xie@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix OOB risk parsing virt RAS batch trace
 replies on the VF
Thread-Topic: [PATCH] drm/amdgpu: fix OOB risk parsing virt RAS batch trace
 replies on the VF
Thread-Index: AQHc3mA/TIwew2yApUqL1bf7Q2HSk7YDbUlA
Date: Fri, 8 May 2026 03:06:22 +0000
Message-ID: <BN9PR12MB5306BCE04148F44EA9212B34FC3D2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260507202929.110177-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260507202929.110177-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-08T02:47:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|IA1PR12MB8517:EE_
x-ms-office365-filtering-correlation-id: 0f494281-af8f-4a3c-dba2-08deacaec891
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: EglrHT2Ex4E6vFEOzUJdec8dTGgxhCWQZsgtB6T+8om86yB5O+ar9Ovsp9kznQttwmV+VYvxv6PsHF8RZr5H9HF9L8gt8fmVcT8thmRACtJjDK8OMhxEKB0SRNVtjxJsdu5zg+u+C8A4gn0aNEvc1LPacXrcqR5PVBkqBw8VCUbz4wDGMrxTN38NDOxYJnIQY5ht9ilpOzQCy+S79epfq9mezXKlSu5tigCCWYafpbRkcsv3JPTbOuMng/dxlwKtQAcNube6MEskpptdvJw10GW6opR1k06v7Dtet0gy1X9SG5HxyzRO6/iBkx3SUzjt6nLK1rlkdWwbldyowTMgjgtfmD8GNq+x3rpOoBmAaPt0YjI4GGCpEwT+J0Lb0c7wb2yXMAQgjqk6/2nVT7fkKSfxzsHL5kRe2HixZRzi00MYAI7Q7TY2gIzKJjT2guZEbIJXpTd/CD21fg5CFhP22+cksSRe3E/0ByHEV79pjG2uiJgumtO0jJtFnyRGwfN2VG7J6KWJWa8SXjaTG+Jdbj1ZapT/WYn3ynKTwuzcJZc20N9k1ZfqyLxAa1tjSgLU+EQePzcPwYcX9stN0Kd7LYLdDEDHuVoQUCgrq9xLVqueRNw/tYOiY4jj7U4FHMDDmnDAA6PQkSQPEjqtVyj/+9nDbeSBrXRuIvEuSSy+R6tnwR4HHj76/EJxcpH/0bYT8u+ua9G0IFZrpr9dq4gfP1dKwHuzhmBgzXlWpbGcpmRonbeyIEth3wCLqquka+6a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b0XVqoi9mFIPqG8zW2XO34nyK/DsLFLYXxxJUghOg0Yjh+tsnxWVkMdQGNON?=
 =?us-ascii?Q?S4/89QI4djN/04tuYBnJB8Tq3pT6NTOIfI77AQHEYIqWxK4rBMAoDjSQf9Nm?=
 =?us-ascii?Q?tLP0H1i7YPsZQrmGhpAHPAWkwKE6Ur1A2RPC1zXVqtyf5n7h3IRwFn8w5e1h?=
 =?us-ascii?Q?28jrbUJYWrl0BmU7owozNypNLnozIM3hyzoDvYkqHN7ofYyUiwQTM9MN9/Oh?=
 =?us-ascii?Q?LpS4Z58Siq4Qw+V9fv+g/5r5tcfBJIje2TRzrsGz8VyhCziKSQO0j6Hm3/yl?=
 =?us-ascii?Q?PQn9+Mz4muZO8zIHeTz/DktLP7UkrmlywKAWRemc8tImlTIhWQxAF8D6Oies?=
 =?us-ascii?Q?5stja/gOSz/AbMzk+lOPVCrzJv4t2rAyoIE6MmyTVbYbKPMp5fnBJAquqXw0?=
 =?us-ascii?Q?Nd2YnA8+FxehXEl9tasempUTLuhTqlo6iSD1pUqNxOs5JtJj0vzYxkxkz6WL?=
 =?us-ascii?Q?vpy9yqyH2Rg9XGk0MQGQSri9Q/268HE4v6a9IrHq6FWe4t7ZX/8RtaA3nspl?=
 =?us-ascii?Q?VPNjf5EMhhcdr939/KdxNdSsb67iYcWQgc8M5rsx1ljsjK3JZobCcN/QrxRl?=
 =?us-ascii?Q?ynPMKkl44SydjMBcDGwYMeQYBkFEICHxmzM9k2PY+YUikVd5LY9YIWKjblmJ?=
 =?us-ascii?Q?6OSq4G/zzbaHV/ZJiBWGPjoESg8UJW+1TZt2HBMaXoBwgdC+w1e7vO7ZCePV?=
 =?us-ascii?Q?+G6LsVN7m/hjiH4HA9nnEWne3hytuque0tVnSzqTC34AWJL0kRen9MqFs22o?=
 =?us-ascii?Q?axPDIP8vM/JKdc5zE0PKdqDjXfyhmNQU6v+w04VyB+QozIOcD3RoAB+d4UN9?=
 =?us-ascii?Q?5HrEYDdZF6vcbcg5cJ1hp6yqFF/pLQkqFlK/46SY/Lt3Nk04I6Lf/N3AqMlW?=
 =?us-ascii?Q?rEFUX9Q9N/kRLOkWSWCo/NDLlW+fT3OK1fACiuoqBkWnqTj9LnwGmWR4BmRG?=
 =?us-ascii?Q?/b5yLneaCudGOYHRmmne8lhPRHWNOtHTbrmMKGOujJRLJQRbatyJ0jFtC/RO?=
 =?us-ascii?Q?6pY+mwpq/YxjkKxTDC1UlUq0HEB+ZbXF6JmJqT/LU+ME3kI/oslhEkbPQ0o9?=
 =?us-ascii?Q?nRrCcJbUciOutpmR+YyXuLNXsr3Mj3ueipYLM/ccYYLiWwpUceBSVASnWGIY?=
 =?us-ascii?Q?3Ch3QkmUQxF8z2rMK6xT5fMAnYEtOyaqtysdAqQJVhHcd4Vo+9u+Hh5IJdse?=
 =?us-ascii?Q?+AnBUijAJyfG8CGtdPkcf0ddLZd/1U6NpxmM6j+GczZeJMAoRiIryj1wNxe5?=
 =?us-ascii?Q?1Vntp+MRBs6dxVmcdUBLYoRyJlRUxuZ3qTxdJl54pTQSFXXby38mQObvftI3?=
 =?us-ascii?Q?bm3mG6Ub2TOD2qG4zBVErbXXs6DKISePOUF3BsVa9YtMwflyPDsFUTky8WO2?=
 =?us-ascii?Q?5crLwY/lR71jrixWn9VgABKXO8ZtGDsgAkLixclyYcWKs7YKhtJ/08pq+zpD?=
 =?us-ascii?Q?X74LmJL/z0Fd0pPu8qbXQvH8Al86f9tADSWGqOlaylJ7iQRiR4UBuu8Ma0TZ?=
 =?us-ascii?Q?MzCFNFDyAo51Lb8LzAwUbEKHy79kbApBWqVPGROoQMUpk5+my6w+Qweklxzt?=
 =?us-ascii?Q?vod0azRtmLN/VxrWD9AJ2r08JXADj1uRF7xYhfYTRIUy9Z6CPNkQ1jDdKt3x?=
 =?us-ascii?Q?1c2uNKJBNMF73OHK9Ttrba48ZGtVOZYXPxHFf+wu+yJzJMVK9bI6nLLakHb0?=
 =?us-ascii?Q?ifDzdZaTTtAWDd0dwBa66oB95nK32nFnH0RfOnRRVswSdZfH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f494281-af8f-4a3c-dba2-08deacaec891
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:06:22.2137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhIUBRdHAPOJwnpd9NOlLCaFbZCZeeD5eCt+DPsc/F12NRb9FNm76FhPH7Mdi5Qk1whswJEJvtfC6smCbiYIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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

AMD General

Best Regards,
Thomas
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chenglei=
 Xie
Sent: Friday, May 8, 2026 4:29 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: fix OOB risk parsing virt RAS batch trace repl=
ies on the VF

The VF copied ras_cmd_batch_trace_record_rsp from shared memory without ful=
ly constraining real_batch_num, the cache window, or per-batch offset/trace=
_num. A hostile or corrupted buffer could make batch_id - start_batch_id in=
dex past batchs[], make start_batch_id + real_batch_num wrap in uint64_t an=
d confuse the refetch logic, or make
offset+trace_num walk past records[].

Validate the response like the PF path. single helper for the cache window =
using subtraction and a real_batch_num cap, bounds on trace_num and offset+=
trace_num, re-check after the RPC, and memset the cache when invalid. Retur=
n -EIO for bad layout and -ENODATA for a batch_id slot mismatch.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I6455e9f14914d1b07945b7a57fcb3695435ded64
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef391..fcb421d39f87d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -192,6 +192,16 @@ static int amdgpu_virt_ras_get_cper_snapshot(struct ra=
s_core_context *ras_core,
        return RAS_CMD__SUCCESS;
 }

+/* rsp contents are copied from shared memory; validate before
+indexing. */ static bool amdgpu_virt_ras_batch_trace_rsp_covers(struct ras=
_cmd_batch_trace_record_rsp *rsp,
+                                      uint64_t batch_id)
+{
+       return rsp->real_batch_num &&
+              rsp->real_batch_num <=3D RAS_CMD_MAX_BATCH_NUM &&
+              batch_id >=3D rsp->start_batch_id &&
+              (batch_id - rsp->start_batch_id) < rsp->real_batch_num; }
+

[Thomas]  This function is checking whether the batch_id has already been c=
ached, suggest renaming it to amdgpu_virt_ras_check_batch_cached.

 static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_=
core, uint64_t batch_id,
                        struct ras_log_info **trace_arr, uint32_t arr_num,
                        struct ras_cmd_batch_trace_record_rsp *rsp_cache) @=
@ -204,27 +214,37 @@ static int amdgpu_virt_ras_get_batch_records(struct ra=
s_core_context *ras_core,
        struct batch_ras_trace_info *batch;
        int ret =3D 0;
        uint32_t i;
+       uint32_t idx;

-       if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
-               (batch_id >=3D  (rsp->start_batch_id + rsp->real_batch_num)=
)) {
-
+       if (!amdgpu_virt_ras_batch_trace_rsp_covers(rsp, batch_id)) {
                memset(rsp, 0, sizeof(*rsp));
                ret =3D amdgpu_virt_ras_send_remote_cmd(ras_core, RAS_CMD__=
GET_BATCH_TRACE_RECORD,
                        &req, sizeof(req), rsp, sizeof(*rsp));
                if (ret)
                        return -EPIPE;
+
+               if (!amdgpu_virt_ras_batch_trace_rsp_covers(rsp, batch_id))=
 {
+                       memset(rsp, 0, sizeof(*rsp));
+                       return -EIO;
+               }
        }

-       batch =3D &rsp->batchs[batch_id - rsp->start_batch_id];
-       if (batch_id !=3D batch->batch_id)
+       idx =3D (uint32_t)(batch_id - rsp->start_batch_id);
+       batch =3D &rsp->batchs[idx];
+       if (batch_id !=3D batch->batch_id) {
+               memset(rsp, 0, sizeof(*rsp));
                return -ENODATA;
+       }

-       for (i =3D 0; i < batch->trace_num; i++) {
-               if (i >=3D arr_num)
-                       break;
-               trace_arr[i] =3D &rsp->records[batch->offset + i];
+       if (batch->trace_num > MAX_RECORD_PER_BATCH ||
+           (uint32_t)batch->offset + batch->trace_num > RAS_CMD_MAX_TRACE_=
NUM) {
+               memset(rsp, 0, sizeof(*rsp));
+               return -EIO;
        }

[Thomas] The batch data validation here could be consolidated with the earl=
ier "if (batch_id !=3D batch->batch_id)" check above, to keep the batch-rel=
ated checks together and improve readability.

+       for (i =3D 0; i < batch->trace_num && i < arr_num; i++)
+               trace_arr[i] =3D &rsp->records[batch->offset + i];
+
        return i;
 }

--
2.34.1

