Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08EEEF5868
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Feb 2026 05:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C70C10E139;
	Sun, 15 Feb 2026 05:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3bXDyibZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7783510E139
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Feb 2026 05:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V75+W5jv0V75xAMp2bmpGOCFwzjYG1UIxpSQpzklMX7W9p/qqsm+eUqWOFbAvc/vbGtVXk427LytUjIExyUtVo7S5ssklmKtzqgEPpbKYbrlWRENZnat6mfbr0zqdZ4e6d4Dimrcl/hc87DrHrBglukf7fC7tWExkvsF/ElkNLy3Eulql6zOnAbVg26/FURuR/N/N5bcDppGZmfEHB2y4lp/IZca6Xq6M/rqXV4DLWd3rAv4HE75OGDMYExoIyA6jeO61oTIcuZZ2Pj52uydVoV+c2JGK4Qb3ogPlZOujXZQkxTuOW49qpoewuPiiRapu+iVtZYq+Knzc04ZGyoBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+4mk51s07Qyt78qvFdcj6G/qWTjUdc7wqC5UqiuCHc=;
 b=hOuWF74bT65vAp3h/Fpaafwoiq5yQdgfJwPVx71yfZGY3BAQP5lP1EfHHk9m3IinDF+OoD+UcUb6vJseOklmZdKb3eUvXkwItPAxEexarOE6k2LVxLAqa5qGmuxcGSG9mr67kIx5ejBF8aRuBwFfOZYcTZUrDZ9JDTNZg/FSwspMfc8BWDYHN6NOOF0OuimPbVgej+b6IsTSwfVizSvV8dQcRAgT62dqJPDM5jebkNDCwiliSIgNtWkqLn+QzpQqEdoNnK578CHelEdY4puLX+7e0fxwUoc3iKK4s2InIfH6C4JTDYhln9qB0+023GbqPeiH2WZIuqxFS5rixQ5SoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+4mk51s07Qyt78qvFdcj6G/qWTjUdc7wqC5UqiuCHc=;
 b=3bXDyibZNZvjXPnPDPv710Ok8JZVJ/0g7YDNdYtxMCtaNj/36AFW36IQLNc2+g/IRAeu7TYL/n6MwiymHWAMmbVG35tDfyfgXQdLogkpSKP/BVKv4UrzFQBePFQl0ZjIBuF2AfHfvcETlmOKWb86fxPBAmSMS0pR8QVFejIJaeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 05:06:35 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 05:06:35 +0000
Message-ID: <376e868d-8962-416f-bdd9-a1eaf1094cc3@amd.com>
Date: Sat, 14 Feb 2026 22:06:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <20260118173150.19790-5-timur.kristof@gmail.com>
 <a6038bb6-d180-49e2-b063-6a0135f13648@amd.com>
 <2869796.vuYhMxLoTh@timur-hyperion>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <2869796.vuYhMxLoTh@timur-hyperion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0244.namprd04.prod.outlook.com
 (2603:10b6:303:88::9) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 895e094d-acf5-43ac-f04b-08de6c4ffdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzhnQnFhZ0xTSllyUUVYLzR6UVBTcGdyb2RkSndhY2hjWGxDWmZQdmQ1Q3ZT?=
 =?utf-8?B?cGh1a3dPL2hHclNXbkEvdmFMdDFUaFNhNENybVQyd3BvNmF2T0R0aTVTZ0J2?=
 =?utf-8?B?VXhOMGNDRlVTbEpiUFpHOERIQk9UN0ZhcFl5S2QyTmI2dVZQbTlOeXcwS2k1?=
 =?utf-8?B?WWdqckVVT3dKOW1ZWDBYOXNma2d3cjBqRGFsZ2k2MWM4ZnlmOThkZEl2TW1x?=
 =?utf-8?B?YitNVm5UVzZZTFBhZ3l6eWxXd0tuQnYvK3FiaXBHZGF5KytZdHp6ZFBaQ1lG?=
 =?utf-8?B?UjFkRjFYV2JJWVJLRC9qQ3Jxa2tENktQaUNDVjNlMUVhMEZZUHZaclZGandx?=
 =?utf-8?B?VTlkMlJ4ZzZnNFRCajlDVHNjOXBlVlNlWW5OdFJSNCsrZ1ViY3VlVzg1WDlr?=
 =?utf-8?B?cE1EMmhXT3ZBZjExVDl2YkVrWjdnVnRzaDY3SUdwUnVsSE9aSm9ZVSs2eU1r?=
 =?utf-8?B?bG1KSTBTQUJGeWtEeTJRZzNJd2h6b3c4UHBvWnVLbHBNbW9DYzY4WTJxTU5a?=
 =?utf-8?B?OGw0VUdSNUhsMXZELzlsSFVQeUtHUkhTYzhMUHMxWjZCd2E2aWhvRS9oV2dM?=
 =?utf-8?B?Q3gxTlNocUVydDlaUnpwalBEM3R3SU5HN051TlVtVWpHV0JseFMvOGw0ZGNG?=
 =?utf-8?B?R0tTNnNBa040d09lNnp4NTZXR3ZncWhFYitaanlLRkZvUGFIUUF6eVRUemxZ?=
 =?utf-8?B?cEpONEJxR2ovZEUxclNIR0dJWFZJSE45YlMyMUZtcTNvNE12TUxQUTdvRHg5?=
 =?utf-8?B?cjVUb1grWkt2Ti9Da0lBN3Z3V0Y3SDQxS1UrSlcrU0UvNi9vTDhXR2NYVzNB?=
 =?utf-8?B?L3M5S2I5akFFVWZGN2N3YTBJNktwcVYwUm5CbFAzclphdlUzbmhZd2Y3Y3Mx?=
 =?utf-8?B?VzNHdkVsS250cHRFU1JBc1BJNEo4dzBreHNxU3BMZ3VjYnhDV2VXa1hYdFpP?=
 =?utf-8?B?ZzNqa3ozcDBiOUNvYXMrSVN2SGx5VEVvOTQ0S05EQnptTnlyVkt5L2ZNTmsv?=
 =?utf-8?B?RDA5b2lhaHBQcHdmdHZXTDdrSmNRRDVWeGU2L3FkK0ZqZ1lVQmtRN1M2SjNq?=
 =?utf-8?B?RDR2RU9JZ0xUMHBVZ2ZZSFBPQVJSMk9CUjExc2pLVGJCejdQU3piOTEzM0hW?=
 =?utf-8?B?NmdseWlRcnpOQ0FxbFlXREN5Znd0MkNNUktoMlRlcWp4N0RLUTZwVk9rNTZj?=
 =?utf-8?B?K1V3OU14QTZibGpqMWMrRnU4QVgyd3BYbnhobXRmRTBHeTVLWEs1ay8wVDRS?=
 =?utf-8?B?NnlLRFRoWC8vSGZUYitwT09LYnN1cGlCeERrVFJXcGZDd21UVGtRazl6ZzFD?=
 =?utf-8?B?SktCVDBOTDVRS0NBb0dPZ2NNOGs5TEUyZytSaHFWeVJDSzlTdW5aQmh1QlpI?=
 =?utf-8?B?ekpFSzRRWEVZejQyaHYyZ3dLcUxyaGNvUlNELzI2ZTcrOENtYVV0dzJrbTVC?=
 =?utf-8?B?NHlnS0RFRmszREZydUIrTlRtVVJMN3J6d3BmU3lFS2YrWGc5Nmd1R3FqdlFK?=
 =?utf-8?B?R1doZEFZc0kwZUlhMEFlTlVReVJlUHh2NVVqSzlGVk9hbVp1T2lyOTc2VDlD?=
 =?utf-8?B?RGhvTHRxNGQ1OHZPaUVZMzBGUll4cmhMUHlDTXhMVVBLMFE4cHA2K01hSzFr?=
 =?utf-8?B?YzN5VEJzdHUxd05GWUJUczNXM3A0VXN6bStybm91M1AxNStZWlpVNFBhbXUr?=
 =?utf-8?B?N2tCRkw4R2VZT1RHRnZjb3hqWGxXZTN3VDlnd013WnVXSlJ3VTEwSXFZQ045?=
 =?utf-8?B?MHRuRDRlVitKVnR2cjZyN09DMWs3UkJaQU5vN1pqSkd2U0tGMzUwaTdycEdh?=
 =?utf-8?B?QjIxN3YzcXQ1RXkvdTdoUXBxSTkvb0JKN2srdW5PYzFHQWlPemY2OHI4dFl3?=
 =?utf-8?B?NWI2clA5eXFpaGI4MUxVSlBud3JteHhlTG5GaERlQTQ0ZUpDTkwzUVBKa24r?=
 =?utf-8?B?YStlL21zMWJCa2pvTGNDQ0w3bjFYT3NVZlIwdjRxVDdha0VWdEV6WVpJR2NB?=
 =?utf-8?B?K3pKc2xMYkt2MWZxSGVaSXB3UG53cmE5WUtDb0FvNnlUcTdPSnRtblg5SUNW?=
 =?utf-8?B?YlQ1TEttMmdLeDlNU2VvWWd1aVFicy9oTjA0TldLc001RWdCT21UeVV0L0JH?=
 =?utf-8?Q?i8kY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enRXT0k3Q3dmQ1kyQnY2UENJN1ltVFdZNDhqRUluRVlCWnBiYW0rRGVQSjIx?=
 =?utf-8?B?VlFLNDExc2RGSk5Ja0hISEozalBVR0hBRHF6N00xaC82elpkV2k0SlpCZDVw?=
 =?utf-8?B?ZXhIb25nM09hR1BIWUJ4NlhLQ3MrOXdlYmlnQXhqbUVGeGlaNStpRjdQSFp6?=
 =?utf-8?B?NmZ4aUpzU2pLb0pMMDZzTlh5VHhwZE10SWVDVWxjbllEa1haUWE1OGJkQkVx?=
 =?utf-8?B?aUVyTTNxQUxDV2FUTS9CUG1BWk1wYURyQmRBV0RhemJmZUtFWUpKeWFXaDly?=
 =?utf-8?B?TDk0eWg2YTJPQzh6VmM0cWpRQmlXSzR6U0xIK0IvT0tOcFUybmtxc1hDbWpJ?=
 =?utf-8?B?ODlsbUFqWmxvSXJ2emFVM1BGMDhoWlZhV2x3MXNvbWtFeEE3WWtKZ1FlemZx?=
 =?utf-8?B?Nk43eVZ6THVSbVBXN3ZDOFdpa3BuVWVlYnltNVd4S1VPbzQzOFpzcmd6VFZH?=
 =?utf-8?B?VkF6VDZVaGFxMUlYZHVTSTdnUkN6SjFqK0g3Snk5dTIvN2ZDcjlRMGNvUXIy?=
 =?utf-8?B?ZVR4TGgxNGxuZmVnYmFqU2JIdHZSdm9KVU9Pd1BUYlJFVFRzMFBwMWhnM01j?=
 =?utf-8?B?bGhOdmdrVDc0R2dlalA1M3N3TzRxV3c3VFZWeHJFbDNHSE84aGlMemU0dXdT?=
 =?utf-8?B?eTQvUlZhNDJqUjRjVGZ6dFFsdG5wWGNtSmR6YWs1QUdETWJUSGZTRWMvNi9W?=
 =?utf-8?B?eWprWmJZZDRQTHpkaWZEWHhNUHh6aWE5dXZUd3g5Rkd6OXFYSU9jemJDUjF5?=
 =?utf-8?B?ZFhtbkhzNG1tcE9BdTlETjN0OCtzOURYekZXUm5BSXFkMnh1MGY2bGNITWtM?=
 =?utf-8?B?SytUSTZSTTdIVENaR1V0bVpJelJnNEo0MnJqdkNUTDhKeVlTNXVnM3JkNWdj?=
 =?utf-8?B?eFIxNDdwOUxxYmFVelY4SkZJeVBCMDhnc3Q1Y1FjWGFFakYzWDUybXp0d2hm?=
 =?utf-8?B?WUkvZEJkWjJubklzYzVFN1NxT09WMXdFWmJ5c3FmVlN5K1Y5b0VNZ3R0SUxE?=
 =?utf-8?B?WWkwYmRSZWRxZzVBS2wwQkRIN2ViNkEySmRzMmcrNXJLcUJVa3d3UFlBT3pa?=
 =?utf-8?B?THlUQWFxd1dxR3V4TGt1cFZSNjY4UGV2TXJOenpSQzJJZnFleVVTSlMxeURH?=
 =?utf-8?B?QmNWMnlHdTZocDUxRXYrMFZUbVplZnNYMlRjTUNnUEhvQnpPS0h6WFN3V0VX?=
 =?utf-8?B?VHlFNE5KUk53M1l0dU5CTVBhZnpXNFVtTzk0cHpoRG43Y2gyY3RRK2dSenhm?=
 =?utf-8?B?dm04bXRpSWNqK2d5N0QzTnViQXZXaGtCUGNPVHVpdWE2L0crZzdqTTBoWTRB?=
 =?utf-8?B?cFJKTzdsalRLQ0lTaHdyOEE5VHVKdWxkQ204SGNMU2JRT09kaU96UlZYcGlC?=
 =?utf-8?B?d3gwYTJNV01OYnNzTjZrRUp5cUZBTTJLaDR3U1V6QW05Q08yakRLdzRpRTl5?=
 =?utf-8?B?dWlMWHdvSkgzYk5uSnJKeDNYK2FMdjdCbGpEUWY0RWpRcmlzck9GdE93MEh6?=
 =?utf-8?B?WUxZbytPeTI3UVpuYzVJRmZTMVRZOWJGbXdzZGxSaHFUU0FZUDlscGs4UWt3?=
 =?utf-8?B?UWZZRi9WWjNnOGxBempRVHdtaWlDT3BOclozNmxkR05FRTNWVnBqeDIvTi9V?=
 =?utf-8?B?WDYrYW9MMVNsT0VlSjhEaVNISy9TZFBrY2U5dEZRUnZiRGFHbUhJcW1qQWRN?=
 =?utf-8?B?aG9UektwamxlaFUzWHE2ZlVodTlkM1ZOd3pmUWg0QWExWmo0eXY1ZlRRV2xh?=
 =?utf-8?B?S1hsL0ZIZEVsU1EyUlYwdFhieFI1bnZ2Y1NTYkJjT045NU1BcmprM3hNU0tY?=
 =?utf-8?B?bUl2YlY4RTdZU1VGQ0tNNUo1TjV0SzMzS1hWclo0aGpBVGFsOTQrRVhsa2xM?=
 =?utf-8?B?TVJ0em96UVFTbVR1elNrc0J1b0ZLc1hZL2xWdHFzZ0lNL3RvTTQzNFM5RFJx?=
 =?utf-8?B?ZVZjcU9OcVMzQjhEU0dqRklyU0FmN3B0aUZhRWFDMVkybWtWREh5VjBUUGN3?=
 =?utf-8?B?eDZjeVNGRHdNem1BbUQ2TmZqaWtBM1ZYaUFhenZlNyt1RjNjWTBqRlNaSjN6?=
 =?utf-8?B?dDlQdjR1YkRmZ25kZUYvZ09VcVhJdjFLRm1ZT3RGcHlhY3pFWVU1UHl0dUxW?=
 =?utf-8?B?a3BGSUxHeUxqKzFjZm5tWjc0NnBaWGdvZWRseXBtZ2NRQ296bVVHK3ZZODFJ?=
 =?utf-8?B?ZlphWlV1Ty9GWS9lY2RJVFhPQWZVRklrS093dXpkUWlvNy9kdkRRenY3M2tK?=
 =?utf-8?B?TUFvMXlMRXU1N0tiWklMRlY2WFpjY1lyMEdlbUFTeldUU3ovL1ZzWUd4UHpO?=
 =?utf-8?Q?DxgyRTsKgEd+5Kdm9Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895e094d-acf5-43ac-f04b-08de6c4ffdc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 05:06:35.2513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXEvT38gfgWEscJ0Om0IxkGDuIgKTO8aM4JWe9G4daspuGv2Mr99PrPVwjVpWoooEisgJSsH+gODLlZbVUDgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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



On 2/9/26 15:11, Timur Kristóf wrote:
> On Monday, February 9, 2026 6:21:38 PM Central European Standard Time Alex
> Hung wrote:
>> Hi Timur,
>>
>> I just found this patch won't build unless that CONFIG_DRM_AMD_DC_SI is
>> not set, or with the following change to Makefile. Can you check?
> Hi Alex,
> 
> I didn't see any problem when I submitted the patch, but it's possible that I
> overlooked something. I will fix it in the second version.
> 
> Thanks,
> Timur

I can fix them them manually.

This series is Reviewed-by: Alex Hung <alex.hung@amd.com>
