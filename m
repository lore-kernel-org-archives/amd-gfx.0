Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987AFC021B3
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 14:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F393D10E95F;
	Thu, 20 Feb 2025 14:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="feLMo0yQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACCE10E95F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 14:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/Kd8aiVGaQs2D1kVBBGYcqupNMlw0HVbcaZfVxCSBStCEZv4DmBHYbj3m4mTwwgtit21ztWb/Lxo5IRxIF4pigpi/dX6G/gx75HIWHYcwNtHH2cOKQsQHLOzjrcePz9m8GztX29AEW0msyefF3kDeM94wX4de+pI6bY31txW7n+otYauDgUBO9/YbnSy/JmUUFBCHuAo8VL9GXzTxI6CtLshXn1AkJsFiBxTQ9uKS0D8/nF2loMzrUU04WdR5qr1wnZMROp02NX4NuMUiQ65rrUFRLAPyrnD3GfhEdBYeKSnx65KCzDdf+tU2pCk2tAgBYnHgwAkn9rGLrE8xNnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDguK7qOhtDH+Q0N+WYT7+TtZKsb4Wzcuk+tF57e9aE=;
 b=HCX3LicWbzYsd2vc+kzl9ejByPabFdcNsuezm0S631ZPEJQgQIjdalDTsKLZ95cGeo5CeO+MQPuEpzyzpNZATwEGUCIQK74QwiQc7yqaeYxRziPVfKuRc0xtZu+2aSKn71VFvhH8nuZglJLpjh6UQYJXHIyqggvydR3tyb/MbShEU3OdHfrR93CTaRh/edHw6zjFqv/+Q0LGPrgDFwsrm6jpKFj/FiVLB2HWPu96GMZ2TD3uvoiqYubBD2jvAN1Iyr8OlAA+6EL1IyIYfmHVZl2OuqkRg4heCRrnMe+S+MwuCaMxZxeWyYw3w/OGHRk5NPbN47mAxuShJhx3V3n8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDguK7qOhtDH+Q0N+WYT7+TtZKsb4Wzcuk+tF57e9aE=;
 b=feLMo0yQWS+w4vb4bt02SWNfOY2uidUa/aWZ1kV6Th0hsA235N+30AIJRUlmHwZ2MwjC+WXU0XsgS5jb+tUkJ71SOfkCPyn9uK/yuSK/QQjK8LRkctdG1GGDzf7ZbtscOL/VSnV5yVRmQnxAVxhtaN5257zelMwd91egXI4So1Y=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 14:01:34 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 14:01:34 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Do not poweroff UVDJ in JPEG4_0_3
Thread-Topic: [PATCH] drm/amdgpu: Do not poweroff UVDJ in JPEG4_0_3
Thread-Index: AQHbg54vcKzFTNcPX0SEitGVvcVeVrNQOJkQ
Date: Thu, 20 Feb 2025 14:01:34 +0000
Message-ID: <DM8PR12MB5399A4E85D1E1F945DC6106AE5C42@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250220134751.2992715-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250220134751.2992715-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d0ff3bce-e066-49c0-a711-c5211b40dce2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T14:01:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|MN2PR12MB4341:EE_
x-ms-office365-filtering-correlation-id: f2c5b219-ed91-422b-b59e-08dd51b715be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cGZqNUVFUUJoNlpLaHZWUGJKUlFLTC9TYWNkZURrdXQrRjNySVZaZDBCZ3JC?=
 =?utf-8?B?czgvUzhGeEdSUVBrYUN4bTQ1b1ZCWTV0YkwraGRpVmdmblFZYWw0eDlIeGtx?=
 =?utf-8?B?eFoxeW50bDV6TXo2VWxUdnRQV3hpQmppOXdoTDZZN3g0OVZkb0tXdlU1TnBt?=
 =?utf-8?B?RHRkYnpla1VJZzhsTUJPTjU1RVB0UzFMRDJJRE1nU2g4aW5sQmw5NGZyUHlE?=
 =?utf-8?B?K0VYMll4Mm00ZHJyNmdKcmN0bWRZK1dOUXJna2I1RzFoZWlTN0NObjRLQWla?=
 =?utf-8?B?akhaWGVja2ZMdkh3dG5wYjlhOTJSdVR4VTR2NlFmWm1GKzhUbFhaNExIYlVz?=
 =?utf-8?B?QUNhajNZUlcyMkROWllXOEdzVkYzK1NKZy9QRE1yeTVLNzdBWWdMZkZrWTRY?=
 =?utf-8?B?bUxwSlFHaEZkU2F6QUdWZUppSzVGUUsxRWtzZ3pjcnZtblRFblNsNW1rVHAx?=
 =?utf-8?B?dWwwNUg3SjFKWGtTcEpLdlY3NXNQS0dBRlpodjF3elpwcGoydjkrQTVSMkM2?=
 =?utf-8?B?MlNYSWx4V1M4YzNTV0pmbHZ0ZDNzbVN2ell0dlpOaTNXREY5cTl3ZmtGT1JU?=
 =?utf-8?B?emhkV1pRWkFsSzUxbFlJc1lWNSszQjNCYjJPc3Z3SHpDaEtFNmRZVmd3U0Yv?=
 =?utf-8?B?SEo4QXZIOG4vSlFXSEtBdHlta3U5NEtkQUhSL09rYWZrS01hZ2lMOWY3U3Vw?=
 =?utf-8?B?ZGdKWitZQmpmTytvVW1uODJ4VEZGOU1wcmJ1dmRDODFLYzdocFRkNHlWZmY4?=
 =?utf-8?B?YTE1Sm8rc1RSb3dveFBKU01wdTE4Q205TTlPVzVVbTRpU2dwUFZBenBGQWZi?=
 =?utf-8?B?NXNLYy9BSlY0WXVlZzcrRzFVeWN6ZExJRlM1THRrU0FGSlYvQmtZMUsrOWhm?=
 =?utf-8?B?Z0JTNDhuRGxuWGJzRjMzN0tRUktJeTJuWkhCWFoya081ZHhHL0doMTVZcG96?=
 =?utf-8?B?ckF2c0NFbjVEbVhZT3pZYlAxanllcVJ4L3FmaVhpSGkwa2ZjSGlUZGNEaFRq?=
 =?utf-8?B?bGJxNlNZekZ2UWRMemVNeGVMZ1M3QldIMjJxUlp2RWRkbDZGYXRUM2JpLzRU?=
 =?utf-8?B?aUFRMVZxYmVqK3JJVXdYdDR2ZXRGdVBXUklXSzd2dkNWTWt1MVFuWnJ4bjBU?=
 =?utf-8?B?a2VDUk4yTDFCUkwrRkpJR25rZXhUeEdzQTd2OU0rTHJxanRTN0JBVFlEVFRN?=
 =?utf-8?B?c0hDVEErbTY5eFNiWmN1ejFRV002dHVJMXBSeE42NWVZdU1oRGZnaHNqL3N6?=
 =?utf-8?B?VndFZkwxQ2NnQStrbUhEOFF6eUxkdFF1dWNuUWJSbnlMczQ2dFJkSFBWVE9F?=
 =?utf-8?B?Nll6NVlRZzRMd3I5RTQwR3lzdzJCOHR2L1RHWVhrWkk4K0tobzlJb2psYXhM?=
 =?utf-8?B?RUx6NFRCd1pieXdielpuSmJGdmFHMUpONU9WMStCYmJ2bTFxTmVaTGkyeWVT?=
 =?utf-8?B?OUVENHhrbm54cE1NLzhKMzcvM0paZmlsR3VYWWhMTENEYjhZSkU4S1pjTzR3?=
 =?utf-8?B?azRraldMSHVrLzBBV1lhL0hFZitWNkFtU2xyd3ZhSUFMUVZDS2U2ekI0YVBX?=
 =?utf-8?B?YjFJNiswREQzTmZ6YTRUM1pObHpOaVFBYlNOdk11WktNL3FueW9ORlM3U1hp?=
 =?utf-8?B?eUxHbWJKd0lueHJvdFpWeFlKT1ZPemNHTTFwc2huR1NLVVZ2MEZHOFVPSWpL?=
 =?utf-8?B?M0hUM1ZBK2NoYVIyZTlHUVJXNzlNQWJ6bmFOWEoxWngzcnhTT3VVaER5Q2ZY?=
 =?utf-8?B?WEVyU0NxcXczSTN5SHhXUUxTaWJTT2t0TG1lTWh0WlllNHp2WmV6YktBWk01?=
 =?utf-8?B?T1hEZlVsaktiSHBKUEhIT0I3MGhBY0U3R21HM0M1WFRtcHpCaGdBalB6MmJz?=
 =?utf-8?B?WGdLQUxjWE0rZ21QUEloZWwyMExFZThiTFl6SVlteE9meXZid1FrUkY2T1F5?=
 =?utf-8?Q?0SbW4qlBo1kxsNb+5+I1svCTLD+F2Y5h?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGp6MzczMXR4TFJ6US9NalVGRk8rUk1QNXdMdVhYUVphR003YUhBYmQzWUY2?=
 =?utf-8?B?c1VHWlJjRU1VV00zd21JNkVhc0RVQnhlT2xXdDZhelZCMm1HTmErd0JYaDFm?=
 =?utf-8?B?bTNTcm5DWmpKbDZoVGJDTW0xWEJQZ1dHWXZ5Nmw3cUVrTVVVcWlZSnNiTlZF?=
 =?utf-8?B?NmVwSXNSTlpJTEhlSnI1QU9IQUVNRklyajByaENqQzNWVmNXcVpvWW5oeldK?=
 =?utf-8?B?VGlyVGt1KzZka1NLZUxLdERBL1FBVFN1aXBoZEhjZ2tTZHhCV3NoeXBjeWdh?=
 =?utf-8?B?VEVBRU9IM0s0blBQeXp1OVNDZVZSc1V0WVZGNEpyZ1ZSeWNJR2VYekYwbVhm?=
 =?utf-8?B?OVlmaWFyR3BPbko5RWhsbVZKVnI5YU9lQjhLaUw2QmdETWlIQ0FpNnpPK2Vi?=
 =?utf-8?B?bmVpSDEvU1dGQ3pJSmdsMkdDL0NiMmQ1WVAveHpERDNUTnpjL2ZaNlY4ekxV?=
 =?utf-8?B?K09uckRDZFo4T29PR2RWNTE1b0QxL1BrVmlRUHFISk1yU0VMVlkrWnl0K3c5?=
 =?utf-8?B?bGovb2hoVGF5NGw1aFM0WWU2ZDZvcVNadURtTTErcVhCeFNkTm5XY1lQL1Nw?=
 =?utf-8?B?R0RVWW4xbEF4UVMwS0FjcFMwZGc5NEhSQUNHY2VyQ1VjRFZvT0ZXcUt1a29v?=
 =?utf-8?B?MGV1R3FidnIwOEV4QU40eWpjeGp2RThsU0U0MDdic1doMkhyeFJUV1EyVzRM?=
 =?utf-8?B?bmFkTmttZlc2SlRxanRSZDdRZFFicTlQTTRzOG93Z01JNlhkNEN4anVwdWVT?=
 =?utf-8?B?LzU1WnlORkU4UkJCL3JQNnBHaXNvclBKVGZTK2pQQmlGM0xySTlzSXI2eld2?=
 =?utf-8?B?dm1sOUtwKzVjaXZZWUJQVWVXVEJ4YURFTzEzTVhZK21tQVlEMUxaOER4QkRo?=
 =?utf-8?B?TlRSbEdQOExWbi9zalM1WFFsa0Qwc24zaGt6Nm1zTGFSTm0rR2V6eUMwbHhh?=
 =?utf-8?B?bDBqVXdEMGRBK2k0Unc0ckEyTW4ya2MvemNLeHpFTnNSM21rWTB2MTZVSVBu?=
 =?utf-8?B?WDROSWZVNjBJQ0VYVkFTQ1kxeVRTc0NBYnJhS2ovY2xIK0haV1prZ0FRdmZS?=
 =?utf-8?B?WXk0WTBzRWQxdDd2bXVvYy91MWpRcXorVU5kcVMxdS8rWWt0MGJMNXVwbEhv?=
 =?utf-8?B?NnF5eCtWQXVlSDQydGRUWWlwREZhWFlNSXJRQXk3NzM2alFJRGpVNTB5WTJP?=
 =?utf-8?B?RXNhVUUrQ2xXK1JZZGdBb1FmUVlwU0FKTnVuOHl4MTRLKzRYMVF1T2IybTdF?=
 =?utf-8?B?M3BMOUl3a09jcjRQLytKRlU1Z2QzbENuaTF6L3dDUlkzYXg4V21hZ2h4TXo4?=
 =?utf-8?B?UlA5eWpNWmdsb1FsRXBIbVpMTTdhQ2F2MlplRUc0dmFpb29EVkcrSSs0VWx4?=
 =?utf-8?B?ZkUwQnRzekliMHdmS0ptRmVPbE1wSzRoaHFSQVEyeTg5bnZCNFY4c1AyV0c0?=
 =?utf-8?B?ckExcFMxb2tUL0VDRkY1VU5DeXdSSDdjU0I1aWltM045R2pwM3k0MnlpTm5C?=
 =?utf-8?B?TGZic2ZsQ0oyWlVmaXpiK285RTFFdVZTVVluejlMeEltc1ZnbnVPZTRNSE5y?=
 =?utf-8?B?MUZ0SmVZUnhROUl5K2wrZU5ZWE1lRmU5bW90OENqdVA0SkRra1FwT0VwM0xJ?=
 =?utf-8?B?MVM3R2ZaQlA1c1RxZjRuK0JmajA3N09zLzBpVXVHa2xSRjhUSXdYbmNOSTRT?=
 =?utf-8?B?NjhaNGhFYTE2R3poNkpHL0h5clhIa014Vk9jQWZqN2VOUW13WUphdDEwZ0xI?=
 =?utf-8?B?VGtTa1dXRTR6TmhaSkRHSHdUUTN6Ui9rYzcwVDBjdWIwN2dscXROWWdiK2JH?=
 =?utf-8?B?NVg1cTJVdGsveEcyR2RNbU9vQkxtRS80MGZjeExtbGU5UXJBOFp5OTFkSlVR?=
 =?utf-8?B?aTI3ZVpzU2JQQkZYaU1VeGtTUUVrcm8zSkZpRUpBRDNwRHRjTWt4T2ZCTkNB?=
 =?utf-8?B?c0FydGJqMjY3Qk84dUVBRytEc1FFdWpWZWZyQzFzUzVpbE9PcFQrUWJscHFw?=
 =?utf-8?B?KzJReFlmUTZkckJ6SnUzcStsa0NMM0JmWi9yVkV2bG1KYllZdnVZNis1SlQx?=
 =?utf-8?B?bTRyUXp5T0pVcTB1VUEyZkFLVldETzQ2MjFQcmhtVDlPUVJSZWVFTXNDSk5M?=
 =?utf-8?Q?gLzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c5b219-ed91-422b-b59e-08dd51b715be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 14:01:34.1890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrnuGNaiZvTe4D1hn+C2+t09KLolCbGMK4In9Rr4xGj13rbTPJuKc4hXOOCrZE2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxTYXRo
aXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gU2VudDogRmVicnVhcnkgMjAsIDIwMjUg
ODo0OCBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IExpdSwg
TGVvIDxMZW8uTGl1QGFtZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyDQo+IDxTYXRo
aXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1k
Z3B1OiBEbyBub3QgcG93ZXJvZmYgVVZESiBpbiBKUEVHNF8wXzMNCj4NCj4gVXBkYXRlIHBvd2Vy
IGdhdGUgc2V0dGluZyB0byBub3QgcG93ZXJvZmYgVVZESiBpbiBKUEVHNF8wXzMuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IFNhdGhpc2hrdW1hciBTIDxzYXRoaXNoa3VtYXIuc3VuZGFyYXJhanVAYW1k
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3Y0XzBfMy5j
IHwgNiAtLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192NF8wXzMuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjRfMF8zLmMNCj4gaW5kZXggMDU4OGJiODBm
NDFlLi41NTQ0MDZhYmU0ODAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2pwZWdfdjRfMF8zLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBl
Z192NF8wXzMuYw0KPiBAQCAtNjM0LDEyICs2MzQsNiBAQCBzdGF0aWMgdm9pZCBqcGVnX3Y0XzBf
M19zdG9wX2luc3Qoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBpbnN0KQ0KPiAg
ICAgICAgICAgICAgICBVVkRfSlBFR19QT1dFUl9TVEFUVVNfX0pQRUdfUE9XRVJfU1RBVFVTX01B
U0ssDQo+ICAgICAgICAgICAgICAgIH5VVkRfSlBFR19QT1dFUl9TVEFUVVNfX0pQRUdfUE9XRVJf
U1RBVFVTX01BU0spOw0KPg0KPiAtICAgICBXUkVHMzJfU09DMTUoSlBFRywganBlZ19pbnN0LCBy
ZWdVVkRfUEdGU01fQ09ORklHLA0KPiAtICAgICAgICAgICAgICAgICAgMiA8PCBVVkRfUEdGU01f
Q09ORklHX19VVkRKX1BXUl9DT05GSUdfX1NISUZUKTsNCj4gLSAgICAgU09DMTVfV0FJVF9PTl9S
UkVHKEpQRUcsIGpwZWdfaW5zdCwgcmVnVVZEX1BHRlNNX1NUQVRVUywNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgIFVWRF9QR0ZTTV9TVEFUVVNfX1VWREpfUFdSX09GRiA8PA0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgVVZEX1BHRlNNX1NUQVRVU19fVVZESl9QV1JfU1RBVFVTX19TSElG
VCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgIFVWRF9QR0ZTTV9TVEFUVVNfX1VWREpfUFdS
X1NUQVRVU19NQVNLKTsNCj4gIH0NCj4NCj4gIC8qKg0KPiAtLQ0KPiAyLjI1LjENCg0K
