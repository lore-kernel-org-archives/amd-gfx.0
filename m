Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E42BCCD184
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 01:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42D410E06A;
	Mon, 13 Oct 2025 01:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tC2WHrpR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC3010E06A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 01:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKDnwwF+MtbBbNbs9Yh5VLPzHJnL/6XS56SRsFGH/PXAeinXnSlwH14UMziIar1opQ8nzfIfYa6r7BXGhQplxRU80LPcD6M/zH21Pm6pt0OpGszdLjDMHpLdBybU8qUoSNRdI96ULpAaHSVF+TXDG1c96tZbrB6ytCvygwFF6qKmGkzFrQLr8YcwEkU8TSHz2a6zKIZlUHVlqPov1o8q36rMSlDW/Penr5H70S25sLYjUt0WasAgjztAbDEe7cNmbAfwcHxEpYdPINSfoS0jWH9mi5lrWGHcTADAdZCbIkUwPw05iSRILjT3xe9YNPAlOWrbf5zhe4IAFiILUD/fPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afn5Pf7iqyiJJWCZcK/v2ybhNtAVRHi8L40wr28FRqw=;
 b=sEf+hqkJ/KUodNh4c/hOXiPFkAHLVu0AHyMyzkiTXWVJZKYqr8g5SZoDGLsTsJmziG2S7+CXO1MtSmygMiqKEPJJb03FJDHrjhRrdi7TsUXEHiQH6pc9yo/dCmyFRAiRqrhah8e+iomdCDlAJH6nqllSIWZbUoFVdxkEA1nsCQMZXIY8iqp4eTx9QNOYLmgrmXW3mAR0DHXtqcZb+2K1SyoUVRTGfcwP/0A3qgnBq8XTBxGxKxH6wcDfaMRhOWoXx/r90ZmB1FqYQlLhTlWVG1paGzWxCEwZYHkFIkKXRSdv2oiH3n2ACKFZLJQydp5qDq1H5EPE1RhhvWaaI25utQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afn5Pf7iqyiJJWCZcK/v2ybhNtAVRHi8L40wr28FRqw=;
 b=tC2WHrpRbjuyI9tZHO6GwjBz71Y/gnshxueXwnt4ubWtHA8rH7Xm9+kiBJvlSupn/ZJSWe8Ccc3p2N3MFImpQB7OWpANkf+pB8qZAgy8jYjZ1ydAROm7lWbcBuJV5OZ8AhXfBlErh1wsA843pb1J1XEyFUor0LixIsYbfRrBv5c=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:30:31 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9203.007; Mon, 13 Oct 2025
 01:30:30 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix NULL pointer dereference in APU threshold
 calculation
Thread-Topic: [PATCH] drm/amdgpu: Fix NULL pointer dereference in APU
 threshold calculation
Thread-Index: AQHcOppA+x6cTOudgE+6W9SfivqK1LS/MhkAgAAaUeA=
Date: Mon, 13 Oct 2025 01:30:30 +0000
Message-ID: <DM4PR12MB51520EFEAF81953AAF57F2EEE3EAA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251011103120.1262736-1-Jesse.Zhang@amd.com>
 <9ad81657-4eea-d416-9c52-d62a7c4fdb50@amd.com>
In-Reply-To: <9ad81657-4eea-d416-9c52-d62a7c4fdb50@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T01:29:25.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB7643:EE_
x-ms-office365-filtering-correlation-id: ad2cd89c-dec3-4d02-df7b-08de09f818e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?L25XYXVTeU1IZzVTNEVkd1AxYlNHREtocktvVVlFMDNIY1pGZUxLcXFzVit4?=
 =?utf-8?B?VkROdDRHbUVpQjhIYmsvYUhlbEhJU1dzZ2tEblRBYnB6clhXa0x5OC9VL3lQ?=
 =?utf-8?B?QXlXcXZMVE9HMk5PZ3JrUlhRVnhiQldUOFFpdEZzRWJlN3cxRzVlWkFaSXF5?=
 =?utf-8?B?Si9zazNBbU0vSkJNYXc2L2lDdVVGWW1EcUI4QU9Hb24wVGJsc0xxcDlyV09s?=
 =?utf-8?B?WCtwcWo0bHUrdUd6cllLMmo4bjZ3dUs0enhDMjIxU3NNcnhqdzlLL0Y1L2ZS?=
 =?utf-8?B?SEFSSXZ6bmY0WkR1STducE5KRVc0ZVkwT1UxaGxvbkFxdXg2b2NvaldKdnFk?=
 =?utf-8?B?ZUxLMnptSjhLRFkwM2dmNHhHbE51V1cwWlY3UXF0YTZMVlJHQjJoVFU4Tmtp?=
 =?utf-8?B?eGp2NFN5amlGZllhOXBlYStmNkNTRzU1dWxsSTI4dk9KM0NSVVJieDRPWFgv?=
 =?utf-8?B?bVZoMWdmMGJlTlZJaWlvTjIyTEpDbndLZG5yYzFzN0FXTUhHYm1xZzBKbVRE?=
 =?utf-8?B?US84TEtUY3JPWTdjeHZTOHRGbmFkSEYrUEtxblVYYVYwT3J4anBtRnFEY0sz?=
 =?utf-8?B?MmJLM1hFVzk5b1dhdnB4cWUrc01SNFV2VXhNR28rL0RDalZ4aEVqWVM4Nzg4?=
 =?utf-8?B?RG14aW5SOURxYkFwalZGSXNkQnAzaFhSM1hHeG8xdDZGUnB0dFVaeE1HTWdM?=
 =?utf-8?B?bEZhTTJQdCt3SW1xOHdVZlNESVpoSXNLT3RJeGpSVVBxQWlGVmdReUUxRDd5?=
 =?utf-8?B?aTN3WEVnN2VNUmYraFk5MTJtSjljN1NzSnNkcmUzMmExQng3c3hDWVpNTkZZ?=
 =?utf-8?B?VXAwbmxON3F1UHI4dW1PMXgzWHRzWDdKOVlPc3VxREpFYTNqNFpOOTVFa3My?=
 =?utf-8?B?SyticXowQUZIakpiNHpDS0FJTjgwNHdPOSt2MmErWGJVM0N6R2pEcmU2dGFr?=
 =?utf-8?B?U2xJbXlEK0FiRVdnSDBicFRlNXNUVlN6My8wMWY2QjZBZktaRnkvM1RuRDlw?=
 =?utf-8?B?QVh4Z2ZCblo3VmNYQ2tiOE9DbnRwbXFKNkFnMlJYU1JrUFdOeXJKMTFTOGJG?=
 =?utf-8?B?dXBWbmYrWWl3cnI5WEUreTlaQUl6Y3M2MU55dWNOeTkraVBjNTdZTmJNWG1p?=
 =?utf-8?B?NGNFN2k3WWdRSTNsRXFJSURyVE5VS2UwUW1xM3JFMEtkdDYxTk42aXc5N1NF?=
 =?utf-8?B?Wm5lakl1T0NONVp6WE5jRlRuSDdtaHBXSGp1Y08ycUk5RGJ2cDFMMjNkNC9o?=
 =?utf-8?B?MEY2Y2N3WTNJazhqVmxLdUZhYjZkSTErZlprNERRaERWNExkLzZLbTF0d2Yv?=
 =?utf-8?B?R0NCN2dHTXVrelIwUk0xRDc2QmdRY2N0SnU1WHZEODczdzVadWJMMGhRYkYv?=
 =?utf-8?B?R291aG16am0waDZ0azZOR0djeEY1NHorbHdFSlRnY1Y0cFR4RWx6UjhYZnhZ?=
 =?utf-8?B?UURpRklkd3hWaDd3U3VEN1o3WVFZbDNkZ1Y2SDZmVjJ5encrWlM1L2lyaE1q?=
 =?utf-8?B?YzNkVm5JRXJvMUYzL0pwRlA3S3lqOWxPdjNOZkhmSFlJcGdmeUpJSkNGaDBs?=
 =?utf-8?B?bjZxV0ZEcFV6a29nTFlRSGZ1MGlrU2Vkb29kK3RUazkvRzF4c1phZEVmek1W?=
 =?utf-8?B?SXdxaXpVcTM5SlNqc3BWNVYyYlVqZGpRTEdUUFJEdy9ndkRPaVZSNE5qTU5O?=
 =?utf-8?B?RjBGOHd3QVNxUjAyTCtuc1JPM2RCYkxTc3ZQbjgwSzBkZWlUS05UMGRnODJj?=
 =?utf-8?B?Y2NMT1Y1dGtXWkVOcHNoODBtbGpsaXp4VTZ3SVdIcENrNW9DSzc1T0VBM3Nh?=
 =?utf-8?B?QVFZVXVxZ1pZVzNTVm8weVhxMENJdmt2MGhlSS9mTzhydHlLVU4yVjJTZ0x0?=
 =?utf-8?B?ajUvOGE4dEhPWU9wRFdrMjVqUWdMTk9wZzgwYkwzT2tqVEFLbzY2ZkZzTG9h?=
 =?utf-8?B?ZHMrS05xdUhTdm5idlNoOVNMK3MrOStPaENpVElCRXcwQU5MbktrdXZaYmp3?=
 =?utf-8?B?UWhTRFZsTllQek1LMUxOaGI4aFlVUVdNWXRnYjJSNUoxelhmZDVod3RtN0lZ?=
 =?utf-8?Q?AZPvlf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzByLzJ3RDl6UkZ0UlU5Y1BUY2o3QzE4QXROSTBteitWWXdkbG1vQjl2UEEy?=
 =?utf-8?B?TzVCd1RYY0t1S0FlYmRxNlEzR0tsTWlvU2xuVlVaejhRR3k4cnhqRmM1cFVR?=
 =?utf-8?B?WHA0cXFrR0p6blVUdWhZUE9KeDRQQW8yS25wRTdCdWU4cFlGSU9jOERLOWIv?=
 =?utf-8?B?Z1RldUZYSExKaitieEJhRWNXaUpvUXhTKyt6VWdIZ0tBQ3NsdFF1VkoyUHNW?=
 =?utf-8?B?TnNNMGdDVUhCdDAxZm5ON1RKdURVeFczSFE3SjRMeEQ3S2Ixcjk0SFUzWWpY?=
 =?utf-8?B?T0o4MnFQa3ZOOFA4Sk5zaVRKWUNOUlJWSlFNYjBlOFNVVFE0R3lDNDhWZndQ?=
 =?utf-8?B?UVNSM1gySFVyc0laYVEybmxIRG1uem4wQUdwOHFDMU9WU3JHY2l3Zk5UNHJO?=
 =?utf-8?B?dllJY2dEdlo2WlRMR242M000VjRXMWo4NDZ0M1JZRzc2N21VUlhjSWRRdFNq?=
 =?utf-8?B?dXo5MnliUTU1QnBnVXlrMWRUTUlQc1lxK0haSnpWMmg4a0tQazN2TjhiZGRk?=
 =?utf-8?B?ZVhZSXNXNmlxU0dLaVZGV0NoeEZ6SFl6b0pMMXJGWjlHdHZtM3kzck4vc3JG?=
 =?utf-8?B?eU1aUE1GOVFGSUxjRklEbFd5TmVWQkFzL2lIckI1cVNCUTU1WnQrVlh6c1U2?=
 =?utf-8?B?cUd2TUQ0TmZHVGVMSWtxajBCSmRETmd1N3FWQnpzUDg2ZnBEdnVRdXZydnd5?=
 =?utf-8?B?OXJNZkF0NkVETTFJcm9WdWpOcllEVStwZTN3dEpTQUtCclU3c0VXUnJIZVJC?=
 =?utf-8?B?NFZNTVE5OTdTUk5FK0E0Y2libFNTZW1XUndLZHBTT3lJMGJ3dGhIMWcrbUt1?=
 =?utf-8?B?SlVNVnA3SWczQk9SM1Z0SVMwQjd6TVpUNE01Zk9Salpwai93TENHTlZzajZN?=
 =?utf-8?B?SVQxSWpWQ1JadXVCRzArSkdEa2lScGVEOE9vQmJuN3oyU0E4dlhCWDdqaVNS?=
 =?utf-8?B?K2RJSUdkelhXWW9xMHhCSFBwZE50WjhnYmJ4SmxZQ0diMGJ5clovOEZnYXpD?=
 =?utf-8?B?YVBHVk1nUFZ6WTJqZEJkcm44THI2S1Q0L1I5Ny9EQm1BMlMzQkdGZVJZUVBo?=
 =?utf-8?B?c0xnTndlemVKQTBEVzAvbUZXdFhOYkprSzlQcno5cDFET3R3ejByd1BMODc4?=
 =?utf-8?B?b09KSTA3YVhnclNxS0lIdVlKMTd2NWtIYXdSdTJKc1ZCZ2dkcVdkeGNHSi9H?=
 =?utf-8?B?NHBXb0JwT09jcjExWHEwRTQzMmdYQmZralBUQk82bVp4SlJXVTl6NGlCUVQ3?=
 =?utf-8?B?WHdOK2N0VU1odVFlRXZjVGhSYkxuNTFQMEo2NWtoUXJZRGxOTGc4Smt0M0RW?=
 =?utf-8?B?S2haOUFKZjBldnRrb3d4SmxYQ1lIZzdHQldVL3RPQUNiOFpEK0VibkFCckYr?=
 =?utf-8?B?VUlRTzE1THlYWlpYNUwyY2FXeVFja2xTMjc1TFNtOHVncW1OU05SeExWMUlo?=
 =?utf-8?B?ejFIUXMwNlhWT3dtK0h3dUxodnN4T3Y4YmdHc3pYZURsVlhnSXlzREFVV3BS?=
 =?utf-8?B?QjNNQUQ5aVd4SUJ1ODR1bzl5c2oyTXNZU2lVaG9QQnN0bmxOenZDVkdaWUZp?=
 =?utf-8?B?OEVzY2J5anhLc29VN3F2ajZSb3p0dnBiZmVNbEhwdk1QL2lhUVRQZnVBcVAw?=
 =?utf-8?B?TjlTSlR0OG50VStpZXJ3QnNrRGt3NlhjZGZpTzg4eGVNaE9vbEpESHhXU21V?=
 =?utf-8?B?QWJiT0sxT0hsekFnc3hHQk1obFBSNDNoaGRnZXp5dFJUZFlxQThIRUV0Kzd0?=
 =?utf-8?B?VlJWZ3N6QXZRWFVPT1hUUEhWWWhJRmx4WFpXTnVOQ3JlaEVTa1RYMTlrRGo5?=
 =?utf-8?B?YUJoL3JrZGJ5OFBxTjQyaklGY2w0MHhGdUxmdGE3bCtuRzRnT3cxQTZtLzFE?=
 =?utf-8?B?bDBwUGFTU2lLN3J4Ulp6ck1UbXhwTFp0NGwyRUZtYUs0b3hGZXY2WnhkQW0v?=
 =?utf-8?B?WUs0TzEySm1Qdm92UjZXOVV3bTMwY1VwZ253c0dpQ3ltSTV5Y3ovTWhlS2tG?=
 =?utf-8?B?eWV1bWpzSFp0V3dCajUrd3ZUbDVZQmVQem5YRjNkNzVES2NYaXFQeWIxcGVw?=
 =?utf-8?B?alRELzhxQXBRNTVRejkrekV1SXpPNnRQdGh1ODdza3N2V1lIcFdkZkZIZ3hp?=
 =?utf-8?Q?Qkis=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2cd89c-dec3-4d02-df7b-08de09f818e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 01:30:30.7285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sttgOlI7AiLFf8n5D5EEti5uYpS6XRP0lvefc55WSABzKeYdUYw0TYJE3n6JfBzk9QezIVaZWLrKZ9j7r3Jo7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZYW5nLCBQaGlsaXAgPFBo
aWxpcC5ZYW5nQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMywgMjAyNSA3OjU1
IEFNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIEFQVSB0aHJlc2hvbGQNCj4gY2FsY3VsYXRpb24NCj4N
Cj4NCj4gT24gMjAyNS0xMC0xMSAwNjozMCwgSmVzc2UuWmhhbmcgd3JvdGU6DQo+ID4gVGhlIGtl
cm5lbCBPT1BTIG9jY3VycyBkdWUgdG8gYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4NCj4g
PiBhbWR0dG1fcmVzb3VyY2VfbWFuYWdlcl91c2FnZSgpIHdoZW4gYWNjZXNzaW5nIHRoZQ0KPiA+
IHR0bV9yZXNvdXJjZV9tYW5hZ2VyIGxvY2ssIHNwZWNpZmljYWxseSBvbiBBUFUgZGV2aWNlczoN
Cj4gPg0KPiA+IFsgIDkxMS45NTQ2NDZdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSwgYWRkcmVzczoNCj4gPiAwMDAwMDAwMDAwMDAwOGY4IFsgIDkxMS45NjI0MzddICNQRjog
c3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsDQo+ID4gbW9kZSBbICA5MTIuMDA3MDQ1
XSBSSVA6IDAwMTA6X3Jhd19zcGluX2xvY2srMHgxZS8weDQwIFsgIDkxMi4xMDUxNTFdDQo+ID4g
YW1kdHRtX3Jlc291cmNlX21hbmFnZXJfdXNhZ2UrMHgxZi8weDQwIFthbWR0dG1dIFsgIDkxMi4x
MTE1NzldDQo+ID4gYW1kZ3B1X2NzX3BhcnNlcl9ib3MuaXNyYS4wKzB4NTQzLzB4ODAwIFthbWRn
cHVdDQo+DQo+IEkganVzdCBub3RpY2VkIGFub3RoZXIgTlVMTCBwb2ludGVyIHJlZmVyZW5jZSBi
YWNrIHRyYWNlIGZyb20NCj4gYW1kdHRtX3Jlc291cmNlX21hbmFnZXJfdXNhZ2UsIHdoZW4gdXNp
bmcgcm9jbS1zbWkgb24gQVBVLCBtYXliZSBhZGQNCj4gTlVMTCBwb2ludGVyIG9yIGlzX2FwcF9h
cHUgY2hlY2sgaW5zaWRlIGFtZHR0bV9yZXNvdXJjZV9tYW5hZ2VyX3VzYWdlPw0KW1poYW5nLCBK
ZXNzZShKaWUpXSAgeWVzLCB3ZSBuZWVkIGl0IGFuZCB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2guIFRo
YW5rcyBQaGlsaXAuDQoNCj4NCj4gICBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDA4ZjgNCj4gICBDYWxsIFRyYWNlOg0KPiAgICBhbWR0
dG1fcmVzb3VyY2VfbWFuYWdlcl91c2FnZSsweDFmLzB4NDAgW2FtZHR0bV0NCj4gICAgYW1kZ3B1
X21lbV9pbmZvX3ZyYW1fdXNlZF9zaG93KzB4MWUvMHg0MCBbYW1kZ3B1XQ0KPiAgICBkZXZfYXR0
cl9zaG93KzB4MWQvMHg0MA0KPiAgICBrZXJuZnNfc2VxX3Nob3crMHgyNy8weDMwDQo+ICAgIHNl
cV9yZWFkX2l0ZXIrMHgxMjYvMHg0OTANCj4gICAga2VybmZzX2ZvcF9yZWFkX2l0ZXIrMHgxNTAv
MHgxZDANCj4gICAgbmV3X3N5bmNfcmVhZCsweDEwMS8weDE5MA0KPiAgICB2ZnNfcmVhZCsweDE0
Ny8weDFhMA0KPiAgICBrc3lzX3JlYWQrMHg2Ny8weGUwDQo+ICAgIF9feDY0X3N5c19yZWFkKzB4
MWEvMHgyMA0KPg0KPiBSZWdhcmRzLA0KPg0KPiBQaGlsaXANCj4NCj4gPiBUaGlzIGhhcHBlbnMg
YmVjYXVzZSBBUFUgZGV2aWNlcyAoYWRldi0+Z21jLmlzX2FwcF9hcHUpIGRvbid0DQo+ID4gaW5p
dGlhbGl6ZSB2cmFtX21nci5tYW5hZ2VyIChubyBkZWRpY2F0ZWQgVlJBTSksIGJ1dCB0aGUgY29k
ZSBzdGlsbA0KPiA+IGF0dGVtcHRlZCB0byBjYWxjdWxhdGUgbWVtb3J5IG1pZ3JhdGlvbiB0aHJl
c2hvbGRzIHVzaW5nIFZSQU0tc3BlY2lmaWMgbG9naWMuDQo+ID4NCj4gPiBGaXggdGhpcyBieToN
Cj4gPiAxLiBNZXJnaW5nIEFQVSBjaGVjayB3aXRoIHRoZSBleGlzdGluZyBiYW5kd2lkdGggY29u
dHJvbCBzdXBwb3J0IGNoZWNrIGluDQo+ID4gICAgIGFtZGdwdV9jc19nZXRfdGhyZXNob2xkX2Zv
cl9tb3ZlcygpDQo+ID4gMi4gUmV0dXJuaW5nIDAgdGhyZXNob2xkcyBpbW1lZGlhdGVseSBmb3Ig
QVBVIGRldmljZXMgdG8gc2tpcA0KPiA+IFZSQU0tcmVsYXRlZCBsb2dpYw0KPiA+DQo+ID4gVGhp
cyBwcmV2ZW50cyBhY2Nlc3NpbmcgdW5pbml0aWFsaXplZCB2cmFtX21nci5tYW5hZ2VyIG9uIEFQ
VXMgYW5kDQo+ID4gYXZvaWRzIHRoZSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gX3Jhd19z
cGluX2xvY2soKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxqZXNzZS56
aGFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMgfCAyICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2NzLmMNCj4gPiBpbmRleCA1ZjUxNWZkY2M3NzUuLmQ4MDQxNGIzMjAxNSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQo+ID4gQEAgLTcwOSw3ICs3
MDksNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfY3NfZ2V0X3RocmVzaG9sZF9mb3JfbW92ZXMoc3Ry
dWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAqLw0KPiA+ICAgICBjb25zdCBz
NjQgdXNfdXBwZXJfYm91bmQgPSAyMDAwMDA7DQo+ID4NCj4gPiAtICAgaWYgKCFhZGV2LT5tbV9z
dGF0cy5sb2cyX21heF9NQnBzKSB7DQo+ID4gKyAgIGlmICgoIWFkZXYtPm1tX3N0YXRzLmxvZzJf
bWF4X01CcHMpIHx8IGFkZXYtPmdtYy5pc19hcHBfYXB1KSB7DQo+ID4gICAgICAgICAgICAgKm1h
eF9ieXRlcyA9IDA7DQo+ID4gICAgICAgICAgICAgKm1heF92aXNfYnl0ZXMgPSAwOw0KPiA+ICAg
ICAgICAgICAgIHJldHVybjsNCg==
