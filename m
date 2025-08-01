Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6C1C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 15:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BBB10E8C6;
	Fri,  1 Aug 2025 15:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mnkvk66o";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA2310E8C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 15:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKPFq4M71YS9+xUzvpDAUIzVpa5Z72wwGBNoQ0v/a4r6SCIgLpCD4xMSv8xfPPhwoNcuyLxxtYobaE9H/0J0wxTSugnX5amnFCPDsXJQ//Ar+GR502+bVFCvLmnoCNGZ2xw7S1k64MjlqgWwI7hVVgNXgRtpzn3QcARr371ch5rbpy+omjeJNPtSZTRk/QKB0CcNdo3dB7op4rLVK3LljdyBztooT6Ib8uK7s/fNVMfB50jQJjiLUnh0zGgfZplwNkpkSv+BmG/o0sNJgPWbx217oFpLNbk4uTBZi2ZI39YC7Fk0DxcneiU1ZvR4r1pw6oBB9cXn4Rqg3nUlhsCW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lkgcY/Z88ziZYZ43aqfmZw0b96P6jaQLJV22dZArTM=;
 b=vskjjfevGtH6cQ+E8IFL4kqKi2OjQlFckzodfQCQ0f34QxdDEiN/XyqXTEvewHDBZ0StVvgCIhHji5yn4CeNKr5i/sbWgznc5AvfWATfqsNb4x3yaNtMPemlP8tGGiD6EB2sA4IPiVWaZK7CK5tSuFW+LVHsXX9qpjfNsPNsgOTdwcen/yZcFRrfauSWjZ/G+vExOdoGQWs4LrB6Tg61sKxACMbcmq7UiAOcZdmqAARVBwqDTPltgmvLF6ycDXv2FeGt7GsXn4aJ+45ZWxVoV91vg90182vbT2cWnVMCbyQ+yaW6+bvDFH+Y+cFrJaEC58gRO7gnTDp+ph5OZkmwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lkgcY/Z88ziZYZ43aqfmZw0b96P6jaQLJV22dZArTM=;
 b=Mnkvk66obVe94A8hyrIEpwiCQhdWjts9xcet/2XmZoLvHOLbtTWoEuyxVH0ypAC3mv1vs6JD/IFoERGWxIoBD8MrLGyUsRke9etqdm/aO6QeobF7XfAYpKXPvgSV5qUFCIjw0fqXcQ2JOcvLt03htvGALf1y3QU2+HzRJMLyWk8=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 15:40:30 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb%7]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 15:40:26 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Prevent hardware access in dpc state
Thread-Topic: [PATCH 3/3] drm/amdgpu: Prevent hardware access in dpc state
Thread-Index: AQHcAeJh0dsNnCMC+U2QMEybPXjbLbRN8LME
Date: Fri, 1 Aug 2025 15:40:26 +0000
Message-ID: <SJ0PR12MB6967A5322B8A8FF727314BAE9D26A@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20250731061408.1699369-1-lijo.lazar@amd.com>
 <20250731061408.1699369-3-lijo.lazar@amd.com>
In-Reply-To: <20250731061408.1699369-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-01T15:37:47.6359496Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|MW6PR12MB8733:EE_
x-ms-office365-filtering-correlation-id: f2062069-ced9-4318-f661-08ddd111bcad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?gb2312?B?cEZZZC9ZRGhsdHF4enZCa1M3TDczSHk2K1cwQzFKQ25QRjltOExMamttdzlH?=
 =?gb2312?B?eTFjWkNBT2hnZXRtWTVxYmV5SXM4YW96Um5EeUhmSnl0L1dQZnZiWlk3YmYr?=
 =?gb2312?B?bEI5UUxabjJKWkw3SXY0QlcvdXVZNXc2UFNXQ2F3bWNGRGF5dGZYRDJZQXBl?=
 =?gb2312?B?bElmTkh1WmZLQngreFlWWnMwcDA2Rm45RVU4SDhHWVNPajJ2NlVCaHl4bjl2?=
 =?gb2312?B?STBBeWU4UEU3YlBMWE5TV0I3TXJxUThKT0ZmNkpuY2t1bFFTQU5GVGQ0am1q?=
 =?gb2312?B?UDlZRG9XQThCd3FjNlJ1ejF6TnlLVlBLamJSVjZaWlF2OVRsTzBJWnR3Q0h0?=
 =?gb2312?B?SFp5MUxScDRaMGRrdzN2MmdxOFR5K1NCTXBlbjVUdFJldmc3dE02REtkblph?=
 =?gb2312?B?M1l2UWZ5MlRRcDkzWWdSZTJEK1A0dGVGeC8vMG9qMTNBYVI3UEtocjV2SndO?=
 =?gb2312?B?d1VrMlpGeFBwcUVkNVdPQ0gxTk51RkpQRFl4dXhSWk12aUNSTnRyNWpMNDgy?=
 =?gb2312?B?dmp0MWxvZy8raDYzbFludDMxbkI0ZHFhNTFEeFIrRGhCU1VZQ1h4K2UrUm5t?=
 =?gb2312?B?N3owVUcvaHIvQW13TEtRSzFTU2UyR0hiTjVOby9wZ29vOWlPQ1kwanhUVjJG?=
 =?gb2312?B?T2FtUVp2ZnRISHB4ZGVMUm5SYjBwOW80RXdiQVl2WXcra0tWdlpVZnpDWDk2?=
 =?gb2312?B?MSs5dDR5SVN3RG5KUHZHemR1QUM1Mi9KaVRDaEhYakl4VXRseFgvRWo4WlpU?=
 =?gb2312?B?UnpsbXd1NUJFRFBYZUZUQVYxNmFCMEFCRmcwdzlSblZxQ2F6eDYvTmMzMzEy?=
 =?gb2312?B?d1ZrZlJmQjd3NmV1ZE9oL0FMVlFheEV0cndiVFJkL0t1Y2NQRWdyM0s3YVY3?=
 =?gb2312?B?ZndrNlc2SzJXN0pLbzJBbmdYTm4wOHF6NlJ2bTdlVCtrLzNhVTdYeFBVMWha?=
 =?gb2312?B?TEZHeGIvTFRzczVEWlUrUy9tMlYwTkxjdjhpRy9XdnhDK2NoRHA1K3R4UW94?=
 =?gb2312?B?NnN4d09pVDVDV2JKTDkyaHQvekdSemExcThRWG5RakI0aVRBSWxlWkJzT1pv?=
 =?gb2312?B?NHhaUituWGVoWW1BWDVEWHhOSVB1ekE2aUNEY21TTmE2VkgxUlhOOXlsNUJi?=
 =?gb2312?B?TnphUnJVZHV0YUF3TUJ6MHZnTkxYVTJBNnc4c2VId0JoSHk0aTduTk8zTm9I?=
 =?gb2312?B?QUNLRDFFaGxEc1pSaFk3VG1MSjl0Y3dac1h1ZmNsZWdOV1gvUGkyelgrczcv?=
 =?gb2312?B?WENCcGg5UUdXSEx5YzhYR1JUTDVIbjBSa3dIcE5BODhxU1JKNXBtUW12VjAw?=
 =?gb2312?B?aVdZNFppckFENjM2YWxmUlhxdEdVekh4VWFjeVBGNUx3Q25xNExjbFZWOGZI?=
 =?gb2312?B?T3lCbmR6dlAvelBXTGdocmVNSTVEMDlBeUFoaDAvbGs3SEcwWFRnSmZnUTZC?=
 =?gb2312?B?bm5Hd2VORzBCb3FVYmFqUll5QjN3bXpuWEx5a0Q5RElZcXErZXRLdmhUVmJL?=
 =?gb2312?B?bGR2WlVablpWVGV2aDVreU9tY2FhbUNLRXIvSG01L04vcnV1anhYTnFWSFRL?=
 =?gb2312?B?MWpxQlU2MUsyRE9XbEdpemJqTmtQN1hnc2xWb0Z1N3dRR0ZVQlVBMkF2VVpa?=
 =?gb2312?B?dGl4UUVwbEVZd1pRTGhvbjUwY1NqQUlKVGdrL0ZuaDhZeE5XSU02MGdUS1Jj?=
 =?gb2312?B?d2JuZlNsUXhzaGhJWjZlMkkxSFFFaVp1SXRKb3MvTEZGbGw5RjMxNGFIUFg5?=
 =?gb2312?B?WUNJK1RlbnBoSU5VazJQMnhaa0ZyazVvUUtUNlpNUUpkRitRKzJMZnVQOWtj?=
 =?gb2312?B?cnFQVmNBSXVRak5CbkVIS2F6WmUxU3FtSURtWVVhMW95cGlrajFjK3o0K1Rh?=
 =?gb2312?B?L2xnOWVWWFI0ZWpVTXhnTkw0L2ZIN1F3cWlXRlNGRTlJSUhjZWVSMzhidVNS?=
 =?gb2312?B?N2RVY0pzd2FjYjJqUUFYYWMzSCtoeXBFZDhtZ2ltVTFEWm41VGJraHAxN0Rn?=
 =?gb2312?B?ZHVpNStlRzBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MENsY3c0dUkwWG1lMEE1dGxXYk9wMUpleUNoNTRqR2tKQkNHMmJPY2JhaVlW?=
 =?gb2312?B?aU8ybWx1T2JBb1JYdFZpclRrQnRVaE5nY1o3SWZnVGJhVTRhTGtOWlNPRFI2?=
 =?gb2312?B?VTA3aXhMYytKc3V6eHpwV0xYbkwrTFpuN09GSThFRS9icmlQUVZaWGRsdmts?=
 =?gb2312?B?c2VZMGhoUXZQRzkwdTdNc0VVYU41K0pUTUVLQnZpVzM4YnU0QXd0ZWVFQ1Nv?=
 =?gb2312?B?S1p5NWpoWjAvRE12djRjZmg1azVDWmF0ZTZXREdxSXBhUjlCck93VmlJR2pY?=
 =?gb2312?B?WDFudVlwWU5NR2ovTHo0dnl4UDVBM1oyZ29HaTIySGg2Z2srTjdFeDE1aEhW?=
 =?gb2312?B?UmJQbkJSSVNObGZMbEZPNmcrUlhlZ0FHQTNSWUhuTWo2RnVVbEtlb1I1SlRy?=
 =?gb2312?B?c2Vnak4rZXp1M3hETnA3ekd3dUVJODA5OTVzYk9NU3JVSmdheU82Vkt2NHdD?=
 =?gb2312?B?b3RNd2RoSThPbTBKZmsydWhUNXNZOURtVzBUQlVxMUFMbEdFUVBPOUZsaTJx?=
 =?gb2312?B?K0VRODFDSEtHV0JyWjlab2xOWnJmR21oQnM2b3kzNnRCN2ppREtOTmlkRXI5?=
 =?gb2312?B?QmNDTlg1YTgxWEt6Yjh6ekV2QUhYRUFFRE5nOW5CS2c0bVhoYVZBd3V6VXdk?=
 =?gb2312?B?amhuUmFOTmE5WEw3R1psTGU5Wkg0cCtuT3dUK0g5c0FpdndzZ3JiRHVwTEVS?=
 =?gb2312?B?T0R3Y05VUExtakVpYnR5d2p6ME4xTWdtcm1UQ1RDdFhJeHEweVY4dCswTnBj?=
 =?gb2312?B?bVdkUk1TWW1lUmdmeE0vUkFjbk8zZloxUm12RnZBMUVhSTJ6MHdDODZqM0Nq?=
 =?gb2312?B?eGwyMTNvV0Q2TVAvNXduc3YyZGQwdlR0QjhzK2lyOU5FL1hrcHVCZHd5aHd3?=
 =?gb2312?B?eHd3M0YvS1pEeDgxWnIraGcxN2wzRWhzWFFidHdJY25ScnMrcE5WMXQ4UVRH?=
 =?gb2312?B?TURWQmpZT1FlWjVKQ0pGdHJseldEK2I4QnFBTitvSzA3QVh3cE1pZ0NGM1I5?=
 =?gb2312?B?R2JIM2s2a2VsS3VrbU1La3kwclozVENyNHpra05NUm9nMVNkeEJlcXJTS1VF?=
 =?gb2312?B?MTJEL1NSanpUVkJBcElXOUlVcG1RWkpnRnR2RHduVFI3TUZaYzBoQkMwYXRC?=
 =?gb2312?B?ZGc0c0lid20rd3I2Zmt4aVNJMHl0ajM0OXRhaTQ3bitCcHJrYWZMcXdjRDNv?=
 =?gb2312?B?NWxxUHUwektEbUU3c05Rdm1GSkdGMEVicjRCOUpGaTlwd1ZTTHRiSHc5Nnlx?=
 =?gb2312?B?WUd2cFUwNHlweVc5VCtxWWlSTkdmeWlDMWVVTXFzUFdaek12aUxUcUtrRlE5?=
 =?gb2312?B?Uy9UNkhFS1dHVk9TSnIvQlJVbS9scmVEZ1N2TGNDR0RVbUE3REhoRlFWRkdP?=
 =?gb2312?B?OUtOWlh0WWtJSHZjWXM1alJwZnZnTEZxT2k4TVhFT0lDN0wwc2FRQ1daZkpP?=
 =?gb2312?B?c0p2bjd0RSthM1hwRmJ0Ukp3bWNUTkdKTlBrVG1MaDhwenY0YXFSQmJaNWhx?=
 =?gb2312?B?alFRMXhXbU5oSWpyeStUMHJPN2Jab2gzNjJHb0hJNkpPUHIzRzM3b1NOM0cv?=
 =?gb2312?B?R1ZtZk10Rm5nRW5vOHpXWXhBZnZRdTc0NnFMZzY5cFBVY1pmeFpVL0QxWlJF?=
 =?gb2312?B?RzY5amcvYThDYnNYeTcyWjlrWmJYSWp1bURaL08weFpGN2tFTm53WXZiMmxs?=
 =?gb2312?B?czNNOWQ1aTVHSFhLSHFsbG1oUzVvSmZzWlhnaHhjVlQyNThEeWtSUWRMOFQz?=
 =?gb2312?B?KzIyajRXa25OUVp0bmVDNDYzZ3RMODVJU1pwYkNyc0hrYTRrakFpT3FZOWdF?=
 =?gb2312?B?cXNIdGFIckFITTNGUmN6Nk5lcnR4U1N6N3dtVHViUktGbzJzTTh2NldxVGpB?=
 =?gb2312?B?WXlaWHlURGh3RmVwZGJxSGwyamxIcENPQlJldXlrNmRGbTVkNVR0bERNKzVj?=
 =?gb2312?B?clBJY25uSUpYbDlLRHk3d3FJVFVqWVp4N3Eya3hHd3pPTE1wRkQzL0ZhSC91?=
 =?gb2312?B?RjY5ajB1ZEpPWWVLYXJhNzNJRkgzRUxsRkhBUlJOUDRQcmhibCtrcld3TCtX?=
 =?gb2312?B?cXNWYVkrRWd3eVBRY0NJY0hDRG1VaEI2WVY3N1BjNGsxN3lWNHZNZ0t2bWU4?=
 =?gb2312?B?ZW5rNThwbUE1anhkZ2I2dlRtaXp2eGt5Q1JKN3BsUFoxK25ROTVlTnZqa1hR?=
 =?gb2312?Q?mngm+BiHllZj08Y1bV1nvu5xNrv5H8DpCQBbfdfKcGhd?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967A5322B8A8FF727314BAE9D26ASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2062069-ced9-4318-f661-08ddd111bcad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 15:40:26.6068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGubHdY2Fjwlng26luNtOPREfDSHiAgWhanH6v0n/otLsjSDqGyI20zw7OqYONklYtifzteYD4NspmKBpsSSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
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

--_000_SJ0PR12MB6967A5322B8A8FF727314BAE9D26ASJ0PR12MB6967namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KdGhlIHNlcmllcyA6DQpyZXZpZXdlZC1ieSBDZSBTdW4gPGNlc3VuMTAyQGFtZC5jb20+DQoN
CrvxyKEgT3V0bG9vayBmb3IgaU9TPGh0dHBzOi8vYWthLm1zL28wdWtlZj4NCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFt
ZC5jb20+DQq3osvNyrG85DogVGh1cnNkYXksIEp1bHkgMzEsIDIwMjUgMjoxNDowNyBQTQ0KytW8
/sjLOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+DQqzrcvNOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3VuLCBDZShP
dmVybG9yZCkgPENlLlN1bkBhbWQuY29tPg0K1vfM4jogW1BBVENIIDMvM10gZHJtL2FtZGdwdTog
UHJldmVudCBoYXJkd2FyZSBhY2Nlc3MgaW4gZHBjIHN0YXRlDQoNCkRvbid0IGFsbG93IGhhcmR3
YXJlIGFjY2VzcyB3aGlsZSBpbiBkcGMgc3RhdGUuDQoNClNpZ25lZC1vZmYtYnk6IExpam8gTGF6
YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyB8IDQgLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yZXNldC5oICB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMNCmluZGV4IDA3NmFkNDcyYTk1ZS4uY2ZkNzJmYWVjMTZlIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCkBAIC02MjY0LDExICs2MjY0LDcgQEAgc3Rh
dGljIGludCBhbWRncHVfZGV2aWNlX2FzaWNfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQoNCiByZXRyeTogIC8qIFJlc3Qgb2YgYWRldnMgcHJlIGFzaWMgcmVzZXQgZnJvbSBYR01J
IGhpdmUuICovDQogICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZpY2Vf
bGlzdCwgcmVzZXRfbGlzdCkgew0KLSAgICAgICAgICAgICAgIGlmIChhbWRncHVfcmVzZXRfaW5f
ZHBjKGFkZXYpKQ0KLSAgICAgICAgICAgICAgICAgICAgICAgdG1wX2FkZXYtPm5vX2h3X2FjY2Vz
cyA9IHRydWU7DQogICAgICAgICAgICAgICAgIHIgPSBhbWRncHVfZGV2aWNlX3ByZV9hc2ljX3Jl
c2V0KHRtcF9hZGV2LCByZXNldF9jb250ZXh0KTsNCi0gICAgICAgICAgICAgICBpZiAoYW1kZ3B1
X3Jlc2V0X2luX2RwYyhhZGV2KSkNCi0gICAgICAgICAgICAgICAgICAgICAgIHRtcF9hZGV2LT5u
b19od19hY2Nlc3MgPSBmYWxzZTsNCiAgICAgICAgICAgICAgICAgLypUT0RPIFNob3VsZCB3ZSBz
dG9wID8qLw0KICAgICAgICAgICAgICAgICBpZiAocikgew0KICAgICAgICAgICAgICAgICAgICAg
ICAgIGRldl9lcnIodG1wX2FkZXYtPmRldiwgIkdQVSBwcmUgYXNpYyByZXNldCBmYWlsZWQgd2l0
aCBlcnIsICVkIGZvciBkcm0gZGV2LCAlcyAiLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jlc2V0LmgNCmluZGV4IDNhODA2OTUzMzM4Zi4uMmY5MmIzYmU0MGY1IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmgNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oDQpAQCAtMTY0LDYgKzE2NCw3
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmVzZXRfc2V0X2RwY19zdGF0dXMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBib29sIHN0YXR1cykNCiB7DQogICAgICAgICBhZGV2LT5wY2llX3Jlc2V0
X2N0eC5vY2N1cnNfZHBjID0gc3RhdHVzOw0KKyAgICAgICBhZGV2LT5ub19od19hY2Nlc3MgPSBz
dGF0dXM7DQogfQ0KDQogc3RhdGljIGlubGluZSBib29sIGFtZGdwdV9yZXNldF9pbl9kcGMoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQotLQ0KMi40OS4wDQoNCg==

--_000_SJ0PR12MB6967A5322B8A8FF727314BAE9D26ASJ0PR12MB6967namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr"><span style=3D"text-decoration: none; font-size: 14.666667=
px; display: inline !important; color: rgb(33, 33, 33);">the series :</span=
></div>
<div dir=3D"ltr"><span style=3D"text-decoration: none; font-size: 14.666667=
px; display: inline !important; color: rgb(33, 33, 33);">reviewed-by Ce Sun=
 &lt;</span><span dir=3D"ltr" style=3D"text-decoration: none; font-size: 14=
.666667px; color: rgb(0, 120, 212);">cesun102@amd.com</span><span style=3D"=
text-decoration: none; font-size: 14.666667px; display: inline !important; =
color: rgb(33, 33, 33);">&gt;</span><br>
</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
=BB=F1=C8=A1 <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Lazar, =
Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Thursday, July 31, 2025 2:14:07 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher,=
 Alexander &lt;Alexander.Deucher@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@=
amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH 3/3] drm/amdgpu: Prevent hardware access in dpc=
 state</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Don't allow hardware access while in dpc state.<br=
>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp; | 1 +<br>
&nbsp;2 files changed, 1 insertion(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 076ad472a95e..cfd72faec16e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6264,11 +6264,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_de=
vice *adev,<br>
&nbsp;<br>
&nbsp;retry:&nbsp; /* Rest of adevs pre asic reset from XGMI hive. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, device_list, reset_list) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_reset_in_dpc(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;no_=
hw_access =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_co=
ntext);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_reset_in_dpc(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;no_=
hw_access =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*TODO Should we stop ?*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(tmp_adev-&gt;dev, &quot;GPU pre asic reset failed with err, %d for drm d=
ev, %s &quot;,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h<br>
index 3a806953338f..2f92b3be40f5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
@@ -164,6 +164,7 @@ static inline void amdgpu_reset_set_dpc_status(struct a=
mdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool status)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.oc=
curs_dpc =3D status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;no_hw_access =3D status;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline bool amdgpu_reset_in_dpc(struct amdgpu_device *adev)<br=
>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB6967A5322B8A8FF727314BAE9D26ASJ0PR12MB6967namp_--
