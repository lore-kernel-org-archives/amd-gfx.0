Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9F1C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 12:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26B310E65F;
	Tue, 18 Jun 2024 12:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRS9HS53";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E89D10E64C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 12:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tccpwd95ARmeCqKtGCdEZ3NEtcZ15dE40B1E/jTpU1A585bVi9d0KlMPA4TFZq0QqERy1SPj+b6UrJ/9BmA4auDO6FazAiBGO5clts1yNO4z2FJj7c2b4zjAR2394bAhlrXQEJnkOZlZOVoNY4C3OtZNXAQmGHZUZJamExNpzgmIPyJPZXDjsGpiYhg3SZRyxmMpxKAu5bR1LzoIg9r6BmNqQmkeEw0kx3brgFGzblYzkV3D5vJh4OvjT8/ND3NZzIpgwSIavWBU2ee8E01rahmb7Jtcu2nrfxZc8e9JLYdl+CR1Z4UU4SlTR7ODKijDQviBaicYqlMxfWiwSN+wOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIue5sv9CYBm7M4InwXgGZRVpWqOtjV7+5+hmTLHGZ0=;
 b=N1/eKx2kZQrBPhbN/WZnlz/QqBwgaMPG+Tu4/P/Evpm6TQDlWIDICAi909ToG9XynW18dT79ATkNUjbswWO5Ru14oiss+9mxw7rpMWuitVpAkGa+bYSXQA4JchwKlEQXysyx22a0T4Eaj7rSvsGUCFjPonnvJRNfXBlJL+vQn9qVB72DGzGJGtKmGHjJZIMvGB9KFDWxLeL+OZsaJA1h5pueaMnk8UV2v7K3VODcQZut3qTYo1zzBdUTPuNdBK//4jtkEdkbZetQu9xrAIYP9+6I40gh+Fo6W2q4xJaytpdoJEWma7OYmJO6uGGySH2JnFh8CxdzwuO8sWb0Z3GeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIue5sv9CYBm7M4InwXgGZRVpWqOtjV7+5+hmTLHGZ0=;
 b=BRS9HS53VtyumhoODlNPCGNdjQS4F/dIddpXrrjHGVE5PT1MywJPgemjYAkiZ2he7jzfTQnN7tw1mKoGDEmNL3koG5IAyfxH0WGz406yIvf/A3vQY0iSFNBvDWFb5nNSULelqZJy3G9+25la3exmcrRnEXGVkaG29iGNCGRk5sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 12:00:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 12:00:22 +0000
Message-ID: <6edd52f4-6f5e-470d-863b-a4df04724065@amd.com>
Date: Tue, 18 Jun 2024 17:30:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
To: "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
 <20240618063359.304293-4-YiPeng.Chai@amd.com>
 <cb616e09-aad2-433a-a7d6-a6a322687d17@amd.com>
 <CH2PR12MB42153B70D0E1F0EC8719E371FCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CH2PR12MB42153072563764BFF1BC294AFCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH2PR12MB42153072563764BFF1BC294AFCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f902ce-f945-474b-094e-08dc8f8e3b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eml1M3ErVmR3bWcwcnJ5OFZGc1VKRmtzZjRQN2x0UjhSSWhDRDNIeGpTTlAw?=
 =?utf-8?B?M2R0bmNHWVZnbEFqVTRCdTNrUXpTRDkwYUFSQk81Q1BXblQrMFJZeHVzdS9K?=
 =?utf-8?B?d0YzcnVpd09EKzF5UnJIZzU4ZDBCb0dGZ1JvYTVZZncyeDVudXc1elh4TjVo?=
 =?utf-8?B?d2NKK1g4dGxPb3V0Qnd3Nkx2U1Y0bmhnMWhVeWRRWDk4TDJ2OGJYZnNpdGtB?=
 =?utf-8?B?TFJ3OVo1M1lxLzlrdW00REVFcUlnZ1orVi9WMEw2cUY0ZENCeUdNTURwaFN5?=
 =?utf-8?B?QWQ0NVJpR3NXbnExUVFTanZoL1YyWDI3NUNvcHN0eFFMbC9ibEtmKzc3K2lC?=
 =?utf-8?B?RlMwMmhxdGV5Y0dMZUtTM1VyM0xiSlh5a0tacUJRbDVpZnRTK2NvRUFrSG16?=
 =?utf-8?B?cnVpRjl0aEZqaHdzSG9XQnpTRHEvclpyVHhIdXM2YnZiWVRKdWZyZEM2STg3?=
 =?utf-8?B?OU5QbTJEdFZBak5sR1lKQW13cnpBcEtZWXJPdjhTMUNTOVQ3MCswZEtFMFJw?=
 =?utf-8?B?SmlxclEvUjZ0alluUTNLZWtRKzNxWUxVZnNsWWU3QjMwb3ZDOXhHOFNlSGU4?=
 =?utf-8?B?a0gwZzNkazRpU2RlOEdxZTFpUUwrdHVUbVliSXpxcU5mNE9zYTBHUnZFaFpQ?=
 =?utf-8?B?eUh2dVBDbHE1RjdlM0k1QWVMUHNyTlgxSW5tN3Q4VWg4cG53ZUtNam9lWkk3?=
 =?utf-8?B?andqVVp4K2xiQXFmSUFqejVMa2xDTVNoSnNGandWNC90VHNjOThGaDJlSWpZ?=
 =?utf-8?B?djluOEJrUDY5cU9Bc0ladlhDT3JXRUtHcFhvaFRWK29tczlucEVNVUNHeERG?=
 =?utf-8?B?KzVYZFZ5ZkFONDVMMHRnMnlTOTJEOVhjN0lWbWpiTWNGeUpDcC9idkh3T2dr?=
 =?utf-8?B?M0FTeHgvTUsrc1A5dnMrektMczRtS2ZDa25WWnJHZ2h3UXpkdkR0VEY0SW4w?=
 =?utf-8?B?OXhYaTV3aEk5aVFiY09OT0d5eHByNEI3NUtkZlNROFJ2ZlFJUGxEWUNzbmpH?=
 =?utf-8?B?YkVYdndZWlJQOTRMTVJTdFhhUndCUkw2TXlFTEpEU1VhTlppeU9yZlRFZ090?=
 =?utf-8?B?NUp5UHZlcnpKalNWK0doSmlIYmNKdUdKNFhhenRMSmlVZWlkaFdnTVdjY093?=
 =?utf-8?B?d09ucTkxcUdhTDVDOHoycFFEbUp2VnVhc3BpR3prMjNlajZaTTVLZE1XN1hH?=
 =?utf-8?B?NVpsRXFyUXJya1Y4TENGVS9PYUQ1SXFvcG5oQlY0RWFMZjlMeitWTzFsT2hQ?=
 =?utf-8?B?Q2pYZytYMWxabTV3MnovcFgrQWxlV2VzK3BhVzY1R0MvYzhtWHNPWGE0cy84?=
 =?utf-8?B?VFEzZEc4aHh5dElITHBwekp3alBYWU43cWJWWGdRRThzdWx3SUVyYzNld1JF?=
 =?utf-8?B?cGRQZVZEeGNlaWMzcUVXY2ZCRnY3bTlrbWw3Q3kxY0FWNHFRVnBIa250bFZH?=
 =?utf-8?B?dENmRDNVdVl2aHZ1SHQxa0pGMWxWb1RBZzM2WFdpNjh2S0Z4TnhuOXpmU0hN?=
 =?utf-8?B?U0p4N3pyZnh1MUQrYW03QkFXREFsTUFUM1J2VHE5ZzdYODNsODVwRm9jalNN?=
 =?utf-8?B?RFRaTy9aaEpKMm40VTFUQUl4OVFYeFJYeGFXNHBQNkJLcUFIK1Rtbmk5NHMz?=
 =?utf-8?B?Mm1CRFFSU093T0hFQkVUamFWMTN2bnZvamVUT1RnYlEvSHhuVWY4ZzUvTXZx?=
 =?utf-8?B?NlRZTGNHcjdWc3pWNmIvcVBCeXZoVHN4UklJN3BWaVJEeXl2YkY2bjdLMGJT?=
 =?utf-8?Q?869k3s30JHVY7FSF80eZwSsBFca6xkUgpA5sb8J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tRaWFaaHBaZXc2NDhmSXpiYVlENTFURGpFWVRydGVNZUZ2c1d5MTBsVW5X?=
 =?utf-8?B?Nzkxb09IUHhYZVU1U1o3UC91M2s1NDJXM1RLV20xTUxZTXJsYXJoMWVwek9l?=
 =?utf-8?B?dTBISmtPR3YyQUhZTTdpeVpLVlNUc3k4RTNmWHprNk1mTEF0UHFLZmNsQ1Rt?=
 =?utf-8?B?bXVqL2cxUnpZTFlrQUMrRjVDS2RLSVN0aUVoeGlpSmJtc1diWkhRNkpMK3lh?=
 =?utf-8?B?T21vL2xXZlVYWlNFc29YSjZBck14VXlEQitTOUZ2UWQ4SzdYc2RMZFB6Z1Nl?=
 =?utf-8?B?eTlWV2FjSnUwczRiTmpDaUc2UTh4VDEzSlpmNnFpRm1EYS9RMkJlbW80YkNH?=
 =?utf-8?B?VzJmUUdsNGRyU1NvbFB2VUtwZzh2bXRCaHFLcWxBSUpXajBZOWRDUll2LzR4?=
 =?utf-8?B?cEk1cmY5ZGV6YWFUL2EzKzBtaGErVStDem1RSXJ0WU80ajdxOHQrRFQ3bEFk?=
 =?utf-8?B?N09JYW5oWmtDZm11WEtsZVRNclBPTHc5eFpRYzJuSCs4OE1JNXFnaXBiMjVn?=
 =?utf-8?B?Q2RLYk1WZDJ2b1ozYi93N3RtRUVLa2o1dnpNenpGUE1rUFFrNnk0RG9BU2o3?=
 =?utf-8?B?R0R1c0RCRFc5cUM4R0wxREFDMWNwdmpFRW91VFhCcjVsZW1xUVZwYmJORW5k?=
 =?utf-8?B?Q1BXT1ZJdWFUeTIxVUhYdlBYUDExdTJoUlR5RWZtNlRaYi9rcUxlR3VlTUVx?=
 =?utf-8?B?cXNLdnJuZ1VkQWJGMkdSUWhMNk9VeFp5cnZEQzYzejNURkg2disrMkFWQklm?=
 =?utf-8?B?UklnbWJOT09ZLzFrSVN2cXk3VjN1KzFmTjFTbUJqbzEvUlJla2dPeEtUYXpG?=
 =?utf-8?B?Y2o0OFE5SWQ0b1JhVzFCOHkvOGRqNjdqZWZaWjhtY3RqNVpIZTl0OUtmd0R3?=
 =?utf-8?B?RmJzK1hYelQ2MlVCOXdTazZDY3BtYnRUc01ScTFKMGlqMkh6VFJkblVBcThT?=
 =?utf-8?B?cm80SXpZYU82WnBiNDRzV1hUcjM3Y0QwNHQrN0Fid1AwV1BVUXBwdUFGRCtw?=
 =?utf-8?B?UXVaUjdRVm9HclNMdno0U0d1TWhXQmJ1Y2RjTHA4TDA5cVBNZjZmMkd1Qy92?=
 =?utf-8?B?UEtGTEZZdENGdUhqUmpmMnVGampNUy9hcVpJSCtKeFdPWTNiK3pjajBycEo1?=
 =?utf-8?B?aUZnMW5Sbzg3Y0tFYlZTeGpEU2Q4QlFCZHFWYXA0QmltRVU1cFVDOUpVVTgv?=
 =?utf-8?B?b21iWDVXcU5PMGRvY0htM3N0SkZvV3BkanFjV0xKVUxkRHhSOHhScFN4WnNF?=
 =?utf-8?B?OVJJSXNrdGVzYzlMUEM3Vmtjei9CUjhuUE5TWGhjc01JMmZyL2ZOQ2hnZFNX?=
 =?utf-8?B?WkttN0lTVG0xSHJYems2NUkyUzRFcmlRamw4NDRSYkJMTHF0STRyY1ZTbkxj?=
 =?utf-8?B?dEZ0NHNLNXdCazFhODY5c1JCUEZIL0JWeDJzbjBnR3A4L3o1N2hTNnhIZlhi?=
 =?utf-8?B?d2ZrQ2t2cVpQd25xakR3Q0g2RXJHOVkveGpLQUZ6MmJ0SWdETHdCWUgwb25Z?=
 =?utf-8?B?OFNwbGM5T2ozaDlOQTdqNjUyam8rQlQ0YnUvd3NtRlBiU2dqSU5PS1dWbVcz?=
 =?utf-8?B?NWQ4dGo3MFhiSHNFVzl3azQrdGJzYzRYVStJa2pGSTVaMnJxMHp6VmRsOHp5?=
 =?utf-8?B?YW03amxPQWZSQklldUpDd1JTSWlDOCtuSTFqVHFxcnZNNjNlelFpa2JDZ0NU?=
 =?utf-8?B?WTZwTnd3R25ZSGJaS2p1OTFyaENwemxKbEtld0lUN1QvZFQvbkc2ZnVSdDFP?=
 =?utf-8?B?WjJKL3dkbTVGTDlQS2VocW9kQ2Z6Nk9nRlBwR3VvT3FNUHZOLzRTalg0dnN2?=
 =?utf-8?B?NHMwbVU2UFEzaDV1blVHSzE2U0lHQ1ZOQ3Q4NjlKUjJlWGNvdkgzblR6MGFM?=
 =?utf-8?B?R1JSQ1d4Qmk3MmJMMXMrMkFHcTZ1Uy9IcmZWUFlGL2htTUdRbHBxSEVUV0Ey?=
 =?utf-8?B?RHVJekVoRUN3Nk9XdmZuWnBwSUVlOEhBeWdsNDMrSkdhZElqWTh3VGhzR2hr?=
 =?utf-8?B?WnVidHduUEpWdWh2dnBmMHhtY3RsTzN4cU5UQjRsVVpOcnphVFg4VHVaNWpp?=
 =?utf-8?B?ZW5xcEZ5MlFzYWdaU21hNlBua3lLN25sRDZYRzk5NExJSXNuZW9qclYvdGxI?=
 =?utf-8?Q?clOMLvaRlpkvNpUUAjPN0nz34?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f902ce-f945-474b-094e-08dc8f8e3b45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 12:00:22.8114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLEtNRqhdCkOlFzCxX3DmVCESCo/5RNcvwtBPQjOk4rH06pmgzRHd8RxCXYSTuHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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



On 6/18/2024 4:51 PM, Chai, Thomas wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----------------
> Best Regards,
> Thomas
> 
> -----Original Message-----
> From: Chai, Thomas
> Sent: Tuesday, June 18, 2024 7:09 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to complete
> 
> 
> 
> 
> -----------------
> Best Regards,
> Thomas
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, June 18, 2024 6:09 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: Re: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to complete
> 
> 
> 
> On 6/18/2024 12:03 PM, YiPeng Chai wrote:
>> Add completion to wait for ras reset to complete.
>>
>> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++++++++
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 898889600771..7f8e6ca07957 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if
>> *ras_block)
>>
>>  #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
>>
>> +#define MAX_RAS_RECOVERY_COMPLETION_TIME  120000 //ms
>> +
>>  enum amdgpu_ras_retire_page_reservation {
>>       AMDGPU_RAS_RETIRE_PAGE_RESERVED,
>>       AMDGPU_RAS_RETIRE_PAGE_PENDING,
>> @@ -2518,6 +2520,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>>               atomic_set(&hive->ras_recovery, 0);
>>               amdgpu_put_xgmi_hive(hive);
>>       }
>> +
>> +     complete_all(&ras->ras_recovery_completion);
>>  }
>>
>>  /* alloc/realloc bps array */
>> @@ -2911,10 +2915,16 @@ static int
>> amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
>>
>>               flush_delayed_work(&con->page_retirement_dwork);
>>
>> +             reinit_completion(&con->ras_recovery_completion);
>> +
>>               con->gpu_reset_flags |= reset;
>>               amdgpu_ras_reset_gpu(adev);
>>
>>               *gpu_reset = reset;
>> +             if (!wait_for_completion_timeout(&con->ras_recovery_completion,
>> +                             msecs_to_jiffies(MAX_RAS_RECOVERY_COMPLETION_TIME)))
>> +                     dev_err(adev->dev, "Waiting for GPU to complete ras reset timeout! reset:0x%x\n",
>> +                             reset);
> 
>> If a mode-1 reset gets to execute first due to job timeout/hws detect cases in poison timeout, then the ras handler will never get executed.
>> Why this wait is required?
> 
>> Thanks,
>> Lijo
> 
> [Thomas]  "[PATCH 5/5] drm/amdgpu: add gpu reset check and exception handling" add the check before ras gpu reset.
>                 Poison ras reset is different from reset triggered by other fatal errors, and all poison RAS resets are triggered from here,
>              in order to distinguish other gpu resets and facilitate subsequent  code processing, so add wait for gpu ras reset here.
> 

Reset mechanism resets the GPU state - whether it's triggered due to
poison or fatal errors. As soon as the device is reset successfully, GPU
operations can continue. So why there needs to be a special wait for
poison triggred reset alone? Why not wait on the RAS recovery work
object rather than another completion notification?

Thanks,
Lijo

>>       }
>>
>>       return 0;
>> @@ -3041,6 +3051,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>>               }
>>       }
>>
>> +     init_completion(&con->ras_recovery_completion);
>>       mutex_init(&con->page_rsv_lock);
>>       INIT_KFIFO(con->poison_fifo);
>>       mutex_init(&con->page_retirement_lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> index 91daf48be03a..b47f03edac87 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> @@ -537,6 +537,7 @@ struct amdgpu_ras {
>>       DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
>>       struct ras_ecc_log_info  umc_ecc_log;
>>       struct delayed_work page_retirement_dwork;
>> +     struct completion ras_recovery_completion;
>>
>>       /* Fatal error detected flag */
>>       atomic_t fed;
