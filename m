Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0697BC71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 05:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C99710E29C;
	Mon, 16 Jun 2025 05:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4/ZsT4in";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE02F10E29C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 05:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihf/TSY/XgesdR+d0b7EpRJgQ3E2SEjYsoSz+AaM/g3dXj6jBVsP/1TSNWvFKqhw2aEFE12ULijCCecVlTUYlkQ5xyGFEOzUsKbZjDSZ+KuUR9eEW8Y+dgR/kzNU1Mr+XEBMG2hCXUcRmHchwe2RV3Bflo6nj+tGjv34fl2HOXLV1fOoYwFIChU7/kCGQj81Qc1IqK4bc2D37JweVVoxDHr1vP+V8rzv8+HKVXyTfUCOlfXbzlFDJMOUYmFlEfROchmokLGHFf2MSBS78dQwYJb4JB7dGbqDsbA5KXR/Bh/450+IByOzglTgn+oJZesNDWv/9PA44noeHoOedgoN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myPPqvR/ILyEIYo1iAq2bwAybyPLl1zpE2PmjQhaOYg=;
 b=ue1Trs7aL7yGl+7ajGo0uNZMDq/7QOEEYN9XpCTIUToPPJLsToF+bqIetKOc5xEK6ATaDHXiGNCCktr5hhKBSj9OOezxXpVvYT8P2mBYwKh4vBUK9H0kdXnN44JZ7t8gM5F9I51b2tGxF4rPfTU+8If6acsd598eGISqaOot2CkYSoh0Iiaao8cpvVLRIqEQ6a0zgtj63Am2ImJWNsZ8ZmEJS220d2kEswT6nt9tSyaj/fkxxBhkusCDF/i4nOyes+iXJ8RJEvfIvaYjBOKYKWWuAFyBV8LteY0D8SbIFEH5jI8Ikjai7PhWnkY0/M6Aw0Q/SEAmFExcNjyxO6TmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myPPqvR/ILyEIYo1iAq2bwAybyPLl1zpE2PmjQhaOYg=;
 b=4/ZsT4inuXKXvGN/K6wRoPunq9ieSHlnIv69eCU0EH8wBfFYz6flWKHrfI72MAiXjdAZMPiSu1hF7Xt+6CgDt9qXDXoprIkQfIRDJmC2tm3XTJwYbJNUBdCVRScwpLCqBMjc1JYSble+e4HNSDX0HJwa8JjR2S0PAIWtNwXuZ0o=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 16 Jun 2025 05:50:54 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 05:50:54 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amd/pm: Update SMU v13.0.12 pmfw header
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: Update SMU v13.0.12 pmfw header
Thread-Index: AQHb3oD8uIfwe7f1o0+yivtgr+BcQ7QFR7gw
Date: Mon, 16 Jun 2025 05:50:54 +0000
Message-ID: <DS7PR12MB6071F9849D3599F9231D52648E70A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250616053851.868243-1-lijo.lazar@amd.com>
In-Reply-To: <20250616053851.868243-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T05:49:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MW6PR12MB8736:EE_
x-ms-office365-filtering-correlation-id: 1d63e8b9-f861-43ef-67a4-08ddac99c266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2rhCDriayQFRmW+VcfdfGWCnzWdVhn6f23INhosqn7ga2xQe9KxJqU+iJEi4?=
 =?us-ascii?Q?xY65u1DrDaKd7e9zoXc0OwLxM5fH0Xvt/xOoyghQlFn+Jxt8KZnqEKaoyg2k?=
 =?us-ascii?Q?oH2XIhb5mcL2kZemoNJaEFQUYwWHuSV7VmBXwbiT8OgilxCcPD3ei27hN1xT?=
 =?us-ascii?Q?t1HsQaQg6s6BqGm76W2WcyTPfSfzl9mjLVUN+3wivPku4Ihir3zGqtFK/dGb?=
 =?us-ascii?Q?airwCIv5KA0mP5W8tlJOxid56vABn2bfyTB979Cq5XV+EI+7qMctNMUwz2w9?=
 =?us-ascii?Q?yKWzopZCSWFLPKMmvad/0y1Ac9QCtrVsE+cuyUOWiiWfqzeQoDFC0B8A+ZVC?=
 =?us-ascii?Q?9Tso50Rv+LQdkA0x9Ow+HjOLOOwTtygvtRHcHTWVbPhuPNSsqB8vmLROFZ8A?=
 =?us-ascii?Q?J3Py4XykCokHLTxUGEhgsg+cM+JwJJYqBDL0c8pftH/YlB9KGzQtln0jynxV?=
 =?us-ascii?Q?qAoc1gNgIouhfgJN4JsVkhpG9SxgRK5lSU0HHfoKt8q/bxbAZpWkCAkX2Mhm?=
 =?us-ascii?Q?vRUDi91+xmaRWe+R75pC9f/USkiYX2xXU+HIB00o17TFksgYWN7QX9CVyIdX?=
 =?us-ascii?Q?pW8QDk4tDOFgs1cNcLQQxzCKPQCzvGIOvzebvBMBiAwm4onj2zJW53iBofyM?=
 =?us-ascii?Q?XVXT7bIU88TCf6tShluRPftEGn969YvAW16yW9ZuLUIxIhV66w4O0dngKOa+?=
 =?us-ascii?Q?WHzp8nBbbbOf6/mPXzkv6UH/a4++lQNZkXt6VBsLgC6d/sFh58Nu7HxA7Mhn?=
 =?us-ascii?Q?1VkopF6uZybNaLnDZ2RLeLxZ1o94CX1nb9eC9Bf67WNGv14rmVCbqrUvvI2F?=
 =?us-ascii?Q?Iwymi3Y/mpyhBLVsz6nzX/LvZbfGAcDy9XdCwUwKkPlSAYlEw0+NHBSqQvam?=
 =?us-ascii?Q?QUgtZFCYy5nutmqZ9uzAC75DJ6WD3NQRSm2v6C97UGjmIPEeoUnPzPfu8Xf8?=
 =?us-ascii?Q?KZoGffrcm5JZDPu4ukJURuBtSj0iXD9TfdP/fX1XS1YvIxmhalwt56jVNT98?=
 =?us-ascii?Q?L2KJJBGvtt417tbg6p4Y6ZtEty/moNBepf/g/p+ST63ewp/jRcyrNdoaJ02q?=
 =?us-ascii?Q?EI5VOjEuAC1o8NaHqOl2I0tD95LSLqdpe1VyFHZQVjysN2IBebL1KEd+mXLR?=
 =?us-ascii?Q?7vGxObhl76amIdZRM7FUXLBlIsAnyIjQVS+rEnv5XOWOwl566Zsj1MUs0NMO?=
 =?us-ascii?Q?q7nLodl3nXaLd0+A7IAfk/E1bXX/NIjPtW3/jm9Y9hSsEIEaovqLvz24CbPO?=
 =?us-ascii?Q?jjfwDi6DsiU7mJCFJktlvG7UuC8DWLAKb00wE53PQzN/VDzlGT/FgyfADKti?=
 =?us-ascii?Q?fEGymK3aNVxtZJoi/xGrg6iYGeTLl5KHo3+tFZWQc4mbriCWqy02eb4WrhMe?=
 =?us-ascii?Q?Jg96Ni/yv5Lz3chXfKf6KaduGtAGxpUEXan9D8S+Mph4y54WjWKCj/ENwm0P?=
 =?us-ascii?Q?6IwDnTU36MF2kRSAadLbWR1nDrAa1TfTiNsQlbJTqqtKEDYgPqUzuW6MucIE?=
 =?us-ascii?Q?7bKWD+QZbmnzzn0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZEFqJd4NtX1/syHyZufetcYiqLkVCo7tMhq1DYE759dTC72XS8ip4uRm1Xav?=
 =?us-ascii?Q?MMCazAzB0BekWfVuHIPIJ1RVyC8rMlgWK+qhHCqB6pAik8ARyOrk3VFeFnHo?=
 =?us-ascii?Q?QhWjKZ+M8/hmCDo95gtbksiA9CbGlByDwVseLvSZfOz4tiF7tmuOfwRgTWsy?=
 =?us-ascii?Q?n8lvBlvYdPV8ZWnuNQjLare7ZHku1p6HDetFZbhxJlKfYuHEiz3GkptKh+By?=
 =?us-ascii?Q?5QR2ZnGYjnOAFXiZK5RluOmc4JYlpkki+lpB9bPaNUNg0VaxzkXNZlvXSYo+?=
 =?us-ascii?Q?ftLVC+m3H4qoU8K7zf0Y5S3tThxA6kzSaZN+s//O4mFpe8/Ri5Jd0AzuENRe?=
 =?us-ascii?Q?Qc/qZvhIlr4w7edwBgPvIttgoH473QMFmBQFdfJ4uTnRkr31VZ4P/Dg6id2n?=
 =?us-ascii?Q?UGGQOEY7WTLXItbEe8S1LvFjxS0Unc0nrH7Ndf+KRCUouo/fS1OH4zuMG9tu?=
 =?us-ascii?Q?8Dj45KBMtyHkefDLX9VUyxAZk7oVBXrgVyGhq61+xYX1nI5mFhVMU/FPoXcO?=
 =?us-ascii?Q?Gsu24qDlfMkpc5Dw659BUbsEVgaiWlkfywr1Rbe770y4aLN2CN58PNy5Uo/8?=
 =?us-ascii?Q?tWsJe/psZVinYdeboSqKfqZX1hvTvg16bBIV7Z7CUU+AVomoVY+aqZX+BC4E?=
 =?us-ascii?Q?ArocVxydHXgEG28E2y4eD+bgcLfXNSr+IihAA1rBjvn3Nbi/X6YgUWPWd33G?=
 =?us-ascii?Q?xdcWGo7XHY+/qJHQfYulvvnI5IQwySTA0pMl7O1AwvxXIi0qK1TQGJE/Ky5R?=
 =?us-ascii?Q?4waTEjEM8Mo4Ur+Oq1gaFwn3pmRaFfG12XhTQWJubSj2CP337uDfzLQdw+We?=
 =?us-ascii?Q?0s2/1M0Y9kg879WX4Jxo0eI9psgg2romRAskV7hMtKetJjhXwd8yYva03U8h?=
 =?us-ascii?Q?QgP6hjELvFI9qKgx4QiULZxdiB0Caz3sXEg4ax+B9hw+dLhpqzTBxg9toLwR?=
 =?us-ascii?Q?TWtIlPfoKq7OiSe6543SlU4Lh5GWfHMgFoHemHAzXEuJ3PCmLsAvPOYEoGqt?=
 =?us-ascii?Q?8FO1NIM+eYPR/vMjMwzJHXqpiYgq6orgW2i8FiP6LmMV8loX3dnMynIgqlgP?=
 =?us-ascii?Q?gxndjKC/qtspt1+EL0TaBs8tJjjdQ6iRxlegOCKIQmtdXUHpq6OFXuzgnh1X?=
 =?us-ascii?Q?lJyj7rxFuJHtC4PWCCUOXtN7V/5N0Kl4ceE9rHXiZvldhJ8Z7a2P0OWDO0mJ?=
 =?us-ascii?Q?NEA6d7ZWZg9BeKVh+Eggnk70VTIirVn759B5e/hK1h3CHADitceA2ZfnCOvR?=
 =?us-ascii?Q?bEiL3K9aLHk4AwrzFPc6NrNnnyAbD/pduAlurDCWhLMg/sbON7N+5BQVtcjH?=
 =?us-ascii?Q?/WIs9bElzP0GxGxK/L8HnwJXQYtM+nmUYYgrHn/pzeQAC3aH4BGwJ+tv41E/?=
 =?us-ascii?Q?fCLnSoyOZrkhcwoB6Fl1B6mW/Ur84iHQMNwbemxecYFAB7m8zS+mKWkVjxg9?=
 =?us-ascii?Q?J/ZwyEz9oPzHzEulsJc7BWlRzhNFNB/HBXRTZ4g/nVD49Uf90ahifPZYr8bq?=
 =?us-ascii?Q?GSvHIrSnRW7a6DvtajJ+L13iflGpILYmqDRtRDPWoCSvB/7lU5WCacehQA4I?=
 =?us-ascii?Q?oqj2GOpJ1+NGn9QLLR8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d63e8b9-f861-43ef-67a4-08ddac99c266
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 05:50:54.7889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACYTPXTYfQq8qvopRZRfg28iP5l/Yg0YT0AQts97h6gAvHv1HCWW9i4MRF4OwVYtrSMP2mmkRG8uoeXRFoVNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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

Series is Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 16, 2025 11:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Update SMU v13.0.12 pmfw header

Update PMFW metrics table definition to version 0x13

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index d7505cfc433a..0a2ca544f4e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -86,8 +86,10 @@ typedef enum {
 /*36*/  FEATURE_PIT                         =3D 36,
 /*37*/  FEATURE_DVO                         =3D 37,
 /*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       =3D 38,
+/*39*/  FEATURE_GLOBAL_DPM                  =3D 39,
+/*40*/  FEATURE_NODE_POWER_MANAGER          =3D 40,

-/*39*/  NUM_FEATURES                        =3D 39
+/*41*/  NUM_FEATURES                        =3D 41
 } FEATURE_LIST_e;

 //enum for MPIO PCIe gen speed msgs
@@ -133,7 +135,7 @@ typedef enum {
   GFX_DVM_MARGIN_COUNT
 } GFX_DVM_MARGIN_e;

-#define SMU_METRICS_TABLE_VERSION 0x12
+#define SMU_METRICS_TABLE_VERSION 0x13

 typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccumulationCounter;
@@ -275,6 +277,16 @@ typedef struct {
   //PSNs
   uint64_t PublicSerialNumber_AID[4];
   uint64_t PublicSerialNumber_XCD[8];
+
+  //XGMI
+  uint32_t MaxXgmiWidth;
+  uint32_t MaxXgmiBitrate;
+
+  // Telemetry
+  uint32_t InputTelemetryVoltageInmV;
+
+  // General info
+  uint32_t pldmVersion[2];
 } StaticMetricsTable_t;
 #pragma pack(pop)

--
2.25.1

