Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39748CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 07:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53DB10E199;
	Tue, 12 May 2026 07:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h5+i97/1";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35EB710E210
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 07:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lU8NOb/a9bC/buNNTP6RwSQ3KiNblQVelu/dvU4q6w4XlDVRQAivahP4G9zuliiRnrlsPVqkb1dNcfAgngDEEk1boO8WZPHQqQsQIU38LL8rCiUkxALlkT/0rkskuHXGx24ntvMZIzbRvtfpjznrCdmriVChWOiMSbFL5OqAc9QERK73gQIvWTRv/T/8xE8FmcPiINKlsY6H5jpB3TBsTQRqxD4JnGeAe5NsHJNr0ZMJcyPRjv4A0LPINvjSN1AKm3XHo3/8/m6Oc4sJmmbBxwSVEcQvmEx1Yj6aMQd0ytispURQqtyz7N5W7iYNjbZh6Ro4qKWbu8262x0lcq89oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ3hUJGrHZ4PjtA6Z2WU9gsd/dZvCl92Y/osDWlYbmo=;
 b=HDQvvFyjOSGjHJhNBIY/At3nAaEXIh2BsTa04c1jHYxiLvzdcS6Z39esTl+lngsdN10EXaPBEl6CFU8VuAN30JqOjrCKYPwLsZ0D8pcD2uNbG9EmPzQIBz2+lf1hOePpbFHMyisWGGQDmi50J8A3Bwrmrc5XRspJVszomPbMgZGrrbt0Fe3mjxRHA8/zcxlk5SEiZShwIHSljHSWKYsiOH9Q7r7W+CEU+XB6oonGm+KxrjSTw+OtZN3lY12tgK1Yc4WaVE8aYmlWGuTSL4IVWxywrp5lSDVXJ0Sfz9K9FiGA9pCYWqHkgwoff4AF8IQH6yLgY/fntLLcrsEjU8l/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ3hUJGrHZ4PjtA6Z2WU9gsd/dZvCl92Y/osDWlYbmo=;
 b=h5+i97/1eYkO4zQGTd04tTCYurUYew4TYJuEWh1GHmAUliOJoaL08htp0F9D47ZwPQR4jAxjpn+PrJl3cOJ7MOk5/RASsFrSWfDKsGGYfMpQRMo5OTOmGKqEKvcyggtUUrPq1eWW2Vdj3/msfuX04lIsswfJiscgeZ4rxZ6J8BE=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 07:23:17 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 07:23:17 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix OOB risk parsing virt RAS batch trace
 replies on the VF
Thread-Topic: [PATCH v2] drm/amdgpu: fix OOB risk parsing virt RAS batch trace
 replies on the VF
Thread-Index: AQHc3vnCNAM05yQHlk6ISrHKOKWPULYKAi+Q
Date: Tue, 12 May 2026 07:23:16 +0000
Message-ID: <BN9PR12MB530626DE2E6EA73359AFD748FC392@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <BN9PR12MB5306BCE04148F44EA9212B34FC3D2@BN9PR12MB5306.namprd12.prod.outlook.com>
 <20260508144830.215417-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260508144830.215417-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-12T07:22:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|SJ2PR12MB8033:EE_
x-ms-office365-filtering-correlation-id: edbbb4dd-6d43-432e-43c3-08deaff75623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|38070700021|56012099003|11063799003;
x-microsoft-antispam-message-info: hprhgIHXfe3OG/TNZI8edZ0pB9H8NVzVoUcHyqmnbmch/uRBm7DdZbmB1SwjWCFe6TLceK5EJb91J2SWiuuy6JLcZ2o2EUcJ+xP5JoREBs3vBR+SyKwRe29NRlQIdsSirNIWOcptnT8OOUA6OmT4ziG3E2LuyA6sbv7ptfgaj2/+F0sFSrcx0t6xqNeEgAPciAlDROoWG0DJUvFsWt4RgPd/OU4AAwz0tucasww4DT2haXFxIyjnr0sgvXjRNqbX85kvAY9eZTEk5dyBgWLvuGVMcVz0HH12uKJTt3XSG0jnK/gJARvIhiwqBL42SK/WiDYJCdYlXwgyWjbeLnZUwVoovDf7HA515OD6WuJVkKodKy8XuN8iQTkPujvgybMIJHMC5EijNG6rmdHaoufKnn845OG2sqp+6vgfaqzb0C7hppKEEK+KCwmbviEzm1Q1DEGobgaj3yYe3PRvP7zihJFynPbRzE0G35a88VdY8VBCg7qvD5WW+N5Qme/TfiUn9I7vrFg+MPyuIf8Yob021ooiFrbY/l1uemgzi2Em7zjL1MBsb3tLIYtpmxBSJ4iptubwjxDenzg0p7SHdH8OhXh3Ps6C4m8EKY2LsmNe1tjNAcrmjrKKPMK56hYhq5YO+1b/GQmS9HPO1KPj0u/TFZypRCnNU5SGrtKrs+WAAbA9NOCt56foDkK/uO8OPl0O3cz+XTj9fRzW7QW0jJv0ryOxZbAy6S0qrq9A+tKIQ9qM1s+hCB35/qPHcLZx5C9A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IzXO1a2Qih+2rozmezyBR7jDRZ63tr4oLO2qrKC8leizED1FCMkM/rZA6pWQ?=
 =?us-ascii?Q?lwCMocVpwX/bM/nZpACbmFXH+FOyb42emJKCJ4CCrCTDHQkqGwR1TLldFzyw?=
 =?us-ascii?Q?mCn9X6pYNzvdjoa7Z/5RS6pV0gGJKHKqeSwZXU1efMgHw8ioy8iXS6l2CcYz?=
 =?us-ascii?Q?0X8/kIRhI9tDTy1/DKEUQ1ZRApRIypT3QVvFvfGMBY/p8xkyu70ZLp08ELP6?=
 =?us-ascii?Q?yriIsPk6dTC70gLLKRRdnrm48vlbEe1244nDx/ZzW/uUXxygRn1RXc5YrS+w?=
 =?us-ascii?Q?voa/JTxzxdr5G5nDgvGOMoSavMqwtVqpBeOFJg4N1TmMUmuTRv9lWijduW7i?=
 =?us-ascii?Q?PztwDW0vsZeOK+nyh8rxBwwFP2nWPSRWsojieDiKsUZ0A29s5qt14FOdpNML?=
 =?us-ascii?Q?6Kg+W2+RyPppJxPpezo+Aqp+VE5M87FPSJdTqrbdwMbciyzFowKXFI5xYCHy?=
 =?us-ascii?Q?/kZHdOBji92EVYyXZLRLClIf1NdQ+/XPV8eZBl/XIzZGShKXJdOBSHWB+5rC?=
 =?us-ascii?Q?br1Fkm3Ce5iYzalzKWL90gKibgb723YVaelcmLgnyjLqf0csNpTgggnGaj19?=
 =?us-ascii?Q?XdmEagD259lSgRqtlzwXs+JIjwZWiTGHohqXOBJy69yxwOGrBkFT0cIOU0Wo?=
 =?us-ascii?Q?n/txo6HzixAGvnsiYfkOehw9Ckr5tVU7Z267YTmjCh2VuQhUue5W6GbFDrW7?=
 =?us-ascii?Q?2yGg7uFCeLyomB4pBnqK/ZW9iFvNFB/6vFFDJ0RIekYBBY9Tnu8FYXo+UPqJ?=
 =?us-ascii?Q?G3I0RJSvzxbJUIETaQVC5GS6U3yDNLgrPC5go0m526yvNG0T9al26tKIX4Sa?=
 =?us-ascii?Q?qLjaBluSKEFkgh1/kSOowyn7xxo7f5jmhj5wDRp9D4B726O9ExnI0xfyh0OZ?=
 =?us-ascii?Q?5mmM4cRsgeJpFyiJiPkdPJNxe7zz0lWTxUpMgYB18s7Kqzy65s+A2Cc/FxC7?=
 =?us-ascii?Q?DPrb6qaOImzcQjbCr/MqwD5NRPB07qooUI9SHz+4QWTqtyVFYUyBrH5s50g2?=
 =?us-ascii?Q?A+ty0cOCeuHT9ZCgqU4QdpQj/STmjxtDQ5HfwyBmM50EfWXjGbrJ5HLh1x24?=
 =?us-ascii?Q?eQ3ola3XL6A6j17GPL4mlQH3PVERtwD4E3fiIU3sDStXiMjDfO9yf9/zp72W?=
 =?us-ascii?Q?BF82xxsTcCTag/ZYOtmFVTynwcskNwP1Gp5XgoqW8be4hXzP+nqTm9JEWISY?=
 =?us-ascii?Q?QLmDZaniCo9jrCyWjh9XNmnBdjddRIBhEgWWeVxLA581STUDq/1YxVIYT5w0?=
 =?us-ascii?Q?n4e0BNrKm8f4zc+vT9ESBDjZu+eHE427Ox7/gZuvUilMInmuDNnWZ413ioZX?=
 =?us-ascii?Q?hi+2QmONTdbCbmEUNSxmSU7wo4nZE+bR7+b6VJ2IVUCpr6kL4IOaG7bDs1E/?=
 =?us-ascii?Q?Z6YbUOLr0nEXUDaCiqsiZD5bpZVfixv5w6rcGhYMc4X8QhkM/OSY0ERp4gO+?=
 =?us-ascii?Q?nWV6zT7H4BcCntWsNf+FbJlI2Js6PX0hFyC+l2ZOuc694Dm5wmLNWcwAacKV?=
 =?us-ascii?Q?XtY0uV1clgxMg/7ZldvhseMJvQJFvnIRYA+L8KsEkab/C2Sg5NOeZEynbubq?=
 =?us-ascii?Q?+MgHctMBjgYdkdRvgYfXAVXWvXlLKrRfxs1i3aHD7UsdOfhBnXenFDFD8g+l?=
 =?us-ascii?Q?NiLuQLdGwMVmkWbxLx8nP0YioV/Uj22q4NBprimM0+rX9pvb6lVimIcoqp2k?=
 =?us-ascii?Q?Q9Tozo1VI7X2ykg2kvp1M/2bu+0OVBjWYCvklo4lyinZ6XUq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbbb4dd-6d43-432e-43c3-08deaff75623
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 07:23:16.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfFVnCYhht3yK0hJyaX3Sxr3T/sRRzbXruOPwbG+dnaav/vytCcloG8v5YMIxpiB5W7d9qRZ3m7Zbh0EGK2CPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

Best Regards,
Thomas
-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Friday, May 8, 2026 10:49 PM
To: amd-gfx@lists.freedesktop.org; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix OOB risk parsing virt RAS batch trace r=
eplies on the VF

amdgpu_virt_ras_get_batch_records() indexed batchs[] and records[] from ras=
_cmd_batch_trace_record_rsp copied out of shared memory without fully bound=
ing the cache window or per-batch offset/trace_num. A tampered or corrupted=
 buffer could set real_batch_num past the array, make a naive start_batch_i=
d + real_batch_num comparison wrap in uint64_t, or point offset+trace_num p=
ast records[].

Add amdgpu_virt_ras_check_batch_cached() for a subtraction-based window wit=
h a real_batch_num cap, re-run it after GET_BATCH_TRACE_RECORD, and use an =
explicit batch index into batchs[]. Consolidate batch_id, trace_num, and of=
fset+trace_num checks; on any failure memset the cache and return -EIO so t=
he next call refetches.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I6455e9f14914d1b07945b7a57fcb3695435ded64
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef391..7ec5287daf7f1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -192,6 +192,15 @@ static int amdgpu_virt_ras_get_cper_snapshot(struct ra=
s_core_context *ras_core,
        return RAS_CMD__SUCCESS;
 }

+static bool amdgpu_virt_ras_check_batch_cached(struct ras_cmd_batch_trace_=
record_rsp *rsp,
+                                      uint64_t batch_id)
+{
+       return rsp->real_batch_num &&
+              rsp->real_batch_num <=3D RAS_CMD_MAX_BATCH_NUM &&
+              batch_id >=3D rsp->start_batch_id &&
+              (batch_id - rsp->start_batch_id) < rsp->real_batch_num; }
+
 static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_=
core, uint64_t batch_id,
                        struct ras_log_info **trace_arr, uint32_t arr_num,
                        struct ras_cmd_batch_trace_record_rsp *rsp_cache) @=
@ -204,26 +213,32 @@ static int amdgpu_virt_ras_get_batch_records(struct ra=
s_core_context *ras_core,
        struct batch_ras_trace_info *batch;
        int ret =3D 0;
        uint32_t i;
+       uint32_t idx;

-       if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
-               (batch_id >=3D  (rsp->start_batch_id + rsp->real_batch_num)=
)) {
-
+       if (!amdgpu_virt_ras_check_batch_cached(rsp, batch_id)) {
                memset(rsp, 0, sizeof(*rsp));
                ret =3D amdgpu_virt_ras_send_remote_cmd(ras_core, RAS_CMD__=
GET_BATCH_TRACE_RECORD,
                        &req, sizeof(req), rsp, sizeof(*rsp));
                if (ret)
                        return -EPIPE;
+
+               if (!amdgpu_virt_ras_check_batch_cached(rsp, batch_id)) {
+                       memset(rsp, 0, sizeof(*rsp));
+                       return -EIO;
+               }
        }

-       batch =3D &rsp->batchs[batch_id - rsp->start_batch_id];
-       if (batch_id !=3D batch->batch_id)
-               return -ENODATA;
+       idx =3D (uint32_t)(batch_id - rsp->start_batch_id);
+       batch =3D &rsp->batchs[idx];
+       if (batch_id !=3D batch->batch_id ||
+           batch->trace_num > MAX_RECORD_PER_BATCH ||
+           (uint32_t)batch->offset + batch->trace_num > RAS_CMD_MAX_TRACE_=
NUM) {
+               memset(rsp, 0, sizeof(*rsp));
+               return -EIO;
+       }

-       for (i =3D 0; i < batch->trace_num; i++) {
-               if (i >=3D arr_num)
-                       break;
+       for (i =3D 0; i < batch->trace_num && i < arr_num; i++)
                trace_arr[i] =3D &rsp->records[batch->offset + i];
-       }

        return i;
 }
--
2.34.1

