Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298A5C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 00:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA8010E2C4;
	Mon, 11 Aug 2025 00:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLtv71dq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE4710E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 00:32:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aflc7/qvKsvbzazmGMHANOyuXYzZfLaK1TEaiu8g4TTRYIHBSWqHGrjdtbWB5wm+FuCuqT3qA08JSDFnhkAMPwQK+VWwSwCmvcGhXO6GOtMX92bmERlgvkyAJ/brqqdCLM341BjQjLY7+ZaEWbNEu0HXQHUrwr5A1o/7LLIZe9JNbdAJvmBAv78MDyr4DLUtn9bet/ojfBORdesyKyF5zBAb0ojkQFC+H4hBdOCobe62lrgXoriwnuqEBfO2Wf95NURY99v3iVeHBhDUWlPyvARXXp6txTNqf4KjBpy1RgGH1F+iNtCWmlfwuZ7iOlP/I6nbp0DdUlIdRU3Tg+G8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKLAZrUVlL20pV97usI3XYhLUQMSJnO/ytOg0SK5lrQ=;
 b=rH37LmNg6sDgQEALAXPIkBqjnjG3HTtjLPBsEYtv7QvZbzF9YHy19wGKwChxfoRhjx2YUxoQ9Aa9BM8tyXdDTDHAVCxXW+lpKXgnPxRa4XZE3J+e/5I9i+34uSCZKXfjaasb4y4Vv+NmdWUk0tbUgMToxANKTxxOPCr6YFZp343reeA8zmV/OgKbVKt2UfZ/Sd6fOcI8SNWqX3j6jku4BQuUNtz05T3ma0V/12exHLUwMWGGLaPNK8i835jYWZFmQJdI8qwgpS+Q+OWt/x+WYP1iu9XJBVE5jQvCpM/HzXT7aRRatduFLs92YkudXsFp2Xs9AjZYFaEX7xBEZEcisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKLAZrUVlL20pV97usI3XYhLUQMSJnO/ytOg0SK5lrQ=;
 b=jLtv71dqug4DtCdhL3HvlfXRTwS6OfryKK2JxSsMP/SR3wZcqUHk4zZgWaiTwX2TVzjsxOse7Ylubgi8azJMVeWLMpycb2kO+4UvppdCWy7Jr9pPLk4o0DptoEGlXYz3eZVZydSneUZcFzKGLox7jb/nUbSJG5aVz1eKMzOLhX0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 00:32:53 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9009.016; Mon, 11 Aug 2025
 00:32:53 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [v7 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Thread-Topic: [v7 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Thread-Index: AQHcBnnSmXhDvOeE1k25ML92Atrf1bRZLZkAgAN0LuA=
Date: Mon, 11 Aug 2025 00:32:53 +0000
Message-ID: <DM4PR12MB51521B6894929ED889ACD2F8E328A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
 <20250806022816.1050823-3-Jesse.Zhang@amd.com>
 <CADnq5_Pi-UD1VgRTKD9f5ZggO-bMLfzaRBbM++F9ZRvJF9vF_g@mail.gmail.com>
In-Reply-To: <CADnq5_Pi-UD1VgRTKD9f5ZggO-bMLfzaRBbM++F9ZRvJF9vF_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-11T00:32:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV9PR12MB9805:EE_
x-ms-office365-filtering-correlation-id: f70eddd6-18c3-4f71-91aa-08ddd86e9c3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YXZ0WUhpVmhHRFpENk4vVHZxRXlqeVptMkd2Z3JYdnYzeEZRSE9tMTYvcktv?=
 =?utf-8?B?V0sveUxmdGFVSzQ4TXltV0x1cEM3RDdHM21Id2FKdHhHRW1TSDI5NVJFdnp4?=
 =?utf-8?B?ZzQxcmRBZmhpUzlQWXIwb3dHVHFxMDI2RlNIRS80QmVQc3BSTUdlMXhDbThs?=
 =?utf-8?B?UW1VdU9tWkp1Sms3SzFrc2ZEK2htYWo3RlVGcmZkd1c5R0lVdzRzWDRVM3pL?=
 =?utf-8?B?TXNuTEo5S3F1RmtVdzZ0MDF1dThMeXlxSzJmU1hxZ2pjeTNTdXVZd2RGdzhz?=
 =?utf-8?B?Z0U2RTl6WUlOZy84ak5ORzgzaVdQTDgxVjFueXpmVGpEQktjWHNLeHl5NEZn?=
 =?utf-8?B?blVQZU1GNENRdDM2MDVVWXhCUVRVNlYzR3BDY0QrNU9VSmU5aEozeENBRUFL?=
 =?utf-8?B?T3J1N0FmajUyMm9KbzE3ZzNZNm83YUNZOGwwV3NrZ2h5N2lDYi85ZG1mbjVr?=
 =?utf-8?B?QXNpWEVJRmRpVWp0cmdFemk4U2FSNlZHSCtxZVU5QXpxZy9xclMwNVg5Slh5?=
 =?utf-8?B?ZUJneW9OM08zVEdwbFNINlhqYVM0NzJGVFRtQjk2M1ZackdTMUJOMi9OTFhN?=
 =?utf-8?B?cWJGaVgvU2o2cWtpbktBRmRCRGdOUFM1dXBHS0ZRd1FIOGZuWGhDMVRMOWZL?=
 =?utf-8?B?RGZqK25Vb0hOMk5kcmJXVUdjVFJST2UvelFSZlJHeG9nMWRJYWpvcGs2UDhq?=
 =?utf-8?B?OXF2c2NERGpxT3ZWeVJ4cHgyLy9ZQjNrM1NBbzRrZHl6VXc2RmxYcDZPZTdP?=
 =?utf-8?B?bm0xOEZ0MHlrZldnYW5rN01aWmJiWGVVdEVkWmR6RFFya3dOeTJpM0dFYm9P?=
 =?utf-8?B?eXFHeUs5dmYxWmN0di8ybmlPUkVURW9JbVArc1F5K25PV3NXUGJDWk00Q3FN?=
 =?utf-8?B?NXRLTDcrVUpJY2tyNE5BYllpU01EZ3FQMmVFZFZVRm5Yb3JNY3dISFJTT2s4?=
 =?utf-8?B?WXdwdHAwK3A4UU1xVmpqcUV6TndCa0IyMW9kdDUyZXkzNXJRUUtNbU0wc3JF?=
 =?utf-8?B?Um80VjZydmZJZGl5Q3hqN0c1b253NGNQQXBNaHVpYWwxVDBaNThjNzYxQVpw?=
 =?utf-8?B?MmFiTGQ2cndPeXNITlZXVkMrdEdFVnFZMlp4SERIQW5OOFNnZFNZZ2dwWXM3?=
 =?utf-8?B?RE0vc1FEdnoxbUpDd3h0R1VsUlZ2akVEWkhFdHNkSDFKcjg1cC8xemdUclhM?=
 =?utf-8?B?eEc1bzF2RzZGN1dlUjlVTnUySFU4ZE5uNmZmVlp4VFI4UjlmNHU1MjRoTnFz?=
 =?utf-8?B?d1ZRN0dMR2RRcEFaa1o3V1FYclFIeVF4bE1sTU9UQTd1NDBrKzIyNEJEOWJr?=
 =?utf-8?B?RkQrNndsQ2RHc2h5WG42R2VvdldxeUZoSWhUWkxZcDlXOTI4Y3FxbE9taHNo?=
 =?utf-8?B?RWhwYnFvTmlXZUdZRE5rWDJ5T3NnQVNDME81Q2Q3T09uUnAvOHB4ZWxTTWo4?=
 =?utf-8?B?YWFXNFJBSll5WVliYVgxUG5peGlNTTlLQkd2dkxLWUt4MkhReXo2dW5kK1JQ?=
 =?utf-8?B?dS9JMkhwN2FFR2xvSzY1U2lGVGFhRGdRNHFzVHE4d1JvU2ZHclkyakNsZnFN?=
 =?utf-8?B?cWprM0R0b0M0TmZrVzBwVDZGWjhWVXR2Ymx0bndzRlpBdmxiT1dPcUFiUjhE?=
 =?utf-8?B?MDZyM0dENkVVQ2ZNckF6YS96Y2EreFMwcTl0REZMYlE1T0VRTmJ2V2tBMjFo?=
 =?utf-8?B?d09iRDRmMFpYNk9TTzFPaHpxYW9kU3c2cVp5RzVVZytDcTJXdUdreWZhM2dv?=
 =?utf-8?B?OHFjVmRpd0V0WkVPTzdqUDlMRm5zRDZpQmNtVG14d0ZzK1pFTHJ6aTZFK1BT?=
 =?utf-8?B?Z2hxRnVKc2crSDhKTjlwUGE4NnpQak1OS0xWQ3BTNTZrT3pNZUxWZ1IyelVB?=
 =?utf-8?B?OEwvQVhQMXhLMmR6YlZMTmxkVWI4Q0lPbk14a0FrTVhFZjhoZnV3Qzg3dXAv?=
 =?utf-8?B?dWVYZnVTVmczMkNqODhGTll1QTlzaUZvbkZBY3J6NVlocXV2R2Z3d0hYcUtv?=
 =?utf-8?Q?ZxQhlasgpvfY0rXnCaPGa442vNZMIE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1R6VWJyQW1kZGUrbVJZbHNWcmxybjZBdGJZMFIxVk5hcVNGU0x2V0M2YmVw?=
 =?utf-8?B?Y0pMY21vZTdFSGp1eWlWc1NKRm90Kzc1MmMzTnB2dytOQ2IvU0duSUNhSStO?=
 =?utf-8?B?MjYzd25IZzIybld6TEdVd0pUSkdQbWYwSDNHRzl4U2xNTVZnb2libFZoajRL?=
 =?utf-8?B?UThpTlQ0UWFEelgvbGNMYmRxakNBa05lMHJISmorMU9jbDZaWVBCa0dqblpU?=
 =?utf-8?B?bmtoa3JadTZyTGcxVEJOV09YNmNKNUp4WEduNFlBWUVGb2JCcmpOWS8xL0Qy?=
 =?utf-8?B?U1gxemY2cDhTTjFJbndLUXhBMHhyNUNYdWtuZ1V2bzRlam82eTVnUnZqcTZ0?=
 =?utf-8?B?alpWQlhKUGRzRUl4UkN0VDNxTzlrMmVpRnYvRnVsSjhFSnJQQVZsQ2dIREtW?=
 =?utf-8?B?NGV5Q3hpb0VXODVXRmZ4ZE5IRTZXelI3MHdoUE04cDZLZXVPemdEZFZyRW9k?=
 =?utf-8?B?eWNTa0RadDEvZEpncmxBOHN1R2VseFp2Q2FJVVBRMnlwc2lrQVVVWURqeUNr?=
 =?utf-8?B?OHNHQmVHSFZ3bkgrdjU5bFowOVFseHBkemZRdndZa1ROR1piek9lcit3UXg5?=
 =?utf-8?B?N0RlUUVTdEFlYkdTWVlLMndEdW9sM0JUcm4rMTZqbWR3RENtMm9kS2VIVlNo?=
 =?utf-8?B?ajN2U1EyK2xmZ2Z0QUFRdXA4VHFXNlh3QXRTeHhFdDFHMjUrWmVOK3dXclhS?=
 =?utf-8?B?YVNBMDZyTWNhSEVIT2IvS21RVElzUmMwc2tKeUxEc0VCTmJLelhzQzRTdjZP?=
 =?utf-8?B?YmwwNmtGVDh2b2dBbzV4bGF1TXdkb1VCTkY0c0M5KzA4ano3d3h6N1JVekdM?=
 =?utf-8?B?L29jKythZWM4dVJSNDZRcHVDc1FEU0JHVlBXMHlXNlo1Tnk1djRsV2dZeDly?=
 =?utf-8?B?dGF5UURXSGxmV2JhTnJ5QjM4aTZRb1owR1lKa0dnOG9RTTZ1VDFvWFBvMEth?=
 =?utf-8?B?VUxmb0d5NFN5K2pEdU02V3F0cUViRkNlNDZxOVlJQnI1VElCc3RjelZRbkNl?=
 =?utf-8?B?STZDOVVTWFp2cGpQelVGcW9hRHVGcGdLY2ZUUXYrRFljVXFhQS9weHVMMzE5?=
 =?utf-8?B?QjBsbTAvZ2JXZ1RnUHFJVWNkWVFBdFh6RERtMnhXRmxlM09KZ3dEekdpU2tK?=
 =?utf-8?B?d3NUejNHZEpEcmhVRzBCRnh4Ym1Ja0dPTXh4OXMvTHFsY3RJQVJNUERnR0hh?=
 =?utf-8?B?OXR3OURHSG1vc3pCS0RYMFRtOTRvbEZSL2lwRHNPRDNxM0p5UzI5bUsvMFFt?=
 =?utf-8?B?MXFjL1ZkTWlvU0JkOFVaYlFDK2thbUF2WWRWTmJvdHFJUkFId0ZvY1ZhRUFw?=
 =?utf-8?B?R1NFb1VBanVxSUxxdnFlYU1YRDB6WmNUSU5GdmFTRGNjenowcmZpNnFlaGhM?=
 =?utf-8?B?VVJNN3pZcEE4N2d2djFCekkyd3ZhaVQzWkZhY1AxUU5URDdKTEhRRUF0UG11?=
 =?utf-8?B?dVZiN3NkcTRqY05pdkFDY1NpMXZRRGdTQklYOXNGcGtQcDVCZmhFSGFGdGJM?=
 =?utf-8?B?MXk2ekZlTVhuSUJlK2xEY2tzd1k2TmxFNmhLb2xydkFJQ2U5OE9zNVZuUm9n?=
 =?utf-8?B?T3V2WGs1RDdmYTJCWHBqQm5KaEhHZW52REZsc1BrRWkreXdLdXpXNjZWNWtx?=
 =?utf-8?B?WHdITzgrMmZEdlZhL1pBTStsd0l4am5QWU1ydWVVbDNEbkU5eGNyZzE0ZkZk?=
 =?utf-8?B?L1A3SEZlcHh3OUtDVHB3TnNib2dXNkJiVHZwYXVBbURNT0syN2JiNkVTTEx6?=
 =?utf-8?B?TkYreTduYWZJQWl4REFGeEtHWW9FTHJTMU1WazJJQzlrcVdXbktKem1hdjh6?=
 =?utf-8?B?dFhKcHZmME9IN29Jbm5zVEN3SlNMODE4c1ZxSHZKQUwrcWR6dkxWTElkWXZ3?=
 =?utf-8?B?cUUvcmVUdGEyci9NVTFua2ZKbG5vNCtQdnJPZkMxSE1YbUpEOWpjRlY2eXFl?=
 =?utf-8?B?RmltK01aNDc4aHJsRXA4cklOVXlXaU1OQ2d5QURJd3BhOTRHV3Q1K2EzUHJS?=
 =?utf-8?B?Z0QvRXo4eUQ2OUpKSllKbFJUZG0vSjJxQmRkdWg3MjljbDVaUERZVURCREtD?=
 =?utf-8?B?RjRyZFNiODRHTXYxRnhGYXdYN0s3SFQxUGNyN24wZ2hzVDlTNHN4a1EzdHps?=
 =?utf-8?Q?nek0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70eddd6-18c3-4f71-91aa-08ddd86e9c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 00:32:53.5082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCU3lN0ghEl8GHh9AeGSPXLZNye0HQQfLI7hMIBJe6QeOczcTaftEIp1kFn/HGFkVaSe6ovaPuouFQrLhOO6WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogU2F0dXJkYXksIEF1Z3VzdCA5LCAyMDI1IDM6NDggQU0N
ClRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbdjcgMDMvMTFdIGRybS9hbWQvYW1kZ3B1OiBJbXBsZW1lbnQgTUVT
IHN1c3BlbmQvcmVzdW1lIGdhbmcgZnVuY3Rpb25hbGl0eSBmb3IgdjEyDQoNCk9uIFR1ZSwgQXVn
IDUsIDIwMjUgYXQgMTA6NTTigK9QTSBKZXNzZS5aaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4g
d3JvdGU6DQo+DQo+IFRoaXMgY29tbWl0IGltcGxlbWVudHMgdGhlIGFjdHVhbCBNRVMgKE1pY3Jv
IEVuZ2luZSBTY2hlZHVsZXIpIHN1c3BlbmQNCj4gYW5kIHJlc3VtZSBnYW5nIG9wZXJhdGlvbnMg
Zm9yIHZlcnNpb24gMTIgaGFyZHdhcmUuIFByZXZpb3VzbHkgdGhlc2UNCj4gZnVuY3Rpb25zIHdl
cmUganVzdCBzdHVicyByZXR1cm5pbmcgc3VjY2Vzcy4NCj4NCj4gdjI6IEFsd2F5cyB1c2UgQU1E
R1BVX01FU19TQ0hFRF9QSVBFDQo+DQoNCldoYXQgYWJvdXQgdGhlIE1FUyBpbXBsZW1lbnRhdGlv
biBmb3IgdjExPw0KDQp2MTEgYWxyZWFkeSBoYXMgdGhpcyBpbXBsZW1lbnRlZC4NCg0KVGhhbmtz
DQpKZXNzZQ0KDQpBbGV4DQoNCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2Uu
WmhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNf
djEyXzAuYyB8IDMyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gaW5kZXggNmIyMjI2MzBmM2ZhLi4yNGM2MTIz
OWIyNWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJf
MC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+IEBA
IC01NjcsMTMgKzU2Nyw0MSBAQCBzdGF0aWMgaW50IG1lc192MTJfMF91bm1hcF9sZWdhY3lfcXVl
dWUoc3RydWN0DQo+IGFtZGdwdV9tZXMgKm1lcywgIHN0YXRpYyBpbnQgbWVzX3YxMl8wX3N1c3Bl
bmRfZ2FuZyhzdHJ1Y3QgYW1kZ3B1X21lcyAqbWVzLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IG1lc19zdXNwZW5kX2dhbmdfaW5wdXQNCj4gKmlucHV0KSAgew0K
PiAtICAgICAgIHJldHVybiAwOw0KPiArICAgICAgIHVuaW9uIE1FU0FQSV9fU1VTUEVORCBtZXNf
c3VzcGVuZF9nYW5nX3BrdDsNCj4gKw0KPiArICAgICAgIG1lbXNldCgmbWVzX3N1c3BlbmRfZ2Fu
Z19wa3QsIDAsDQo+ICsgc2l6ZW9mKG1lc19zdXNwZW5kX2dhbmdfcGt0KSk7DQo+ICsNCj4gKyAg
ICAgICBtZXNfc3VzcGVuZF9nYW5nX3BrdC5oZWFkZXIudHlwZSA9IE1FU19BUElfVFlQRV9TQ0hF
RFVMRVI7DQo+ICsgICAgICAgbWVzX3N1c3BlbmRfZ2FuZ19wa3QuaGVhZGVyLm9wY29kZSA9IE1F
U19TQ0hfQVBJX1NVU1BFTkQ7DQo+ICsgICAgICAgbWVzX3N1c3BlbmRfZ2FuZ19wa3QuaGVhZGVy
LmR3c2l6ZSA9IEFQSV9GUkFNRV9TSVpFX0lOX0RXT1JEUzsNCj4gKw0KPiArICAgICAgIG1lc19z
dXNwZW5kX2dhbmdfcGt0LnN1c3BlbmRfYWxsX2dhbmdzID0gaW5wdXQtPnN1c3BlbmRfYWxsX2dh
bmdzOw0KPiArICAgICAgIG1lc19zdXNwZW5kX2dhbmdfcGt0LmdhbmdfY29udGV4dF9hZGRyID0g
aW5wdXQtPmdhbmdfY29udGV4dF9hZGRyOw0KPiArICAgICAgIG1lc19zdXNwZW5kX2dhbmdfcGt0
LnN1c3BlbmRfZmVuY2VfYWRkciA9IGlucHV0LT5zdXNwZW5kX2ZlbmNlX2FkZHI7DQo+ICsgICAg
ICAgbWVzX3N1c3BlbmRfZ2FuZ19wa3Quc3VzcGVuZF9mZW5jZV92YWx1ZSA9DQo+ICsgaW5wdXQt
PnN1c3BlbmRfZmVuY2VfdmFsdWU7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gbWVzX3YxMl8wX3N1
Ym1pdF9wa3RfYW5kX3BvbGxfY29tcGxldGlvbihtZXMsIEFNREdQVV9NRVNfU0NIRURfUElQRSwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgJm1lc19zdXNwZW5kX2dhbmdfcGt0LCBzaXplb2Yo
bWVzX3N1c3BlbmRfZ2FuZ19wa3QpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRv
Zih1bmlvbiBNRVNBUElfX1NVU1BFTkQsIGFwaV9zdGF0dXMpKTsNCj4gIH0NCj4NCj4gIHN0YXRp
YyBpbnQgbWVzX3YxMl8wX3Jlc3VtZV9nYW5nKHN0cnVjdCBhbWRncHVfbWVzICptZXMsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtZXNfcmVzdW1lX2dhbmdfaW5w
dXQgKmlucHV0KQ0KPiB7DQo+IC0gICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgdW5pb24gTUVT
QVBJX19SRVNVTUUgbWVzX3Jlc3VtZV9nYW5nX3BrdDsNCj4gKw0KPiArICAgICAgIG1lbXNldCgm
bWVzX3Jlc3VtZV9nYW5nX3BrdCwgMCwgc2l6ZW9mKG1lc19yZXN1bWVfZ2FuZ19wa3QpKTsNCj4g
Kw0KPiArICAgICAgIG1lc19yZXN1bWVfZ2FuZ19wa3QuaGVhZGVyLnR5cGUgPSBNRVNfQVBJX1RZ
UEVfU0NIRURVTEVSOw0KPiArICAgICAgIG1lc19yZXN1bWVfZ2FuZ19wa3QuaGVhZGVyLm9wY29k
ZSA9IE1FU19TQ0hfQVBJX1JFU1VNRTsNCj4gKyAgICAgICBtZXNfcmVzdW1lX2dhbmdfcGt0Lmhl
YWRlci5kd3NpemUgPSBBUElfRlJBTUVfU0laRV9JTl9EV09SRFM7DQo+ICsNCj4gKyAgICAgICBt
ZXNfcmVzdW1lX2dhbmdfcGt0LnJlc3VtZV9hbGxfZ2FuZ3MgPSBpbnB1dC0+cmVzdW1lX2FsbF9n
YW5nczsNCj4gKyAgICAgICBtZXNfcmVzdW1lX2dhbmdfcGt0LmdhbmdfY29udGV4dF9hZGRyID0N
Cj4gKyBpbnB1dC0+Z2FuZ19jb250ZXh0X2FkZHI7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gbWVz
X3YxMl8wX3N1Ym1pdF9wa3RfYW5kX3BvbGxfY29tcGxldGlvbihtZXMsIEFNREdQVV9NRVNfU0NI
RURfUElQRSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgJm1lc19yZXN1bWVfZ2FuZ19wa3Qs
IHNpemVvZihtZXNfcmVzdW1lX2dhbmdfcGt0KSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
b2Zmc2V0b2YodW5pb24gTUVTQVBJX19SRVNVTUUsIGFwaV9zdGF0dXMpKTsNCj4gIH0NCj4NCj4g
IHN0YXRpYyBpbnQgbWVzX3YxMl8wX3F1ZXJ5X3NjaGVkX3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X21l
cyAqbWVzLCBpbnQNCj4gcGlwZSkNCj4gLS0NCj4gMi40OS4wDQo+DQo=
