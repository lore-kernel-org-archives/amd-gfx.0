Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64271C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 09:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108AD10E76E;
	Wed,  7 May 2025 09:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pYR6h5nR";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F101910E76E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 09:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSYiIUsFVW+VAz3sTSovOY0IHLXrsgVmeNSGZdDX9lX7nWDe1krf4+2woSizwke8gzAqdzFu5DpbX2lBl4+RYfgl66RN7lQiQdUJggswBUGkOeWZ9FR2jZfs8evuojPX/abW+TmE1e3kMeJMG105dkOokRAmOJX8c5vo+TyMlwoIbP90LX3d+ItGhkvGCmFXPMT5gMBdIDQwxTPi5Pml9qHltSuVicq1kY7A0BsJG1fDLihNixXcefADMsIqyuDVk2NFE1eaazGacG2XAd+N4rTTsWQVvQT9FaLs4X6s6+BQvlvFvzAuOA3zp0WXHCR8Blmb8/MR9+sUoNzIUJvLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxVRcHlllpy7OIM4Q030II4XxgnDVu7MSM2hnrwWzmo=;
 b=e3I1iFbK9SWnOWNOM1XJ9U4pUPsvIK4w9g68OE1av6wkSKZ+dIPHP6YHTszYKfb+3m3koGqw6ZH7VU23JvyJbLhOu0D6oshc0pVQL0gGa0b/ruPbIMY2IodO3iiwBPnM4l2znQPsExo6ICng/vdBHu1pXBEdNoK0DZ4C6a3+ZoWZYJnYD0JAUk4bTBMcg347UK/jdZcDQLwQ13YpZWuCXas/j2O7p0i1trvyRUxgC5vlgMSxBCJw9vJq9gvchrV9wU99r36gOF4UaY/C9omT9R15X5ovU0A4fy0ku/rHRwzBwjMVYtHEoINUbXMXPPz5KGqe241dffTj0oyMPqR0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxVRcHlllpy7OIM4Q030II4XxgnDVu7MSM2hnrwWzmo=;
 b=pYR6h5nRy/V3Y2+oMYU4n356jOjEUbmeiU9nLlpquuFQQeYsQpAS0keKOeHsMZ/4qIYG+F47CRZLWdsC/ltemux7SejgWbnQ9bB42PPZkKbyCfUJtxDycAHJJWkcU9UhWE4Tp9OdEyVszjL6FUR7DwkdzdT3U40dXilw4BVZGX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 09:38:17 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.028; Wed, 7 May 2025
 09:38:16 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the indentation
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250507092934.701120-1-sunil.khatri@amd.com>
 <BL1PR12MB575362E1780D89A61C5324D79388A@BL1PR12MB5753.namprd12.prod.outlook.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <b3b1f606-66e7-df95-0282-b0af97fa953c@amd.com>
Date: Wed, 7 May 2025 15:08:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <BL1PR12MB575362E1780D89A61C5324D79388A@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------A92C330A8579F29B6B6926E4"
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::11) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 209ac447-c15b-45ee-901f-08dd8d4ae4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzdVcUExRi8rVmlwUjJIVSt5NmRVNHRHYi9RSWdUclBiMDZpeWgzSEFGL2xO?=
 =?utf-8?B?eC9XeGJqVk4rZ1ZSeVQ4d1M1a2RmU0J6TkliVEZsTUZTOXloVTMvMFlGbHV5?=
 =?utf-8?B?ZW52SDZTeDVTM1ZiWE1OZm4vSjVqUnhxRGs0NldtSXJwNmRhdSt0c0Y5TG1U?=
 =?utf-8?B?RnJNZlNzSS9XY3NvdXJpT0ZQNDBzQmJIbnhQSG40Z0wrcncrMjBmQmx5L00z?=
 =?utf-8?B?MlBMOWhGQW4yQytmWWZnNkRFMWhoMml4SFg0SmQ4bVliSEtRbVZ6aDQ3UUpL?=
 =?utf-8?B?TEUzQ1RRZWdhekphb2RCRnlsQXMxWmlqUFZRSTVvY29LVlNSMkRhVytwdE5Z?=
 =?utf-8?B?ZHE5YTNZeE5YSlZDK3U3ZEttL1RxRk5oZ1Y1RHpwdy9zRHA5NDNTTERyZmds?=
 =?utf-8?B?dElRcWd2Q0w1VmVFb3FXQ2taSjdabnRRWkJHTGZqclVTd0tFeGRHSUR3WFdn?=
 =?utf-8?B?dW9vTEpzWW5kdkNyc3kvVHBQVWs4T2c0SFc3WG5VK3dCWkpuWlNMMzRhUGIv?=
 =?utf-8?B?SGdPUGppbkRscU1yZ0NqNlhjTTNPcnRMRy8zNWlZU2xyWHdNUWRJTmE4WFJr?=
 =?utf-8?B?WmlCYWoyTm91OGJUcVJHbzVCbVUzKzlrbVc1S1BLcDJlNnhZbnRBaHU4M21O?=
 =?utf-8?B?MVRLTXQ3TFI5a3RvS0xjZTNxQkdTUWxrMiswdzMwcUp2Tyt5eUo5RFRGclZU?=
 =?utf-8?B?MnB6TVBaTmhvVERla0JaTEZiRm1QM2R3MG5mRkJPWWpWL29YUjVEbGdaNi9Q?=
 =?utf-8?B?bW5NV3pPbkpVa0ViSUhkSlFWSmFJZVVCZnhOY2R4bitBNklWdlpqbUEwcmVu?=
 =?utf-8?B?MzNkTkM1YnF3ZXBad0lRaDNBSS8xQmh5VzJaU3hSdWdrRzhFMmdDN2k5UVls?=
 =?utf-8?B?WlhMdXNYQmxWS0VBb3J5RGpNbjA5b1ZDKzB5K2d0UjJHVSszNVBWMWhacE1B?=
 =?utf-8?B?STlza3FlblAzeEhOSUtkenNKL3UvNUt6SXloTDBwSHpHNHlzUGtuK09jSTJx?=
 =?utf-8?B?UnFTTWlDR3l6SEM1Y3Y0Z0RxWWhEYnROcEZJYnk3emhwRVRRM0xDRGcya1Ra?=
 =?utf-8?B?WHBxaVRqR0pnWUNJZW5wZGtLK1ZYbGZDMFFRbWN4YklOaUpwV1BkbGlYY1c2?=
 =?utf-8?B?cisvcjVCa3JuYWx2Nk5rdWJ5RWhoZVVZK0ZNMGprOHBLZWhSamdUaENZRG1p?=
 =?utf-8?B?SnZidE43SmN3VDBiUi9zUlIzMUE0ODJMZWRkT3liSFZIN01Tb3JXTjNTek9T?=
 =?utf-8?B?bzAySC9PVVIzVmtuWWVyeWZJR2lLMmRONGYyb1NURlhJNEdtek8zWjBZOEJm?=
 =?utf-8?B?TENITHo1bXc1a0dIalRobERJQ3NGb0FGN0wrc1ZPRm0rYkIwQTJDN0JMWkl2?=
 =?utf-8?B?ZW9wamRhZC9SMDI4b004SGpOckFFUGVUbWEvSkx6QVJvRGkxeTEwRkN6UUlr?=
 =?utf-8?B?T2FNZGprZ1U4ZUtCTmpoNjVMcXdhWEdQNWxkeGh6dmE1eFhjNDl3ZWx4L0dn?=
 =?utf-8?B?eHZvVEpsaDdoWWNsaHlDWmUvdXNKTzdnMk9GSEsvSy9vTXJaNStJaUlwb3Nu?=
 =?utf-8?B?TVRNMXZZcmUvbndneWIvRU5UMXgzcXRtUmdXbXVFWENzbFNRSWEvUDZsQ1JK?=
 =?utf-8?B?QWdRWWpKcVBpOVpRMWkydDdETG54aHE1OTJTckRYNW42TnN6YkdXZjZZVDJB?=
 =?utf-8?B?b1pjT3Rqb0w4VmJBTVk1amlzTTJIcXJ2K0VPZGdRQm1OZmFhK2I0TGVKQkRI?=
 =?utf-8?B?TFhLYTNOdnU2UHc4cVZoemdkOUF0QU5QaXViQ1dvYnZmZ0RZbVRiUzcyZVR5?=
 =?utf-8?B?SmlGZGkvYWVGK2FIYlZvR1hGUENpNy8rQmk0UG1nZnROSzQxWktMelBiV3JJ?=
 =?utf-8?B?VS9pdk9XT25abmsxSzRaWFhPTGJIZFZBSTZMSDArTWdVQStRS1d0S3FUbjlL?=
 =?utf-8?Q?nk+7iUL/EP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFd2MjZSUFdQN0hrb1k5c2h3T2p4Sm52ZUN3SDVYcDMwY0IzbXFEOXlKMERT?=
 =?utf-8?B?QjNSbE9ZQVpwZnE1d2pWZVhDbmdINnVRYjM2MHFGWk5kM1V5eXFhZ0VwQitK?=
 =?utf-8?B?bHZGZy81dTBvdEZwS2R0cllGR1BzdElSR2JGZC9MOEtOTXdIU3VKTzJQdVZl?=
 =?utf-8?B?YkljN09hR00vUytzNUMwTkQvN0lZMFdxT3RXSFRIUzRlaUFRaS8yNXF2ajI0?=
 =?utf-8?B?VGljLzI0MkZiSDI5Z2pQODliSEoxSTNCTmwraUh3alFsa3kwOWd2ZEdSa2dw?=
 =?utf-8?B?VjBHOW50QitLUWdoUzJsU1hmdlVaejN1RVFNS2lsa2ZzYk9GQ3VyNld3ak9S?=
 =?utf-8?B?UHUvOTl5a0l0eU0ybVNJN3VGdW1WKzF3eGdCeDRMTEZyZHVNd1FML1JDM2dE?=
 =?utf-8?B?bjN0Rk9BMTJzRHYvdFpaWVd3Z2hKT2thaDN0UkZBWmdCcnNlM216a01uSlZq?=
 =?utf-8?B?OUtPSy95azY4RVIzc1VMak9rZHVtSTVuNEhZaEVPNnBUVHVCT2xnN282d21j?=
 =?utf-8?B?K0F0UXdWN3Nxb29wdWwxMjI2cUQyTkc0MUVUcURFelVWTy90Z3FZSjhTdHRj?=
 =?utf-8?B?RTRwSDRLR1FpMmNEOVozZ3FUNU5nSzA3L0JwVWJQRXp1bXkvRS91bEk4YmdR?=
 =?utf-8?B?aVJpaEgvYmZPSDZBK3hJUTBWY2pVR2kxWGU4REl6eWdjZmlrcEhzang1U0di?=
 =?utf-8?B?VitjbXBzZGlqbjluZ1hFZUpjUVpnaFFQcHdRWkEvVUxzdWxjL3YySVR5eU9h?=
 =?utf-8?B?RTRUY3B4ZDVFVFUreDNidHBadkR4dzdvL3MySnZRVk5FYVNDclVyUlNwRWg1?=
 =?utf-8?B?UEdkcXdMbEVtT3lHekV6NWZNRjU4OTAwbHhTbkMyVldaWm5UTW9uWC9lOWJ1?=
 =?utf-8?B?Y29zSmxzQmFLK0pMdVRWMHExejMwWjVqZWNTTVliS1E4K2xMTnY4ME9HUllh?=
 =?utf-8?B?Q1pGNzRXU3NPVWJFcm96MzY3OCtvcDdqdkdzWU1RZUxaOUpCYnVpZXJDcDdq?=
 =?utf-8?B?UVVzM1FDVm9RNFNHSW9FcnF6UGNZM1RDTTFTRXlkdzBSZlhMR042QmlZZExO?=
 =?utf-8?B?QmFHZUh6bS9VaThwb1dJb0xFeElqSHVLa1ZuTjhJSGM3WGZiejRKNytkU2Zk?=
 =?utf-8?B?aW9xTzBnaWxUM0JpcnVtYjRKaElwbUk1bG01cXMrUU51LzIxNG9TQnpTR1Aw?=
 =?utf-8?B?bjAwNnpvSldkZGFSb1FnV21melZNRmdNM1R0a2VDTlVycy9ickZOQVpEdU11?=
 =?utf-8?B?ZVEybTN3d3JKTEtuay9MZEpFNUNIM2JDNG80SW1QVW85ZW55VTVTc1VWaWZG?=
 =?utf-8?B?MVY5cEUreGhFcU9IQ0xxdjhYTmFuaGk0d3hVR21jeHdhZWxpODBOTjFzN0tj?=
 =?utf-8?B?SWRqYml4SmtsbWdPTEFMSzM5NWErTHEwdXpxalhDSkR6V2ZIM3U2d3dsQlNC?=
 =?utf-8?B?SUxkTyt6bDJORkI0RWxCTG03L1Bza0VvVGExT1Z4cmNhT3dWckRNWWlFNWtJ?=
 =?utf-8?B?WGtTa1FIRm9BanExeXZpWUNsZEMzUUFYeUhuWElPSTk0UTdVeXdsWExzVTNF?=
 =?utf-8?B?ZnpEZEJQK2ZLVUlwYmUyVGJxN3hOWnc3RnJmWDlsRGdVWkxNNDl5WFF5U01x?=
 =?utf-8?B?MTM3V2VnRC9iNytCcFFCYmxQLzFkdlB4c3orYmVrRWVjUzBzRXRBVTJhLzRF?=
 =?utf-8?B?OTE4TnRpdVVhUjhPRVgrdlIzRG9YN2hxSzFCcVdTY242VThTS3hTUGhPYjk4?=
 =?utf-8?B?M3UzYndlcjg1UFpjZUU5QWV0cWQyU01MbGhNUzBhZ0o3aXg5b1p4UHlPbmJI?=
 =?utf-8?B?SGFYa0RXdWJhR0U0T2FmMDZoUzU3Yi9rWEtwMHVKMkZKeDhhYThMYmRmVGY1?=
 =?utf-8?B?RVM0ampycTl0K3pJM0FmZFRvQVE5VWJ5RjhBUHFvTkJpdnhwMmdST2FnRVZy?=
 =?utf-8?B?dFl1TDc4Z2RzeXNsMXlneHE2cmlOZ3hTNXRyTHF2RVNTRHl4bWtOZ3RHWU0z?=
 =?utf-8?B?dnlCSTd0WHU1Z3cvV3R3Z2swWmRsZlhjRXJPWldTVkg4WEllRnV3MDVhQ3pT?=
 =?utf-8?B?RGlxWWFxanExalFITXdQaVlOZm9FYnhDUXEvNERaZ3U4SHMzaU5Gb25yZjVV?=
 =?utf-8?Q?sGBEg4hxwCU2ElnoANBK7FYfl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209ac447-c15b-45ee-901f-08dd8d4ae4a8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:38:16.1473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7EQJlPDKjPvnDzzazVYBCM9ZMczFgF1MXjr9xYMgzpllJGbHhplj5vZ/gbdarNJAt8rurTF2cAN9s3SZKEjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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

--------------A92C330A8579F29B6B6926E4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 5/7/2025 3:05 PM, Khatri, Sunil wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> @Yadav, Arvind <mailto:Arvind.Yadav@amd.com>
>
> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Wednesday, May 7, 2025 3:00 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>; Khatri, Sunil 
> <Sunil.Khatri@amd.com>
> Subject: [PATCH v2] drm/amdgpu: fix the indentation
>
> fix the indentation
>
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:6992 gfx_v11_ip_dump
>
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
>
> | Reported-by: kernel test robot <lkp@intel.com <mailto:lkp@intel.com>>
>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org 
> <mailto:dan.carpenter@linaro.org>>
>
> | Closes: 
> https://lore.kernel.org/r/202505071619.7sHTLpNg-lkp@intel.com/ 
> <https://lore.kernel.org/r/202505071619.7sHTLpNg-lkp@intel.com/>
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com 
> <mailto:sunil.khatri@amd.com>>
>
> ---
>
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>
> index 3f4ee4b3b0a4..fe21393e155d 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>
> @@ -7094,9 +7094,12 @@ static void gfx_v11_ip_dump(struct 
> amdgpu_ip_block *ip_block)
>
> /* ME0 is for GFX so start from 1 for CP */
>
> soc21_grbm_select(adev, adev->gfx.me.num_me + i, j, k, 0);
>
> for (reg = 0; reg < reg_count; reg++) {
>
> - if (i && gc_cp_reg_list_11[reg].reg_offset == regCP_MEC_ME1_HEADER_DUMP)
>
> - adev->gfx.ip_dump_compute_queues[index + reg] =
>
> - RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_ME2_HEADER_DUMP));
>
> + if (i &&
>
> +     gc_cp_reg_list_11[reg].reg_offset ==
>
> +     regCP_MEC_ME1_HEADER_DUMP)
>
> + adev->gfx.ip_dump_compute_queues[index + reg] =
>
> +             RREG32(SOC15_REG_OFFSET(GC, 0,
>
> +             regCP_MEC_ME2_HEADER_DUMP));
>
> else
>
> adev->gfx.ip_dump_compute_queues[index + reg] =
>
>             RREG32(SOC15_REG_ENTRY_OFFSET(
>
> -- 
>
> 2.34.1
>

--------------A92C330A8579F29B6B6926E4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Reviewed-by: Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:Arvind.Yadav@amd.com">&lt;Arvind.Yadav@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 5/7/2025 3:05 PM, Khatri, Sunil
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB575362E1780D89A61C5324D79388A@BL1PR12MB5753.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
/* Style Definitions */
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Arial",sans-serif;
	mso-ligatures:standardcontextual;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Arial",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p
style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
        align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoPlainText"><a
              id="OWAAM0C8A7562085645E28C168F950354517D"
              href="mailto:Arvind.Yadav@amd.com" moz-do-not-send="true"><span
style="font-family:&quot;Arial&quot;,sans-serif;text-decoration:none">@Yadav,
                Arvind</span></a><o:p></o:p></p>
          <p class="MsoPlainText"><o:p> </o:p></p>
          <p class="MsoPlainText">-----Original Message-----<br>
            From: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> <br>
            Sent: Wednesday, May 7, 2025 3:00 PM<br>
            To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            Cc: Dan Carpenter <a class="moz-txt-link-rfc2396E" href="mailto:dan.carpenter@linaro.org">&lt;dan.carpenter@linaro.org&gt;</a>; Khatri,
            Sunil <a class="moz-txt-link-rfc2396E" href="mailto:Sunil.Khatri@amd.com">&lt;Sunil.Khatri@amd.com&gt;</a><br>
            Subject: [PATCH v2] drm/amdgpu: fix the indentation</p>
          <p class="MsoPlainText"><o:p> </o:p></p>
          <p class="MsoPlainText">fix the indentation<o:p></o:p></p>
          <p class="MsoPlainText">drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:6992
            gfx_v11_ip_dump<o:p></o:p></p>
          <p class="MsoPlainText"><o:p> </o:p></p>
          <p class="MsoPlainText">compiler: gcc-11 (Debian 11.3.0-12)
            11.3.0<o:p></o:p></p>
          <p class="MsoPlainText">| Reported-by: kernel test robot &lt;<a
              href="mailto:lkp@intel.com" moz-do-not-send="true"><span
                style="color:windowtext;text-decoration:none">lkp@intel.com</span></a>&gt;<o:p></o:p></p>
          <p class="MsoPlainText">| Reported-by: Dan Carpenter &lt;<a
              href="mailto:dan.carpenter@linaro.org"
              moz-do-not-send="true"><span
                style="color:windowtext;text-decoration:none">dan.carpenter@linaro.org</span></a>&gt;<o:p></o:p></p>
          <p class="MsoPlainText">| Closes: <a
              href="https://lore.kernel.org/r/202505071619.7sHTLpNg-lkp@intel.com/"
              moz-do-not-send="true">
              <span style="color:windowtext;text-decoration:none">https://lore.kernel.org/r/202505071619.7sHTLpNg-lkp@intel.com/</span></a><o:p></o:p></p>
          <p class="MsoPlainText"><o:p> </o:p></p>
          <p class="MsoPlainText">Signed-off-by: Sunil Khatri &lt;<a
              href="mailto:sunil.khatri@amd.com" moz-do-not-send="true"><span
                style="color:windowtext;text-decoration:none">sunil.khatri@amd.com</span></a>&gt;<o:p></o:p></p>
          <p class="MsoPlainText">---<o:p></o:p></p>
          <p class="MsoPlainText">drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
            | 9 ++++++---<o:p></o:p></p>
          <p class="MsoPlainText">1 file changed, 6 insertions(+), 3
            deletions(-)<o:p></o:p></p>
          <p class="MsoPlainText"><o:p> </o:p></p>
          <p class="MsoPlainText">diff --git
            a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
            b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<o:p></o:p></p>
          <p class="MsoPlainText">index 3f4ee4b3b0a4..fe21393e155d
            100644<o:p></o:p></p>
          <p class="MsoPlainText">---
            a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<o:p></o:p></p>
          <p class="MsoPlainText">+++
            b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<o:p></o:p></p>
          <p class="MsoPlainText">@@ -7094,9 +7094,12 @@ static void
            gfx_v11_ip_dump(struct amdgpu_ip_block *ip_block)<o:p></o:p></p>
          <p class="MsoPlainText">                                              
            /* ME0 is for GFX so start from 1 for CP */<o:p></o:p></p>
          <p class="MsoPlainText">                                              
            soc21_grbm_select(adev, adev-&gt;gfx.me.num_me + i, j, k,
            0);<o:p></o:p></p>
          <p class="MsoPlainText">                                              
            for (reg = 0; reg &lt; reg_count; reg++) {<o:p></o:p></p>
          <p class="MsoPlainText">-                                                          
            if (i &amp;&amp; gc_cp_reg_list_11[reg].reg_offset ==
            regCP_MEC_ME1_HEADER_DUMP)<o:p></o:p></p>
          <p class="MsoPlainText">-                                                          
            adev-&gt;gfx.ip_dump_compute_queues[index + reg] =<o:p></o:p></p>
          <p class="MsoPlainText">-                                                                      
            RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_ME2_HEADER_DUMP));<o:p></o:p></p>
          <p class="MsoPlainText">+                                                         
            if (i &amp;&amp;<o:p></o:p></p>
          <p class="MsoPlainText">+                                                         
                gc_cp_reg_list_11[reg].reg_offset ==<o:p></o:p></p>
          <p class="MsoPlainText">+                                                                     
                regCP_MEC_ME1_HEADER_DUMP)<o:p></o:p></p>
          <p class="MsoPlainText">+                                                                     
            adev-&gt;gfx.ip_dump_compute_queues[index + reg] =<o:p></o:p></p>
          <p class="MsoPlainText">+                                                                     
                        RREG32(SOC15_REG_OFFSET(GC, 0,<o:p></o:p></p>
          <p class="MsoPlainText">+                                                                     
                        regCP_MEC_ME2_HEADER_DUMP));<o:p></o:p></p>
          <p class="MsoPlainText">                                                          
            else<o:p></o:p></p>
          <p class="MsoPlainText">                                                                      
            adev-&gt;gfx.ip_dump_compute_queues[index + reg] =<o:p></o:p></p>
          <p class="MsoPlainText">                                                                      
                        RREG32(SOC15_REG_ENTRY_OFFSET(<o:p></o:p></p>
          <p class="MsoPlainText">-- <o:p></o:p></p>
          <p class="MsoPlainText">2.34.1<o:p></o:p></p>
          <p class="MsoPlainText"><o:p> </o:p></p>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------A92C330A8579F29B6B6926E4--
