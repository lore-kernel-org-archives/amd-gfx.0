Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8930D3F073
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 14:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E7510E70C;
	Wed, 28 Jan 2026 14:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ytnGDHY";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA3510E70C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 14:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnOD9VXR6gpTKQ5lgQH0xw0yPjF2skd/kxjG1d22SnBi8gOAu8KmBKoRRuhCdyV0WqUcOmvRoikTuNFYzijgzAJahZJWI+FRRvXR2Y9U4hj6qsa27W3hGBlG5KJklihgLfmUQ61i0Xv+NDgNKClmzCQn29pav4mJ36NuCBsrZ6sZwmvDIZeOLAKmAXcNnTx9ZMHKzrfa6Odz5MheZYkaH39+uX0cQSlS+ACs4o806H2hkbEQp2jqLOl9YJMFUqJQSJiThSSQ3b2b2wqSYbJDC/DAdjoWYql0F7W465mOh8x/yqIiW88mfU39v59NvDZVc5gIGQuxCa4pswm1hJe1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQyNkHlCJHmb00apscCtyDrbvzeMtlz4DXrnn+hC7JU=;
 b=hpg8bh4MyagnuS8hT2iqr3jd+dyIXBSA0eRQ8okou6zkuLm7ts9kTnJz7sKzywqP5t7g25xOLJO4xzSLJe/dKdPRrowqZNwq3PRM+ThHsy4iqCZ8mlZB+Ebrzmu/8ihQKRuOms0b7EBVO7P6nXIicP9iO0POHSVQP61ym9iNY2bEOYNAhunCvYRgBD7QZ+npOvrlFFGgKrXMDJbjyCZrV6rAjkcJDXSJrdTdLAuEt3EVSr7aPBJjZZoMjbX6I5iTWkQqjBPerrpjt7mlJeyonxisnuC6Fof1b/8aoBNrv5byPEseLH8QvV7c1bqNR3EYS8PmMPSfC7tfmthFdBanyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQyNkHlCJHmb00apscCtyDrbvzeMtlz4DXrnn+hC7JU=;
 b=2ytnGDHYXJGy1GjPWFBXoB3QRY0IVMdEGOkQZQmy3Dm4ucRWLimTJ+NRAbIGoP00FqfWraXEyl4nX20uwnGjIuw1ZSKfSX3TaJ8lzy8YBqDP2kpbPkL31lqZNS5ADtn739X3JlD593Ht3QUIkTVZ5/LDDtB+kisAh2VTdi+jDs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:40:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9542.009; Wed, 28 Jan 2026
 14:40:14 +0000
Message-ID: <4c6c4ca5-62a8-43a0-9511-4c734a63ec76@amd.com>
Date: Wed, 28 Jan 2026 15:40:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: ensure no_hw_access is visible before MMIO
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260128062315.2848821-1-perry.yuan@amd.com>
 <5cbdede5-2f37-4960-b8b9-261e7e2e3152@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5cbdede5-2f37-4960-b8b9-261e7e2e3152@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f7835b-3d85-4c26-1dec-08de5e7b25c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlFvTVdCeStYTWlUbXk0TFRjSzBRTllENkFYRVNhL2lhOGF4Z0xxVm1DWDhv?=
 =?utf-8?B?aXh4d3VTazNYbDV6WE5saHFVZ3h6ZERpdmY0ektZZEhENmVoVnNCYjVFVHFZ?=
 =?utf-8?B?OVZhSjdGaGtpL3p2NUtDanVwbWF4YXpBUnB1UExpREJVMVhzNDNlenpZUnJT?=
 =?utf-8?B?TzRRZ2RzaEZLais2WHVDSy91ajl1MS9VdlFSVFAzTkYwUFh2OFRzbk9jTE03?=
 =?utf-8?B?ZUtyOWgrWkNDN2twZWZIOU4wYVdmd1VnT3pFRVJKR09BZHo2RTBsNlVoRFhr?=
 =?utf-8?B?aHAvQmRuNHpuSkdGYUp5Q0YzMUVVZ2xaekRTU083QldSOGE5d0V1Y0ljYStY?=
 =?utf-8?B?YnNsQkovc3d0R20xMThzRFBKYlRVaXZ1Y1FKaFZxOEpBd1Z2Mnpnb1kxRWhS?=
 =?utf-8?B?QWk0YWV4dkd0Mjd1a0Zla0RGS2pTMTBjaEo0SkFPZEUrUEtSOVEyV0hOS2xR?=
 =?utf-8?B?WWgvUEwxYlI2VS9UNFQ5bENKbU0zSzdidW1nYnUzUklqYUVRRTVjMFQ3SmJ4?=
 =?utf-8?B?QWhQNFdZS3dDK1RPbjJablZCY3VQZ3hyeEMwaUxPSkZ4VDlsWFA0U09WWTJZ?=
 =?utf-8?B?MVNLdWVmanV5d2NEZGY3QmNrd25JZlZMZHNsbFBtL01ISHpNaktrWDlwQVBL?=
 =?utf-8?B?OG5pTFg4UWcvQk1rQ0p4T0gySE9DTW9KQXN2TVc1aWVoUGMzZFZIS0plSkla?=
 =?utf-8?B?RFV4NXh2WnhLSURhTmZoUVdZQWZETDlQQkljc1ZVTSs3dTBlb0EzVjh2QVY0?=
 =?utf-8?B?aDFBTkdsYk91cGdlSE1mV2JZZTVOaHoyeUNZTSt0Q0U4SlB5dXRWZ0ZWajJi?=
 =?utf-8?B?T0JMZDRINEhBVlpzUGxLQy85UDRDbmJtUTBCZk52MmtKUm5HbSs3bjFiTDcr?=
 =?utf-8?B?T2JMaGZHV1VraGdZRjdBcHhzd2JtV3pFaDJqM2U2Q1k1OFlhVldOcnJ1ME1Q?=
 =?utf-8?B?Nmc3TlR6WXBKeE9Lbis3dVZON2VQdWpGak1tTW4vbXhjVzB5V3FwTjIrOURK?=
 =?utf-8?B?UVVWcUkxVjZiNEZkd1ZxaWM3eE1vOGl4TWZ5UXhaQU9yb3NzN0pMam5acXg0?=
 =?utf-8?B?SDlKSjNncE5odldlYkdSM2QzbUYzS1hHR2tzSS9HWi9nWitXRzVpRHk0dEVp?=
 =?utf-8?B?MmNVaERmWVZXZURHK0Jya3pZN0JvSkoyVG9BcjRHTUk3V0tPeFpqQjljVU5q?=
 =?utf-8?B?MDRrajM2dEUxWUp2T295dThRSUE0VzJiSlErQUt0ZVJLWkgxMlFZc3pVVVhp?=
 =?utf-8?B?UE5ubHc1UUN4UHN3RkNtMThsTVRERHIzM042c3ZqT1R0eittcEJHTkFXeUdi?=
 =?utf-8?B?NXJocTlXZGNaeXlxd1pJMnFsRmd4N2UydlpqVkdRcWNuMFlDK2tzVXllTE1r?=
 =?utf-8?B?RjhwSkhhUWE4YlRwVkZGSlhLcG4wNnU1MEtTdkFkYWJTSEp6Rm5kU1JKcHNT?=
 =?utf-8?B?NjRpdzlLc0pCWVZaVUZ3RUJadFFuVGpoeHFZaHNkenIwRFlPR0Q5eDV2WHZH?=
 =?utf-8?B?TWVqRm5LS1dHRzlxbkZmZ1hBSytQSDJQSEE0Z1BidC9PbDkwM0xDVzNsdm91?=
 =?utf-8?B?cVpEZm5sTENXM3pYR29WSmtxV2dPd0w4SjhsbG12RzVFMCt5eHlTeCswZC91?=
 =?utf-8?B?N3M5Y3JTaWpiL2lkaWNMZFZXRGc4MGtEa1RFS3BLL0drdktuMGxpNzViZUg4?=
 =?utf-8?B?QXlROXpTSExpQWs5Z3pNei9PYkpXUS8vaXNRcG96MysxVlYzRUFzWndFREI0?=
 =?utf-8?B?Mml2bWxDQ25BUTlkMEwybHdmTjV2eENOQWxhZE02cFA5MFA3YXA1Znl5YUhJ?=
 =?utf-8?B?WHNndURIamwyUlJCTHlFd2NoUkFPTjhFYldsSFArQVpNSjJVSWc5MHZqZGdv?=
 =?utf-8?B?L2lRZVdrSFNocm5tcVRjU29HMExPREs0elhSUjRaaG5LVE9HOEsyUkxITUlM?=
 =?utf-8?B?UVQzZy84UUd1ZnRVRjkwVUZjTHo4aHc0U0NrT1RXSFhVcjd2VDNzOVlWejEz?=
 =?utf-8?B?WkxqUkVJZkx5V1pkK2xNdHQ2SXNuV3lnMmFEWUJTK1hZVGh3YmlVakxESC9N?=
 =?utf-8?B?TmhUZ0NESnJkK01XbndJaFZEa0V3Y1duWW9XM1ZsckNYV0NMU1Zzd2szaXAz?=
 =?utf-8?Q?c61o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5SQTA0ZGVZOC9CYTNyTWpYMDBpWFZKbVlpUjJISDRpOGRwbEU1aDQ4Vk4z?=
 =?utf-8?B?QngrNWhYV1pkWnVtVXMrVWtwNllCZzVUbmtDMC8wTlFSUDN1blQwM25pYWVS?=
 =?utf-8?B?eE1OUDVHZElib01jVDkvaFE0U2l1bHd5SzhjYnI5Qm5YU3ZWbE1JRE5pYTY3?=
 =?utf-8?B?MEZvTGFSSHdZalE0N0NCODNMTHZtWWJQb2hSTnQwdHlhQ2N2K0JnUjBnZW80?=
 =?utf-8?B?VFhYZ0ZPNlRaUUsvU1R3eW5IOXl3MmRJSWgzUnhxcGI4Wlg2eVNKeU5ad3po?=
 =?utf-8?B?RmhYc1Nzd0FzR1JkS0JxWHkzdTFoYzFNRktiMkx5Y1h2Qm81L3J3S05rTjV3?=
 =?utf-8?B?UzBIbkFSWXdMUEZpcU9vZHBSUjA5ZnNWbG82VHB0ZHZublNycmNvUGdTajNN?=
 =?utf-8?B?dnpBNFRHV2pWa3RuYU5WcWVoeXA5TUZnSzZ5cnpLNSsrVXpzTytFalZlZml2?=
 =?utf-8?B?TGFuaG5hRStzSzMwVkJxRElRK0I0TFZTbklaYWlYWHNlbTdmQlY0a21WTzBu?=
 =?utf-8?B?Ry9lRVJQYllUSFgvRjFjWXVTcTY5ZGhLbzBtVjlRY3gxcC9rN3VBcHVKVVdv?=
 =?utf-8?B?QkNIaWlsYW5GeEZqZFZCUWtVYnF0SjJ2RGpIS2J2Z1N2c3VKMi9ibi8xK2Vj?=
 =?utf-8?B?T2ZMR1JEOWd2MVVlSzRRTjh4c0hoYXJZVHRtQlBmRkVqSzc1VWErM0x3V1Zw?=
 =?utf-8?B?OWJZQm1sT1c4NWFQYVF4RmlpUjJYTGhSTEJKYjBUZ2xLMk11N09CM1NKdG4y?=
 =?utf-8?B?alMwOXpLbGwyU0pIUWtqM3ZlcS9NQUhKV3JlOTFSRXZpbGdrVTJ4czBIUE9p?=
 =?utf-8?B?T2svdzl4c2gwZnFQVnJUcHNsbkJBSzlGNnFkRXJDQ0hMVm4yVzh4M280emRl?=
 =?utf-8?B?OGMrZnlqODhqV2krZjBYYVZSdUoxK1kwSmNRY2xsZVVlYkdlNkVLNG9ZQWJR?=
 =?utf-8?B?V1pkdXcwaUdiSWpsOCszU2VuQ2RKNm4rVXRnenFZVEZhaThpL0N1bHN4UTdD?=
 =?utf-8?B?V1ZEVHdEcThDQUJydlg3bUVueTV0ZVNjL0lnRWtYdjFKOHR2SHRqYzZtWk9w?=
 =?utf-8?B?ZkFHdy9CdDZMWGEweUpIYkYvMUp2UG5KM3VVVk5ENkY2VlNFOGdGZGNSZGph?=
 =?utf-8?B?cE1EdUk2RjlRdlI4N2pWTGdRalo5R2dGQjNDL0liYWVLTzlXY3R5T09GeTI1?=
 =?utf-8?B?Y0RkUk9lMmlYajhmNWk2ZFVTZDBUMW9zR1lqcVI5Q0hDbXMyZzd6UFliNmgw?=
 =?utf-8?B?NDlzZ09JUXBGRFdHVjltTDhvbzQzeVZ4NXhnSGp1UXJPRVh6K0MvN3RyQUE1?=
 =?utf-8?B?aTBsaDNZSWJyR0d2UzBIclZWSnVVajRGam80cnFHckVsUkVLMlFKek54aXpL?=
 =?utf-8?B?eUFoR2RlSDBWWko1b3FQRmQ1dEpWbTlaeU5CbEtjNVVVNytXc2RIQW1qNFVL?=
 =?utf-8?B?WE05akJnRDNMYm50V1l4aEtxQmdrYkNaOVhGS2d6azl2am9tQmQwN2JwVUVz?=
 =?utf-8?B?NFIxVFhmdFZHTDhqMzAxWE5LS3NERWFjRStZZDZieEFWeEMvOHc4THhINy9i?=
 =?utf-8?B?U1MybE5BU3Z5YlhZS3BvRE4reEtIenZ6aFp5SW9LeGFWZyt3UDFxRlJtN2Jm?=
 =?utf-8?B?YTk0SHB6YWJodU1XUHFBTmFQRWNpS1lmL1hndlpTSVdqUVJtUHRJN09WQkli?=
 =?utf-8?B?V1NRSlVjeGRiakthN3lwS3I3akFtL1lLcnptY2xNcEtKd2M2Z1JaT1llOWl2?=
 =?utf-8?B?YldLVXdUZFBzbmxBeFBQSTZoVmRWdm9UZU5LMzJLV2s0R2doeHlLVUo4enV2?=
 =?utf-8?B?Ukw0dTBZaGRJSFByN2t2ZVNIRzBxVkdhbU5ITlREMWx0NURneWFIZVI2bjhG?=
 =?utf-8?B?T0VNc1BFRzNSQnBrZDhzT2srWDRxK0hSS1NYeklqdVlwSklMZkFaQkJ5YUtw?=
 =?utf-8?B?OEd3Ti9UTzFJNGNjQVpsNjlDVE5GUVh0UG4reGlVUkV5b2dtY0pGc3pmWFdm?=
 =?utf-8?B?RERPejVVZEhtY05MMXJHdTZaaGIrMzVBaWVsVU1VYjk0Z3VpZ1lXYzk0NjdJ?=
 =?utf-8?B?VFVPbzJyeEhoaDI5OU5zdS9CdEpBZU0xK2ppR3NuS3hxQzBmZWdmU01WZlNi?=
 =?utf-8?B?emgrM09KUVNxVG0wTTg4S3gzWlBPUVZyS0lsUTNqM2R3R3UrQ0NIMnF5WXY4?=
 =?utf-8?B?ZFBHUG9HZkl3WTZMRmVDZkYvN1B1TElZYTBpeFlyUW5nQWI0RXR3M0lPVGwv?=
 =?utf-8?B?SXFEcGdpUENSVUI0YXlkbFc4UStGUXM5K3dEYWFSSUlhUDlremxMaGRhT3dv?=
 =?utf-8?Q?EKoEAM87wgVMEf3MuV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f7835b-3d85-4c26-1dec-08de5e7b25c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:40:14.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woKqcQfRbLaBkhJN/AA0pAJg2vqvrXMQUvfAJF3FR0YC43JEVyhIAc5nxbBvgJga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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

On 1/28/26 14:57, Lazar, Lijo wrote:
> On 28-Jan-26 11:53 AM, Perry Yuan wrote:
>> Add a full memory barrier after clearing no_hw_access in
>> amdgpu_device_mode1_reset() so subsequent PCI state restore
>> access cannot observe stale state on other CPUs.
>>
> 
> Just want to reiterate that this approach masks the original logical errors within amdgpu.

Yeah, completely agree. A single smp_mb() is actually forbidden by upstreaming rules.

So absolutely clear NAK from my side to this patch here.

Regards,
Christian.

> 
> For ex: this is one such which would not have been caught in the first place with shortcuts like these.
> 
> 12caf3b76150 drm/amdkfd: Handle GPU reset and drain retry fault race
> 
> Thanks,
> Lijo
> 
>> Fixes: 91ae0045130b ("drm/amd/pm: Disable MMIO access during SMU Mode 1 reset")
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b2deb6a74eb2..e69ab8a923e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5735,6 +5735,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>       /* enable mmio access after mode 1 reset completed */
>>       adev->no_hw_access = false;
>>   +    /* ensure no_hw_access is updated before we access hw */
>> +    smp_mb();
>> +
>>       amdgpu_device_load_pci_state(adev->pdev);
>>       ret = amdgpu_psp_wait_for_bootloader(adev);
>>       if (ret)
> 

