Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0EFD73E86
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 03:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A2E10E246;
	Fri, 30 Jan 2026 03:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0N9Ulk1f";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A87110E246
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 03:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIUb2W9Myr1D5F4MZlyOB+/ivPInQew77eLyIpB7SeXSinJ8V0wQryOvxKmbFGxGzd0ofTylWpicN4s9YG5nLXI7Sn25v3uM58gKnNDAp4KiLJv9JCPedx1k3ZekX/iThwLmB0iA5mPQ3Jxy77HeOBWpFI1IP3nQCGKco0iorRPEppXyKexWh8OSr7UOLWbmpzcZrW7dRMfhr2HwU80FbFCFzEKpMDhLVXASjlzj1Bp482U/21/wIKsPej7hHQCeWLs7qdK8U2POFix0pWZjJCuUpicgdoykpQlGt1qAF83VtCMawWI45x6gEhjT5B+9W5eGK188auxvzwZAnx4LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv7aebIFJCa/HKpXsxPUbILZX0mho67id3abhlUruZE=;
 b=Uxr+Er1Y+n1ISu3QsouKOyLBRZYMCr86r/1Fh7FIAdcu8KXcukgbJC9xQnnca0jCYFydqilho0MDNKOIlVFmp8dTXk8WUaARg01Ffza8IYv1SYZdkOkWjg04R65hSkoYNOSk1D/pemNB3FaDB3SyPZn5G4E0FXFASMQBEzBqLwhWZlDwvAuckJEQDcbTV3cbuNE/Ck3WUmyAhlTqnxB6p+3QY4Pqz4Keho1PD+gV7G9evLSHmHt8YXUpCiXP9q8TnvKz/RsVSHKyXcVeExoTBus1dgRtSnS+q6+HAUjoP3AbYcFgCqS1Zfl6+a0OzAi/4+Ztjr1r+HKSaLEl+9ll3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv7aebIFJCa/HKpXsxPUbILZX0mho67id3abhlUruZE=;
 b=0N9Ulk1fo92cVTPq540J7JqBp2E82dsz4LC+u0G79g/Zoy7LuTPmzd3aob5V39IciSb+iY+iv7AqeqwsUCcO653B1ky5mdsw9EdVMLJ7v3HnIbIVqzRrt0gaLQHwo89ITCtlgJu9THSH73gBxul+NJ5n1kh5NDtVdfc9JcC5Ces=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 03:02:15 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 03:02:15 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Topic: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Index: AQHckZBqPUe/AdksX0+5OwlvV9KMPLVqBkcQ
Date: Fri, 30 Jan 2026 03:02:15 +0000
Message-ID: <PH7PR12MB5997FA8D1435A8C68E584B13829FA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-3-ganglxie@amd.com>
In-Reply-To: <20260130022950.1160058-3-ganglxie@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-30T03:01:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB6789:EE_
x-ms-office365-filtering-correlation-id: 241a35ad-c540-49d0-dd60-08de5fabf925
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0YRwlhkL3SLHXCm+NmrSWlerim7GejOlS1pBfvwqozF1UHjX6Eni9ta24Jk0?=
 =?us-ascii?Q?CftgVbXSuGaA2IXZMIH/YsBC32DKNQE/2IxeqNv2nGd1dCFTka3VEpf29XZq?=
 =?us-ascii?Q?We/Dj0qrIKVmA6OtcCWID0Gu9a/uUwyxnHfI5MGozZmRWCH1UfVE1rcmobk9?=
 =?us-ascii?Q?cPE6ET2knf2PS7r2aX3YmnOGwI0yCqWt1XcLgv2LT+kLD2xS8pSL5GqlghFu?=
 =?us-ascii?Q?F6GcBm6Dm3lIpawsM4/4lg92X6BRV0ZwFb3BpvlzXuMNZtsAxlubBr36JQds?=
 =?us-ascii?Q?AhF6lHG81Q/hq0XZxT3zJPWRUvyryJUNTqG9j/cyloOYvr1Wr4SNEYzauw04?=
 =?us-ascii?Q?SoOYCiPZc1qlZXi05NwqoGw6X6jJnwBZR1qx0y98YdoQQzXMacNq5x42dhge?=
 =?us-ascii?Q?UD/vPrCxCWOtLHTZX0Z7qUobflc7s54rYJt1/3Res1l4zxJeGiaPFaOU4Rz1?=
 =?us-ascii?Q?ERtyx+ZjYTNhssy26tJ72Rw7lqASwghImnm7ml/f+yAiacggWDTdkV3dccE5?=
 =?us-ascii?Q?vIWL6aXyLTQu0N0wthOGCic62WQM6LMFx8kkW2xdrIY2ftgR+aIfgL29GCQl?=
 =?us-ascii?Q?IXIDpePKOU7CCWrTo+XuS2XlNbFQ17Dw0dL5zKHGbOrt+5By22nXWtxuTMBX?=
 =?us-ascii?Q?iYX9vUARa+AKU+2GyKGWTh8wlUyi2X+0oma/tSbUpDdOXheAMYADoSJW4D/9?=
 =?us-ascii?Q?VXUb+sKT2HK1y0AKIGEcfDuR1SmIMFjvmg6P1b1k3Hs0A79770z1LjZISoCC?=
 =?us-ascii?Q?6n9eT/ZCvtgGMEwnxFX/24SFsKa+LP+tWWAUPplncRSMklA4rUT2vZNLf5ba?=
 =?us-ascii?Q?RVSx1kFh9A55BZUPWO9L+ZqJqt6fZ0g4rW1+GRnZ163lloRTSJz7i7VfFD0F?=
 =?us-ascii?Q?wDsQ9711VsRBRimeksPn7k7QdTl4nf42N9n1LFWWPzkC17lfYcb/14+cF1nx?=
 =?us-ascii?Q?jXNU5zYXxTf5vb77Izs/SXGTqTthwFCY/qGjY+1TNkZsHpUdeLQeYtYlRRV9?=
 =?us-ascii?Q?l7GZN+k3Z+HpoW5xscOlVu9INSLPtr15r683G1T/m9+tSrr/lrhfvhWShSEw?=
 =?us-ascii?Q?TKya+3GHOcJHrhep+WkFfWpQ/AtfS4dDydWAssOuwzwZAwdEcdMlh+ciHtfQ?=
 =?us-ascii?Q?cNWoX/XWpma7WGZC2RPKknHJYwlC4ybeThO1PZ89Qc4MQm+EuUoTRPUv0C/b?=
 =?us-ascii?Q?IzWTwabcPx4HSHa3Zpo4JmMn6KgX4HTLVXmxP489dfh9Sw2/KEQuJHFfhsQc?=
 =?us-ascii?Q?UhXAQ9c0US1oss3ir6TGHT4keQSAg6zmnuDa2W+qAigxa8wyc76T4qxeAl68?=
 =?us-ascii?Q?09BPSpta2j9vTKNjKQ4z9uMcLDE/1GHxICiKzBILKL8aheIrT6EdHpcQc9Zc?=
 =?us-ascii?Q?tBgJCx80TKygYqPszRB6RxH+8NM89FWszXdmdeI524D7NeoT6FVLSNsxdGvG?=
 =?us-ascii?Q?At7lpxkjKDidkcBfzgNUPU3Pw0jf5xDDL8WyBwBYlEWWVfrbNa+ydCCsg9sM?=
 =?us-ascii?Q?wBQjFoEg4kvdRz9WWzAZKwn0Qcxe9Gte7tj6pOOKhXiM9pDZasfXw5WkAcJz?=
 =?us-ascii?Q?UC0Yo++9M9IrkBECWkBxPNUfZIpozP/qds342FlmgGSo0dmqHbr2V9kFL80P?=
 =?us-ascii?Q?lpO+u4h7kZO/71t//JFHclw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UI0zfA88tNzfS2jUZ5IzcmXurhi5eEF+YIYqDqp4MsQG8gNcI5Bfiwmtt5Wr?=
 =?us-ascii?Q?5UAkDhoWM9UDGLCHCH94+YdEz3j1zPkD8Cse1oRpacnkZcEUL0RRF27oEQyd?=
 =?us-ascii?Q?Ramv5T50BaYX7ljvOrmrUOQzQFBPX6hEoR921tkbKruOvMZkmuhDc56MLZuo?=
 =?us-ascii?Q?4eYlS2S8PCL2yeOb4B8dDWqPvtTeDLF4nDEDgSxys8Dt/blLWaJBQ2YMK/OO?=
 =?us-ascii?Q?y6djd1o11iKCLFLi0ahEqy7F4pWwnVqTFXQI9auJ91Lymb8MNqBc5oYGGsEL?=
 =?us-ascii?Q?mYoeaUFK7YCfdqD1VK+zQLNgpjXdUzHRDZqcXQ0sBlsp5mKfTo8tUqaGCBEu?=
 =?us-ascii?Q?RA1umRsKVNEpvF81aJsFhFgpowrsxqI5Lf2hXfXIfND8dDAPwb8M6zTPZtLG?=
 =?us-ascii?Q?krD1taNbcaBy/L5RVbW8/8e4E9U8lxISIcm7SZc4wMcLJfnvwdQh/gOmMu8J?=
 =?us-ascii?Q?ek9DCRUGfB8G5eTE37U1HSl+vxydRDk+f+KwENyVRRVQGZWp7MIATwIdf0ei?=
 =?us-ascii?Q?S+WjJaaoPO3wVX1bbv6YDq8UOa5c/gNW8twRkGe4eCO/s7x24WXLbcvyZ0Ci?=
 =?us-ascii?Q?Xbhk1V1ZMKaUTCthIZ+7jy20jKsgrXg/Gz9WMN9IACaRWR9kWGdgP2sI/KI3?=
 =?us-ascii?Q?TMRULCYBW1lCso5RsjUS19bp+AIjhfoQoK8IgsmkIklIbVVaP5jvJVhSotx7?=
 =?us-ascii?Q?K3btwUuOMjAcTcVnE/A/8V3Dhby7L5PA2ea9Pq23S6U0Hu2+Vc12cyKXTHxp?=
 =?us-ascii?Q?i7SNWYFsnrIDr47F8PmVlK3J7Szr+vzpYvi3ilNgdmqDK6arKuPyQbaCQKTS?=
 =?us-ascii?Q?7os5nyK95orLD1VNMDbeva0vUMV2zXU4esLMlosNw0zK0BmCuu7LZq031Qv+?=
 =?us-ascii?Q?y59yNExrFZVH8MCn+3rQOU0lRZ00UQjsv3el1fon+LW05Nc1j5UTGglfsKIm?=
 =?us-ascii?Q?z6uHPBZ3PhD7s2RnxneBoxyQkVRm2AnhgEhpggKfjkhaNGyEAZH6NwaLJZ4e?=
 =?us-ascii?Q?OxWJCPQ3dFpPo7j1UJMiynoxFfnnkB/1o9E9MtDTaf9+vQxXD47Kxr8iQFBN?=
 =?us-ascii?Q?AYQ75pF2gQnx7NLprBm1P5cB3rUn8XAeC96ClxTdxb+fZuzAVh+uMS0nP9qH?=
 =?us-ascii?Q?16atTgJtaMc4o/Eb61ebsmJ4yOWvvugE1ez2I8violCP14ZSMWaijjyOI5Zn?=
 =?us-ascii?Q?ba215LT5tR5/VBPM9lmlSZ6hLVsL5hw48pB5kMj0im1yiEoG1b1qdbNv7/z0?=
 =?us-ascii?Q?rdan9my03W299Q45yBNyU1Hubs7QL/646ZvpMODLkoCGdiCj/bZK0iV0GsB5?=
 =?us-ascii?Q?GrhR4VB1r3ZYMIN2cCqvp/5UEscVEeJgvWgWpen427YcfFeza0Ffr+0X7YeV?=
 =?us-ascii?Q?pE0zMOrmnOe8DeCf/nauJzSzx1L9JY2O6z+LXxu6Gz83vTobn36bHHmtoGYI?=
 =?us-ascii?Q?EZhBz0AjrD9y22JdPrsS1l9/QyRMJ+fWpofY2E4LCjiEWWykFlWY4cIT03he?=
 =?us-ascii?Q?V1NcBglWXYa24CYx/QlILNqTuxHcWZ2yp4ov5Y6/HrNFZE4LjoeeDsEkXFb6?=
 =?us-ascii?Q?OVxK8rdrVNmzaC2YVCtQgJYpCEJKaeJ8P4ftKaWWzAlY4iHeh2aQSdYGL8uv?=
 =?us-ascii?Q?MwAeXs9CGLpJs8LHER6HNTgyG1gB32hk2J4biXPsPM79tBY9DCNwgsUJk3B/?=
 =?us-ascii?Q?vNhZ7VMOut9t47pszt5BpAtTONGASQ2JdPWLtuY6VYd00gwP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241a35ad-c540-49d0-dd60-08de5fabf925
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 03:02:15.6537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+fWsFKUFr+1kDEC2C++SrsM4bVgQwN4G69126sBGx4D55IRgLPWe8JOyt1ePPqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Friday, January 30, 2026 10:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Wan=
g, Yang(Kevin) <KevinYang.Wang@amd.com>; Xie, Patrick <Gangliang.Xie@amd.co=
m>
Subject: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces

add smu interfaces and its data structures for pmfw eeprom in uniras

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 46 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h         | 18 ++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drive=
rs/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 79a51b1603ac..03922aa03417 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -28,6 +28,16 @@
 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B

+static enum smu_message_type pmfw_eeprom_msgs[] =3D {
+       SMU_MSG_GetRASTableVersion,
+       SMU_MSG_GetBadPageCount,
+       SMU_MSG_SetTimestamp,
+       SMU_MSG_GetTimestamp,
+       SMU_MSG_GetBadPageIpid,
+       SMU_MSG_EraseRasTable,
+       SMU_MSG_GetBadPageMcaAddr,
+};

[kevin]:
It is better add 'const' type for this array, with that fixed the patch 1-3=
 is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
+
 static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_cor=
e,
                                          u32 msg, u32 *count)
 {
@@ -87,8 +97,44 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_con=
text *ras_core,
        return ret;
 }

+static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
+                               enum ras_fw_eeprom_cmd index, uint32_t para=
m, uint32_t *read_arg) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret =3D 0;
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               ret =3D amdgpu_smu_ras_send_msg(adev,
+                       pmfw_eeprom_msgs[index], param, read_arg);
+               up_read(&adev->reset_domain->sem);
+       } else {
+               ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
+       }
+
+       return ret;
+}
+
+static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_cor=
e,
+                                            uint64_t *enabled_mask)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret =3D 0;
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               if (amdgpu_smu_ras_feature_is_enabled(adev, SMU_FEATURE_HRO=
M_EN_BIT))
+                       *enabled_mask |=3D RAS_CORE_FW_FEATURE_BIT__RAS_EEP=
ROM;
+               up_read(&adev->reset_domain->sem);
+       } else {
+               ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
+       }
+
+       return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 =3D {
        .mp1_get_valid_bank_count =3D mp1_v13_0_get_valid_bank_count,
        .mp1_dump_valid_bank =3D mp1_v13_0_dump_valid_bank,
+       .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
+       .mp1_get_ras_enabled_mask =3D mp1_v13_0_get_ras_enabled_mask,
 };

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index 3396b2e0949d..2db838c444f1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -49,6 +49,10 @@
 #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
 #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)

+enum ras_core_fw_feature_flags {
+       RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =3D BIT_ULL(0), };
+
 enum ras_block_id {
        RAS_BLOCK_ID__UMC =3D 0,
        RAS_BLOCK_ID__SDMA,
@@ -127,6 +131,16 @@ enum ras_gpu_status {
        RAS_GPU_STATUS__IS_VF =3D 0x8,
 };

+enum ras_fw_eeprom_cmd {
+       RAS_SMU_GetRASTableVersion =3D 0,
+       RAS_SMU_GetBadPageCount,
+       RAS_SMU_SetTimestamp,
+       RAS_SMU_GetTimestamp,
+       RAS_SMU_GetBadPageIpid,
+       RAS_SMU_EraseRasTable,
+       RAS_SMU_GetBadPageMcaAddr,
+};
+
 struct ras_core_context;
 struct ras_bank_ecc;
 struct ras_umc;
@@ -141,6 +155,10 @@ struct ras_mp1_sys_func {
                        u32 msg, u32 *count);
        int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
                        u32 msg, u32 idx, u32 reg_idx, u64 *val);
+       int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
+                       enum ras_fw_eeprom_cmd index, uint32_t param, uint3=
2_t *read_arg);
+       int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
+                       uint64_t *enabled_mask);
 };

 struct ras_eeprom_sys_func {
--
2.34.1

