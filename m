Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7141CD6E50
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 15:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA44112105;
	Fri, 29 May 2026 15:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdniYc9D";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467AF112102
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVA2EPOY1NXen/SOk6ZIYYoXZVsmSP52Hr+cNDd+WNQTaeCuxZJa7GDKVzCFxXW/XYSb/4RjwpT/PHuHdmqdPNKcQqxYFPtfV6JB/5u5/LYWAPAF7crAOBFjLT+PJJpX3VJyEZ0wAjhwZ7mZjeE73SnV+pa71lVy+MmtKOggfVXCxMETrFAr6+RdTXYoLlOXgEBIf1E1LZ6a4QFsbasBbEQOx83jTUs82DP+ydZwI6Y7EZHF704uU5hUp9g9K7vIGg6NW8xhTkv4ec2+1z3P8ILqOv4lhRiXk8uojLcmwzBXT2TbQRx7XmBMM0N3nAuBF1R3ClcvjIkBZvBJcDnEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta/S1DJu3OpCDjkJbJONioRkiNtOP2NGcYhyPaXAZCY=;
 b=TrF6E0E75U4l8gF2uV7cnwHYQHYW4e1i5BOaQ4Fiw8LP5A1AqKRVkYieuXIcEkXAzFgzBP1JTD2VLVafsv2UokQU8pf744Wum4ZU+7EtnLRMDKjR+yKNRWTAR+tmjjO7Qq6J7pVK7uDl2oESJas4hlfLmrH4QOBIa546iVKMYOlHLXjhCiaocNyTxNDL8E++4Yuef8Sn7DgxfBehHgGWQFYag5lQEst4AI6ey5ZycnFbdZveXBKHFproVtOIq3hKWCyV1DKniujFgph+Gy6TS3piPny7dLjGl5dFJKU29YiR/Hu6iJtuzrCDnR+exG5MZGx265kZGNc1DmtGpzQx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta/S1DJu3OpCDjkJbJONioRkiNtOP2NGcYhyPaXAZCY=;
 b=pdniYc9DwQejhJqHEZq3p1OCRqf9fwYvy8f23fFNnJfREg+09aavdOGz1qSnzQ53OkmDHX+mP7tq//bgPByw70GOA8WrR1P0XNdAfDKc9bV5/rRGkX4pC9M9GiHDdmuayIRkt3nRBqT2u6SHhgJhMqMl03AEo6QamwVmMT69zHs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 15:29:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 15:29:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: chunk UNIRAS CPER debugfs reads
Thread-Topic: [PATCH 2/2] drm/amd/ras: chunk UNIRAS CPER debugfs reads
Thread-Index: AQHc7341KHQO6m5iOEyGkb9uO92Bk7YlIOJg
Date: Fri, 29 May 2026 15:29:50 +0000
Message-ID: <BN9PR12MB5257D628508CB277BF2C6A9CFC162@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260529151624.1144318-1-xiang.liu@amd.com>
 <20260529151624.1144318-2-xiang.liu@amd.com>
In-Reply-To: <20260529151624.1144318-2-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T15:29:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYXPR12MB9280:EE_
x-ms-office365-filtering-correlation-id: c74514d3-890d-4ab5-36bc-08debd972005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: QbHfvQUMXd97yCY/XxI+xEvJVyNDzN7gx55+VbM+nSmiNWg9PriAhdPTBCYYmsul7138Fx2UOvGjzmZG64/dgjkZ3yraybcjxZqaGm5lJdc/EcnxwHhLsPqmQaNdVtZkwgejehVs7PCdyXqnSOQ2L3tnooBI4PeVHqUl2EgWhiso5YdaKvl54IbPo0q0OkMUB/3mWUtoq5LL1SQoJxj8hRATd9SVh+C2aOmk8cNQpWJHQ2v7E5SVDGMmMPN3yNMxN1FU718816JBFyDywqPfa1mus71bCoPZsvTqAUwh3PzRctAt9cwuwtL0zUqMNtK6YkDPPesy4GCI3LGBqpiv59Aj9nrtldQn3KqdgHLIpoTuLlfJ3COWFa+z8wdFhHeF+WULpfxYfZ7INlJFVRRb8HJpdT6aEz0LX1OoSc78v0pQvWDn3z1XzBLq/R41t4L9k1uwJ4StiJMrt/jbcR/NNKiKvUbV8GiWJWjIRhhbDa1tzd4IA7Op2ltmeehRCkhb031XssmeUyMEyRmntE0GmD3oQT+Ns/t6Tbq1SO4hUiU1pj3v+EK+Y2RuakpVTnnzLVUfeLGPWGb4Ruaud8eREvUTinx6iyHlhj2GIKknSrMvlOexWtHhldKyYVrfwsCCLiUwpIQx64vWEc9bocVrJze2IWO8aSzlyCkNHirqhnJMZoz3EIqQ6ED1Bq1wkrN7ZNI9j6LOEQU8Kc59e60QG39ttYguS2HNEyoaLxjKNJZM/ToRnz4GP/utVpCUw2wl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bcbykn9zEEh6wSbeRbC/MKsZ7GIE8jPh/BmVxaVAO/yMzxq6Bx2XGCWGfglS?=
 =?us-ascii?Q?W+VNgCcfJLwCvHaDVb3H6gbQK83ILuj3uLqJAtVM4dIf8KVG24GAEAtR3mgj?=
 =?us-ascii?Q?8qufJmIlvQWJ42ize5P7XHY6fu7rZqjTyfVvsRZkTN3c0GIAMpop7PU1picj?=
 =?us-ascii?Q?KsuZtm9PA7rjXQF8mqja3x0S0rL3FG5n+Ztnj+Huy91pmtgNAMljdBXtoL/i?=
 =?us-ascii?Q?YdhCrAGrsUeAwi/g//dsz60hKixlQhiMPxeqMwRl1juiE8ml9zbzIRnPnrx3?=
 =?us-ascii?Q?0C7ignXcJsLvAV9O358K5J5sEn8YQWwtEKBo7rsFWdDSwXumKH3OKlJQGfTv?=
 =?us-ascii?Q?LMUVcR4hqTj+zlwGOGFSLo5l7TPaVS3vpwQAAPR3aXtqpWG3V8I5KoWEKpDK?=
 =?us-ascii?Q?NrY2E/ndlVbfdAA/8XKks3u6BObaeFF54u8369lUJoTiTYxQPyNlYUQyqj80?=
 =?us-ascii?Q?fjhIr4UhqkrDpBXa2es9N+XNpQlyarWMz+mNAJgOBHUZ/9na5IrDWzc2uCVx?=
 =?us-ascii?Q?eThvPZWUA9Ebl1eHzG3CNh9V1p9pZGWL55v5S/v9e5wGnvSWC8AByu2w4RCC?=
 =?us-ascii?Q?aqF63oB89vKPFMjBqxOvh1xZtoIfojCsu34LO5rXg+qNyqy/Qy7Vxmp/7Y9/?=
 =?us-ascii?Q?LkfR/ldx9PeIrgimYfhvDK6SUH42bf5fT4KoQemUkGf/7ANqzV7PRJ+qv6z0?=
 =?us-ascii?Q?OCwKzDtvK1psZdxnAExVpMZFzGAKx3eDaWnEB+bl5RBMDBZuvvulgXArl8Vs?=
 =?us-ascii?Q?NRINLFbFTTJpxj2geyl/a+YzrC+9yRJlodSBj0kvxrEJT06WbIp+RHT9jq9J?=
 =?us-ascii?Q?ved7+akXHxDuguus+dYC5dVn7DQERpZHm+vZK0gFRA7ei4EBeTHJTj+TK8Go?=
 =?us-ascii?Q?3sN3PxZQsqQMS3Pv0dFzGrwiNlgu4THg1DE9hEBFUhv9j3gCZ8v+U1kW+Uxy?=
 =?us-ascii?Q?8/NSDc8HQpw+M6mEKdzYWAJIZIMrXosNA1bhTb+UJflY3sh2pZ+PqwXI/E0G?=
 =?us-ascii?Q?MxXdTJ0OPlll1FAqVfCOe7R+/CiMGKYM3ciemIFfZhikHxE/whSHXkOrBiMo?=
 =?us-ascii?Q?j6tQpSCIoQ9WQqs3SIuB6glWwzQkQTuuwTlnGK4T05SraeCQEjuBuHS8l5oR?=
 =?us-ascii?Q?wgL4wb0qBGOYF21eb6wjkt51zAszR85yYBKn6TlzJ8WbYtCMKusN99qyGT16?=
 =?us-ascii?Q?rI6GP+XysYNJcrBZJBsIv4DflTl8gvCm0Tvi0yxqX4JNHfHVUrEbUUQwEhau?=
 =?us-ascii?Q?/dLir2XQw7BtF33OyKagclWNd0GYkRy4m5Ws54E7gKW51yQmlQ8nfWwrxjwS?=
 =?us-ascii?Q?vbQfFT4U9OxU2/iCo15sFCPHqCXkiqkfaQqGZvIPi6KSbKIGtbpCIiOaOhbu?=
 =?us-ascii?Q?cw5XuE7VUMviXqW4PDLh9lZDTftL+a4rbeYzCC01v7pxCxzAhNcRaDDxgpin?=
 =?us-ascii?Q?JwlYPzD+pdp5BSgrFMgRMPdjEwRuglgMc6oQ3PIVrt9CxVnRlguYlv0TD8D0?=
 =?us-ascii?Q?ag4ybeo35K7p89MSAduaiyOefllYcGdv2O//luJuwaFUGEELCbFapLWjsJEO?=
 =?us-ascii?Q?RoITq48ChZ/LThUGdLh+vcZwu1eIloIZzozTeLqMcE7IH859bKZr2cWSjB38?=
 =?us-ascii?Q?S1eZe1RYdPVlfrJtwns8LYfEodHj+q3leH5E3X14RUW5r735EloKCmYNJprv?=
 =?us-ascii?Q?SLcjEiIq15CgNdWTwjEMA7GS775JiXda/smTCcqEt5N4gZfK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74514d3-890d-4ab5-36bc-08debd972005
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 15:29:50.7791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jf3P43p5KA/YOEa/2lkvxlSJGPJ8eAmdVaiW3FCShrNcpS9DIz+9BRQ3NjhQyGW6sCGxXaEn/jnBenJ0gIasw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, May 29, 2026 11:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: chunk UNIRAS CPER debugfs reads

Legacy CPER ring readers can issue one debugfs read with a buffer larger th=
an the UNIRAS RAS command payload limit. Passing that full size to GET_CPER=
_RECORD makes the command reject the request, so userspace may only see the=
 ring prefix and treat the CPER stream as empty.

Commit 07d0ee31a5d6 ("drm/amd/ras: bound CPER record fetch buffer
size") intentionally bounds CPER record fetch allocation by the command buf=
fer size. Keep the debugfs ABI as a single contiguous ring read by splittin=
g the internal GET_CPER_RECORD requests into RAS_CMD_MAX_CPER_BUF_SZ chunks=
.

Accumulate the copied payload and update the legacy header write pointers f=
rom the total bytes returned to userspace.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 49 ++++++++++++++++--------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index e8cee3728ade..5dc00db14a32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -501,6 +501,8 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file=
 *f, char __user *buf,
        u32 total_cper_num;
        u64 start_cper_id;
        u64 cper_offset;
+       size_t chunk_size;
+       size_t total_data_size =3D 0;
        bool read_header;
        int r;

@@ -550,30 +552,45 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct fi=
le *f, char __user *buf,
        if (!data_size)
                return 0;

-       record_req->buf_ptr =3D (u64)(uintptr_t)data_buf;
-       record_req->buf_size =3D data_size;
-       record_req->cper_start_id =3D start_cper_id + cper_offset;
-       record_req->cper_num =3D total_cper_num - cper_offset;
-       r =3D amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
-                                         RAS_CMD__GET_CPER_RECORD,
-                                         record_req, sizeof(struct ras_cmd=
_cper_record_req),
-                                         record_rsp, sizeof(struct ras_cmd=
_cper_record_rsp));
-       if (r)
-               return r;
-       if (record_rsp->real_data_size > data_size)
-               return -EIO;
+       while (data_size && cper_offset < total_cper_num) {
+               memset(record_req, 0, sizeof(*record_req));
+               memset(record_rsp, 0, sizeof(*record_rsp));
+               chunk_size =3D min_t(size_t, data_size, RAS_CMD_MAX_CPER_BU=
F_SZ);
+
+               record_req->buf_ptr =3D (u64)(uintptr_t)data_buf;
+               record_req->buf_size =3D chunk_size;
+               record_req->cper_start_id =3D start_cper_id + cper_offset;
+               record_req->cper_num =3D total_cper_num - cper_offset;
+               r =3D amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
+                                                 RAS_CMD__GET_CPER_RECORD,
+                                                 record_req,
+                                                 sizeof(struct ras_cmd_cpe=
r_record_req),
+                                                 record_rsp,
+                                                 sizeof(struct ras_cmd_cpe=
r_record_rsp));
+               if (r)
+                       return r;
+
+               if (!record_rsp->real_data_size || !record_rsp->real_cper_n=
um)
+                       break;
+               if (record_rsp->real_data_size > data_size)
+                       return -EIO;
+
+               data_buf +=3D record_rsp->real_data_size;
+               data_size -=3D record_rsp->real_data_size;
+               total_data_size +=3D record_rsp->real_data_size;
+               cper_offset +=3D record_rsp->real_cper_num;
+       }

        if (read_header) {
-               ring_header[1] =3D record_rsp->real_data_size >> 2;
+               ring_header[1] =3D total_data_size >> 2;
                ring_header[2] =3D ring_header[1];

                if (copy_to_user(buf, ring_header, ring_header_size))
                        return -EFAULT;
        }

-       r =3D read_header ? record_rsp->real_data_size + ring_header_size :
-                               record_rsp->real_data_size;
-       *offset =3D cper_offset + record_rsp->real_cper_num + 1;
+       r =3D read_header ? total_data_size + ring_header_size : total_data=
_size;
+       *offset =3D cper_offset + 1;

        return r;
 }
--
2.34.1

