Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA0C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 06:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7747010E598;
	Fri, 16 Aug 2024 06:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5IW2y63s";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C85310E3FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 06:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsOOctIyrRA3Onvg5rFejYINWzpUdhF5gfWI6NQ3EpHH+k+hUZvesPWCi7/pVA0hH5qjcUs2AKD78v4lJw6FmfN75QI/0oBX3squfkd1eIcYveSjpa5ZcJM1HnxgaPW5GtE2/H69sRoM2qD9tH1rrNFK7QKsBmUlC8JCvV/MT1KsvO8QFyQEv29SkMvOFd97IdQDOTh3pnpOoPbta7cnXvJ9cgXEfrMVrvi+z5oJKxiPK0eeEV6+r2cF+upMC0rLUv49WWbt1iaMelttf/ejx6q8zOrucOUQJte+KfSk1jW78dLlE6vKyV2h3svSp/DJUcQelPCoMHaV2XfUVMU9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHTAStnZRoOvOqqV5Z5GHIQQKOpXlQc6YZAbh7BMrY4=;
 b=WAKUqA0UHTNXpSW1UOXszWRG/J9kobo6DVqQtj1JM6R7+Z2jq+j1mcWqUkhWfRGN0UxRzFw/q3jm4eY8QR+FYJ0HRNisjMHNQY5UCXGLKf4Kzf1v8TcGBcGj9YntQH+L8Vl0gEOQsz6zLdpRHTP7fGn3lVS6ga1i3x+ry+WEnFZiqin5gbWV9czdVw+6T1qG3FiTd3Bj/i7G/XAMD8gO+Sb1gI3b5gZHVwWZkzMKKN48EUpLmM/CnZLrhMNayWL6utANproDPLmWqPzXCKVJlyYp4QNAYDgX6SS7XmDa5qCX/jKi5c53LiSy3dV+N6tjRpE1AYf8hxoIJtRIBa8Fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHTAStnZRoOvOqqV5Z5GHIQQKOpXlQc6YZAbh7BMrY4=;
 b=5IW2y63s3ViYw+HVCT5P6qPn0lT25LwfvMLFm0ndae/z3Zpm+PfLtY0hwKc7m59/fBKfHI0a06guOixUMahpyWq2xa7wv/2P/eLzmHj16RPeuF1LS+3mptX4io3PvUd5UyDnm9poj09wVc/kAJtPmRvcuyZIXHyCqRd+VRiwvis=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 06:36:01 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 06:36:01 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
Thread-Topic: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
Thread-Index: AQHa7we2tU++i7Ut3EaBHHrGEVd6bbIoer0AgADp8wA=
Date: Fri, 16 Aug 2024 06:36:01 +0000
Message-ID: <SA1PR12MB74425F710D53EAA007A062F2FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
 <20240815113836.399377-2-Trigger.Huang@amd.com>
 <CADnq5_NumwJ6ujpJERTF7gK7TAJMkG7MNMNgrtr3=k8pqYnBvg@mail.gmail.com>
In-Reply-To: <CADnq5_NumwJ6ujpJERTF7gK7TAJMkG7MNMNgrtr3=k8pqYnBvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8eef2a34-773f-4030-9d05-7e64764eb1aa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-16T05:58:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|SA0PR12MB7461:EE_
x-ms-office365-filtering-correlation-id: 1a489c57-0e84-4141-d351-08dcbdbdb21f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VjFGTDFLbGs1b3BwQUZMUUltVXh3d1VPOVNxSWJ3WS9hQlBVdmVPc2tRcTd1?=
 =?utf-8?B?enNGMWpvbDZVNVVFM1BRT3ZEc1VQa0Iza3JlMWFLaWk5Y0NPbHJHRGRyVFRw?=
 =?utf-8?B?ME5rZVBiT1VCcGxqdDIraFRIRHIyb2I5RDg4WEQvUFhzZnYyK0JXYktKSTN4?=
 =?utf-8?B?Tlk2cVRxZ1FKM014S1dwa3gvVDVHSHdFdk1mTTAxWXFiMXhTTnpYSzZUbzRD?=
 =?utf-8?B?cHJGSTVrTk1ZQWNWeUtqUWZrUEx5Q0FTUFZwVnpLQ0hkS2VZMmJ1R0krYTQw?=
 =?utf-8?B?K1RJRXBrYXlhODdQdUNYL3BOS05zMmJaclA2ekdVOFVnWk9KUW4xTlVSS25q?=
 =?utf-8?B?RXZXQnM0QXZMZ0w4SXRtZjgwVyszMVAyYnpqeVdLSWlSLzBkNnIxVDcyek9R?=
 =?utf-8?B?TEx2V1JXZUVjLzI3Z2E3VXRoTE1uSUdidVlSWjhzdlNGdURVWkl6VkJmMXJO?=
 =?utf-8?B?WG11UHFoeU94RVRVVGh5ajF0OStFbUhJUTA5VW5hdzdaVTV1QXhVV3Z4VzBk?=
 =?utf-8?B?TjVHbVZRaFl2akg3cGJqbU54Zk42Rm9tUDJHS1Z1aUg5UC9JN3FpL1I3SHBU?=
 =?utf-8?B?b21QdmllMkx3NWh1UjNhN1E3SHU5NFBxWmtmRGR3STJoaTFROW84cnZrbnU4?=
 =?utf-8?B?dDNMb29IamV6b3h0UlNzTkQvQmgvamZRWHJiaWVyanNpZVRDS2RhTDlEeXA2?=
 =?utf-8?B?YU4yNU52R0FGZWNMQnBXVVZSeVNITFpVR010Q1pKTVNCR2Y1V2R2eTloU0V4?=
 =?utf-8?B?RjBDdUlsOHYrUTRYcHBsZ3lXbW9iUHN4eXJZbENBZXp3V3QvVGt6WVQ2eW5H?=
 =?utf-8?B?KzU2dEsya0VQNWtUVlJGVTQzZ2phLy9ENlMwRkRwK0tZNzVzbnIxYkREc05T?=
 =?utf-8?B?aldOWVMzR3JVS1lpckp1a1JaQnkvV2NORG9uekdyUXduZU8vKzZXd29mWjRj?=
 =?utf-8?B?clFiVVR3WVNnSTV1cHg4bktMZXFPL082TXBYYjBpWEJUNWJRa1N2ZWQ5K2xj?=
 =?utf-8?B?S3A0YlB5NHZHRk9EODlIRXdaTFVoT1diSjlWMytucHpSci9JclFvVXZZZ0VU?=
 =?utf-8?B?U0JHc0JTZ2wvdXQrQ2ViM0pzWmRQZG5rdGZxaTc5V0ZyTHVuK3REaVlsNE5N?=
 =?utf-8?B?MURPS3hnMlJoZ01kUXlSSGpHSmkxOXhoSHNIejh3VDFKWVVZUWxkRk9icVVP?=
 =?utf-8?B?dUduTVpOVzg0NXBVczNBNDdkL1dpV2VoVXVIbGloZ28wVzNzbkdDY1c1Q2ZG?=
 =?utf-8?B?N1cwWEUwZ21HNHlsV05BRHR0THFzcnJZbk8xTXlqR2FYeWpCU1lSSjVPNmVk?=
 =?utf-8?B?VnhsZ1hvOWlTSFg5VUZYV1l3RmVzckI4M1h5bkh1S21vRFJBWFMxZEJ0L2cy?=
 =?utf-8?B?MXV0dUJ4a2wwUEpJcGhqbkhYQ05uY1lxVEg4QzlLOUR5YStuQ2RBS0xaaWZL?=
 =?utf-8?B?TEZtRTRoTUowaGhOalBxZWNBM24wR00xRW8xRmV0RGVmT0NEM1pqYkNnMk9J?=
 =?utf-8?B?UkNaZlhnWjVrSDVFSGR1V1JOZW1tWkJDbkt3d3EwYUVzbFI5QWpOODhzY1Jy?=
 =?utf-8?B?azNQakZFN2hHcDFTYnl1aHZZWkVIN28wWDh5a2FmU0NKUlcxZEJEL0ZHY2VZ?=
 =?utf-8?B?MG9mNlY1NUs0M202dnFXbVo3MkJBelEvcTM5blZGb3hiQUtCeEJwR05pL096?=
 =?utf-8?B?Q011eVhVUy81SklGRG1QdHNJUHhOMnlXd0lQQmZJMWR3RGVFTXQ4WCtrTkI1?=
 =?utf-8?B?VVM1bXl6eXlyVnk5TllRdllkeVhQNXFOQ3VSNmF2VVA2VXV3K1NJTGk1aHhm?=
 =?utf-8?B?WFZNNFNEWUVNakQ0RGEzL2JsUStMSTVVUVhnMUllTWRseG9YaFZlc1ozVmJz?=
 =?utf-8?B?VGVEclRnUW54WnFHRmJkOFhoajlWaW5icHMxcjlaUkRmd3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mzcva1J1VWUxcjVzRDczeGFPNTVVcjVvTGZESytsVVR5OW4yRTF3dWltN05o?=
 =?utf-8?B?Y01uNzIrbTF0clJudHZEeFZkWlVHR21wNkJFYWtzaUlQZTQ2dllEMlNRd3hx?=
 =?utf-8?B?bzBuWXdKbkNaNmViWWQ1UEVZNVJZaCtMVlZ1dVVrdHBDVVo3bS9qYTArdTU5?=
 =?utf-8?B?Q1BmeThzaVpXNXlrc1BFUTJEZjI4VWRkbkJXL2dENXdKL1NlYVdQUlZTTExJ?=
 =?utf-8?B?QkFEWHZhYlJINkNVTk5NN1VlYWluYnZ3RW1yT2VDYytrVGU2TWdDZ2pQWnlk?=
 =?utf-8?B?UnFPWkhEQkFEQ0IrcW9uSWFRYjExRGxwQ2pNZmFIektzRXd4RlRUaEozYlVD?=
 =?utf-8?B?Z3pvM250dXdnRDdkVm50MW1DVWZycFhkUFBBV1F1WkgwenhPbzRBMVdoMTA5?=
 =?utf-8?B?ck9BV0ZQdUNYcGM2QVVNblR1aUhCQmpQZnhDVEFkM21QRlVlcFBDRFpJU0xO?=
 =?utf-8?B?UEtQeENVMEJXcDBrT2RyRVY4d0RRR2k1Q3orRlhnR2szVXJLUE0rYjZHeWY5?=
 =?utf-8?B?enBNbkxQTFpwL0Z4SkpWVTJBV3AvdWppNzB0MUpRWXhqU0tWVXI4MDg3SkZw?=
 =?utf-8?B?ZlJDSStJRW9ZMmxQYWRXTHkvWnpxM2RJT293ZkFXMDNjN2I0bG5LWlJCazRC?=
 =?utf-8?B?UFZnaklZZ2ZabVZLNm1DY1h5RGphR0x4U0ZnMmJHUmNxRVZRb0RRcDZSNEht?=
 =?utf-8?B?K0duU05hTUFEa1BPUURCcW5STnpiMGh6MG1KelFqK2pnMmpuTUZUK0VxYTNX?=
 =?utf-8?B?NE1hTUVLOFo5bVVaSmJIcm1oRlBvclJiSDNrdUcyVThWTTlzS2w3NXN4UDRF?=
 =?utf-8?B?dkxBeUxsSk9oUWE2Q1NESlZzdUE5ZG5WOEYwUDFwNS9JamQrTmd4NEhGcWty?=
 =?utf-8?B?OHZmZDRWdG5QS1RvTUF5dGdIbWlMQWdXVXl0QzN2c2poZWFpQ2JXeHB0ZU1y?=
 =?utf-8?B?OWlUWlR1YUpRYTAwUnFXM3lWWFI2VVgyV05CdFdZc05OUXFlQlZpaW5zZjdP?=
 =?utf-8?B?RllaQmVobktGWTNIZi9nNU8xODUwYjRycEVlYkhmY2RGcTQ5U3crQ2J2c0JG?=
 =?utf-8?B?TmU4S3A1SkR3dHplRU5lejBMdmR5bmtRdGt6SDZrVW4vQU03UjBTbW5RNHBO?=
 =?utf-8?B?ay91QXB5YWVQckNKeUw1cHBKYkZsMjZPUWJoRkdWZ3Y3NEZkaFF0c1VHK3Ev?=
 =?utf-8?B?MVFxb2lIc01hY21xN1RwMndIQWNSQ0grNWN1NU8rMVJYb1M5akdOeStyWkFv?=
 =?utf-8?B?R3VOWDFMM3c0Q0R5ajVNdU1DRm5TQ0pwUXhnUEd4dDdaUCtTZURNcFRZZXQx?=
 =?utf-8?B?M2prcDN1cVdnNDhGMVVGLzFpb2FTVlE5b1Fvc2J5anVuUm1wODlYRkVqY2ZO?=
 =?utf-8?B?M1I0TlhKSGRHVnJZNFpDZzNKUDRYWWR6U1A1UGN2NFcrcUdXc3NMWmxqWlo4?=
 =?utf-8?B?NGQrczVEN29EWGVTd0VMQ1cyWUc5SUcrS2w4ckEwS3JtZ2hNamp1Q2hWNlp3?=
 =?utf-8?B?MHRSNUgyZ1puZnl6MWxTbmVncmN2dTRsaXduNnl2RjROelpYOTdSbjVNT0NW?=
 =?utf-8?B?d0E3QXFtanB1NzZXYTdJeXR3TVFWbXJPUTJqQSthZEFjcFVPek5nNmllaWs0?=
 =?utf-8?B?S2NwV3ZFS1hmdnZsZUxoZjN1RjhsV1gwaFJEQU95a0U1UlBqREp4NkgrOWYv?=
 =?utf-8?B?R0RSVFJsaklpazNBVm8zYTREUG5ZMlVvbmgvSEM1Z0pqaVBUbkpyL21scjkv?=
 =?utf-8?B?blBPdjF4SGFTdW9lUG1tOVdWSUhGb3Z1YXNQbDFKeG15THJYZUhYNWc3MEEr?=
 =?utf-8?B?dXVQS2NlcndoaS83bGlNb3ZtSnAvNEk5OFhnYndCSzNZWkhjcmRvbXByWlBw?=
 =?utf-8?B?THNleUM5cE83UWVoRU0xWmxMSjMyQ3VFdTYrSVJqeWxJNFF2bVgwRHZIQjR3?=
 =?utf-8?B?QVM5NGdUaEVuT3cvL2xKNitsUEJmeDk4d3BLYmI5YUJsSEoxbVNOSkpkVlVO?=
 =?utf-8?B?SnNsYS9BbWFlUGorbVJuRzNPLzdMMG5wZmFoQzU4UXU5L3lleVRxV2dKWGRw?=
 =?utf-8?B?WHdiem9idWRURmV2WEhLdTgxY2VGRGoyMSt3WDArMkl5M3ZIYkF0YnVwUkpq?=
 =?utf-8?Q?KMJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a489c57-0e84-4141-d351-08dcbdbdb21f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 06:36:01.4404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52TD5MFsWJWq1e4e4/iCdkbTj3Z85SYmUb04w0HuugLRFYIXKFeEmZ1WzLcjw++vhvcKm3mjSF+sXH105yWGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgMTI6
MDIgQU0NCj4gVG86IEh1YW5nLCBUcmlnZ2VyIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+DQo+IENj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hh
dHJpQGFtZC5jb20+Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBBZGQgZ3B1X2Nv
cmVkdW1wIHBhcmFtZXRlcg0KPg0KPiBPbiBUaHUsIEF1ZyAxNSwgMjAyNCBhdCA3OjM54oCvQU0g
PFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBUcmlnZ2VyIEh1
YW5nIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+DQo+ID4NCj4gPiBBZGQgbmV3IHNlcGFyYXRlIHBh
cmFtZXRlciB0byBjb250cm9sIEdQVSBjb3JlZHVtcCBwcm9jZWR1cmUuIFRoaXMgY2FuDQo+ID4g
YmUgdXNlZCB0byBkZWNvdXBsZSB0aGUgY29yZWR1bXAgcHJvY2VkdXJlIGZyb20gZ3B1IHJlY292
ZXJ5IHByb2NlZHVyZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHJpZ2dlciBIdWFuZyA8VHJp
Z2dlci5IdWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHUuaCAgICAgfCAxICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jIHwgOCArKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+
IGluZGV4IDkzN2RlMjFhNzE0Mi4uNGRkNDY1YWQxNGFmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiBAQCAtMjAxLDYgKzIwMSw3IEBAIGV4dGVybiB1aW50
IGFtZGdwdV9mb3JjZV9sb25nX3RyYWluaW5nOyAgZXh0ZXJuDQo+ID4gaW50IGFtZGdwdV9sYnB3
OyAgZXh0ZXJuIGludCBhbWRncHVfY29tcHV0ZV9tdWx0aXBpcGU7ICBleHRlcm4gaW50DQo+ID4g
YW1kZ3B1X2dwdV9yZWNvdmVyeTsNCj4gPiArZXh0ZXJuIGludCBhbWRncHVfZ3B1X2NvcmVkdW1w
Ow0KPiA+ICBleHRlcm4gaW50IGFtZGdwdV9lbXVfbW9kZTsNCj4gPiAgZXh0ZXJuIHVpbnQgYW1k
Z3B1X3NtdV9tZW1vcnlfcG9vbF9zaXplOyAgZXh0ZXJuIGludA0KPiA+IGFtZGdwdV9zbXVfcHB0
YWJsZV9pZDsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMN
Cj4gPiBpbmRleCBiOTUyOTk0OGYyYjIuLmM1ZDM1NzQyMDIzNiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBAQCAtMTc4LDYgKzE3OCw3IEBA
IHVpbnQgYW1kZ3B1X2ZvcmNlX2xvbmdfdHJhaW5pbmc7ICBpbnQNCj4gYW1kZ3B1X2xicHcNCj4g
PiA9IC0xOyAgaW50IGFtZGdwdV9jb21wdXRlX211bHRpcGlwZSA9IC0xOyAgaW50IGFtZGdwdV9n
cHVfcmVjb3ZlcnkgPQ0KPiA+IC0xOyAvKiBhdXRvICovDQo+ID4gK2ludCBhbWRncHVfZ3B1X2Nv
cmVkdW1wOw0KPiA+ICBpbnQgYW1kZ3B1X2VtdV9tb2RlOw0KPiA+ICB1aW50IGFtZGdwdV9zbXVf
bWVtb3J5X3Bvb2xfc2l6ZTsNCj4gPiAgaW50IGFtZGdwdV9zbXVfcHB0YWJsZV9pZCA9IC0xOw0K
PiA+IEBAIC01NTYsNiArNTU3LDEzIEBAIG1vZHVsZV9wYXJhbV9uYW1lZChjb21wdXRlX211bHRp
cGlwZSwNCj4gPiBhbWRncHVfY29tcHV0ZV9tdWx0aXBpcGUsIGludCwgMDQ0NCk7DQo+IE1PRFVM
RV9QQVJNX0RFU0MoZ3B1X3JlY292ZXJ5LA0KPiA+ICJFbmFibGUgR1BVIHJlY292ZXJ5IG1lY2hh
bmlzbSwgKDEgPSBlbmFibGUsIDAgPSBkaXNhYmxlLCAtMSA9DQo+ID4gYXV0bykiKTsgIG1vZHVs
ZV9wYXJhbV9uYW1lZChncHVfcmVjb3ZlcnksIGFtZGdwdV9ncHVfcmVjb3ZlcnksIGludCwNCj4g
PiAwNDQ0KTsNCj4gPg0KPiA+ICsvKioNCj4gPiArICogRE9DOiBncHVfY29yZWR1bXAgKGludCkN
Cj4gPiArICogU2V0IHRvIGVuYWJsZSBHUFUgY29yZWR1bXAgbWVjaGFuaXNtICgxID0gZW5hYmxl
LCAwID0gZGlzYWJsZSkuDQo+ID4gK1RoZSBkZWZhdWx0IGlzIDAgICovIE1PRFVMRV9QQVJNX0RF
U0MoZ3B1X2NvcmVkdW1wLCAiRW5hYmxlIEdQVQ0KPiA+ICtjb3JlZHVtcCBtZWNoYW5pc20sICgx
ID0gZW5hYmxlLCAwID0gZGlzYWJsZSAoZGVmYXVsdCkpIik7DQo+ID4gK21vZHVsZV9wYXJhbV9u
YW1lZChncHVfY29yZWR1bXAsIGFtZGdwdV9ncHVfY29yZWR1bXAsIGludCwNCj4gMDQ0NCk7DQo+
DQo+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhIHNlcGFyYXRlIHBhcmFtZXRlciBmb3IgdGhpcywg
YWx0aG91Z2ggaWYgd2UgZG8sIHRoaXMNCj4gd291bGQgbmVlZCB0byBiZSBlbmFibGVkIGJ5IGRl
ZmF1bHQuICBJZiBpdCBuZWVkcyB0byBiZSBkZWNvdXBsZWQgZnJvbSByZXNldCwNCj4gdGhhdCdz
IGZpbmUsIGJ1dCBJIGRvbid0IHNlZSB0aGUgbmVlZCBmb3IgYSBzZXBhcmF0ZSBrbm9iLg0KPg0K
PiBBbGV4DQoNCkhpIEFsZXgsDQpJdCBpcyBmaW5lIHRvIGVuYWJsZSBpdCBieSBkZWZhdWx0DQpU
aGVyZSBhcmUgc2V2ZXJhbCBhcHBsaWNhdGlvbiBzY2VuYXJpb3MgdGhhdCBJIGNhbiB0aGluayBv
Zi4NCiAgICAgICAgMSwgQ3VzdG9tZXIgbWF5IG5lZWQgdG8gZG8gdGhlIGNvcmUgZHVtcCB3aXRo
IGdwdV9yZWNvdmVyeSBkaXNhYmxlZC4gVGhpcyBjYW4gYmUgdXNlZCBmb3IgR1BVIGhhbmcgZGVi
dWcNCiAgICAgICAgMiwgQ3VzdG9tZXIgbWF5IG5lZWQgdG8gZGlzYWJsZSB0aGUgY29yZSBkdW1w
IHdpdGggZ3B1X3JlY292ZXJ5IGVuYWJsZWQuIFRoaXMgY2FuIGJlIHVzZWQgZm9yIHF1aWNrIEdQ
VSByZWNvdmVyeSwgZXNwZWNpYWxseSBmb3Igc29tZSBsaWdodHdlaWdodCBoYW5ncyB0aGF0IGNh
biBiZSBwcm9jZXNzZWQgYnkgc29mdCByZWNvdmVyeSBvciBwZXIgcmluZyByZXNldC4NCiAgICAg
ICAgMywgQ3VzdG9tZXIgbWF5IG5lZWQgdG8gZW5hYmxlIHRoZSBjb3JlIGR1bXAgd2l0aCBncHVf
cmVjb3ZlcnkgZW5hYmxlZC4gVGhpcyBjYW4gYmUgdXNlZCBmb3IgR1BVIHJlY292ZXJ5IGJ1dCBy
ZWNvcmQgdGhlIGNvcmUgZHVtcCBmb3IgZnVydGhlciBjaGVjayBpbiBzdHJlc3MgdGVzdCBvciBz
eXN0ZW0gaGVhbHRoIGNoZWNrLg0KSXQgc2VlbXMgbm90IGVhc3kgdG8gc3VwcG9ydCBhbGwgdGhl
IHNjZW5hcmlvcyBieSBvbmx5IHVzaW5nIGFtZGdwdV9ncHVfY29yZWR1bXAsIHJpZ2h0Pw0KDQpS
ZWdhcmRzLA0KVHJpZ2dlcg0KPg0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIERPQzogZW11X21v
ZGUgKGludCkNCj4gPiAgICogU2V0IHZhbHVlIDEgdG8gZW5hYmxlIGVtdWxhdGlvbiBtb2RlLiBU
aGlzIGlzIG9ubHkgbmVlZGVkIHdoZW4gcnVubmluZw0KPiBvbiBhbiBlbXVsYXRvci4gVGhlIGRl
ZmF1bHQgaXMgMCAoZGlzYWJsZWQpLg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
