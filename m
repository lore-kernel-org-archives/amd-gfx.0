Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4F4D41D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 18:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D2710E80E;
	Thu, 11 Dec 2025 18:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZG26ouAi";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCF510E80E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 18:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp7vLbOBm9rJHwixxSHKPD3c5VAeBTwjXflgbR2OE0PUa4mhpS0/BMTXGwc20k11MPeB22joYbOMx/2zZl8E27eJq7CR2XIPL1nHHFbQ4RtEYzVPLAZ2tFT7yQhEzojRUZWcIId+D2STaMmismroWLZLJZzMiobUzZQ7mCJP5oqbLkSrnmQ8XHub1QaAC22sO8hhHZYTdcy2ttj7jqaG4YnwlJZvNR+amtN5q2rC1F+DJVqwk+KM+c9l0BbYy/l6OyqoGiyT6EkbuD8/yKuRgmLtoHklddNuGnXzhKj+MoECZ+Lp1FzfTCxX21RpcbJfEzhLhXq/1947DhuWtifVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFb5Zf8AXV+aQEmkST4JzMRpO2RWKaHVFV3YSBG5RQ4=;
 b=kw+eAtRJhfLMG+V9YAK9dqV/d+gmO5Rq8OW0dy4oRULJ1sQKeY6d3yqp5GfwS7CtZYN7FUvUaKiKI2NeWyd2UIamp5xbMygvh2w2VwC51hptLdTdHVTa4drrjAjcezTULBXrlxetejH+poX1w4nqyWTeg25s1Un3G+wOChRu364dflifmHY0YTb+UzfwEVIbNwwG3GNi+Go9YZKGgf6b/0UWQ5V2LHIPvi2nZUlx+U38SywXYyPeP8XqjY8PwY3Gij5qWrRKfceHLBiWs5qgyd2JLISNB9Z1ZB4+eIy1vZXLNLAwAJwwj4ZUK61JrDQ1H/dTJwmM7CcRICwEATBK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFb5Zf8AXV+aQEmkST4JzMRpO2RWKaHVFV3YSBG5RQ4=;
 b=ZG26ouAioytQS/Dj3YPrM4gkFnJ+B+qWGw6f/2GelI8UdVEFXnh4josH2mSqO+gpa8KgokVj08/Yg+CyQmbkpGoYTGYsU+wOwT8Z7hatVADtfBj5exJ9NDJ2Z9Wbml5gVuIJiG9HJY7/pmt6Zho0x3u/Fp7Hoi592df3x1Wqmq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 18:44:22 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d%3]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 18:44:22 +0000
Message-ID: <0b0eb821-0130-43c6-88f3-8233cc5f9084@amd.com>
Date: Thu, 11 Dec 2025 13:44:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
 <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
 <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
 <03db9561-f7e4-4157-95b3-7d32bdafe15f@amd.com>
 <772c2e4c-86b6-4200-9cbf-696e4652a6c0@amd.com>
In-Reply-To: <772c2e4c-86b6-4200-9cbf-696e4652a6c0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::27) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6b76bc-7418-42c5-2465-08de38e54d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHRmcTJsR2toN0wzckZsaEpzTWtrNmJXMEpKT3VwazNIbFBwcHc1aG1OZnJT?=
 =?utf-8?B?ZUFHOGZoMTBSZWxLNDl2SDcvL003eXVYNS9DVDZ5M1JmR2JUSzQ3YlBJM3Zs?=
 =?utf-8?B?bURmWGNiR1pBa0d5L3ZNOGVLZnBHbnlSTGMrK1Fjb3VHcXVEbS9tYjNiQTFx?=
 =?utf-8?B?aWdZMFBGdDJ1TzQvOXN4VUNvMS83TmZKcG5QVHczTlp0YmIwblJJaDBNS1RH?=
 =?utf-8?B?R1VEdDExV2VSNVZWMUx4aGpveEJZeE1oU2JBbTlCUHJrMHEwTTcrUHdKcVds?=
 =?utf-8?B?NmpkSG9aMGNiREhKbis2ZDBtblVpK2hFTGhIUjcrbzlRVXRZK2tYZmJUZytY?=
 =?utf-8?B?MWJhS1I3QTNobXN3MTJzbEpkckF5ZFB4WFI5TS9qcHowekZQTUNKMEhtUmRJ?=
 =?utf-8?B?SnRLcFBkVUtmYThRUlpySTdNQStzbzJjSVNCZktLdmlDWUZRV1ZDd2JqL2Js?=
 =?utf-8?B?UlgzQUdCaGJTMWRxSThxMms4ekUzT09nUFNwaXhCVlNrdWdNYWthQnU1K0Iy?=
 =?utf-8?B?c3lYalVZTGhIMnVPSnJWTjI4MmN1OW9zNDE0VVNOdm95Ly9pc2QyQlp5Nk04?=
 =?utf-8?B?M3RtNGtpV2R5KzBsSk0zNy9jYVlxM2M1Z1RUK3MrZzA5R0pSNWpwei85Y05C?=
 =?utf-8?B?M2Ivck0wT2QrSGthZGtYTmVPeHU1dDF0MW02cVdlcXNRTWludzlwWHBHQXoz?=
 =?utf-8?B?Zk1LekxDaEJmQS9mcldTcVpYMVh2TTh6Rzg1SlJ6b0YrK0gxLy9UZ3YzVlg0?=
 =?utf-8?B?N3FoUVJIZVc0M2U2WWNwZ25aSzFWdEpjdHdZcjIreVJYNERNR2lpODdsRHNP?=
 =?utf-8?B?ZkV1SEU2SVJwOTFwN1FDdG11SHo3cFpFbHBxTUdEcFhDdmdaWi9aZ2ZjaCt4?=
 =?utf-8?B?Rm05MDBrYlRsMEZSOFRvci9yaE1tUU1qbVpoWjVlbmJiM1o3b2FjSDN2Z0Nh?=
 =?utf-8?B?SDUzNG1aQWpCS3FZeFFxalV4bklGYzBZK0tEVmZPU2RTaG9Kdk9VM0I3NGR6?=
 =?utf-8?B?WVAvNjczdUg3Z2RFdnRiTHFIa2FwQVVwMVFSS0llSlZHNnZySW9hZVRnODlU?=
 =?utf-8?B?eFZhdkNvZThhR0ZtMXQ1NHM2c0RVb2tQQ0FuWHVKYjVxK0hSVVdEQ3krSlVS?=
 =?utf-8?B?TnpkWTRuQ3lRQnpjN3VTelgxREQ2WFArZGxReWxyREVlOU5MZzRoWGFLYXVJ?=
 =?utf-8?B?WVNhdSswUkRFVzFtamlDWmw3bGRzaGhMTnR4TVFvRjVRbzdhZjlMRW8rZ1JQ?=
 =?utf-8?B?OFpUTGJNUVFCak1KTFFZdHcvM0JqNjZoaEZ4UFg0N0lSdEZycVAvNmdPaWNU?=
 =?utf-8?B?SzlrK2tkLzIxY0UzNGFPU2JVdFI4ai85UW8vUmFrcVRmVWZzWlBCeStOb1J6?=
 =?utf-8?B?QkNYZm1GemxjZzk0VHNTSHJIOVBKL3hJVzFsTUl2MS9ia1lYY0c4am1kQXJk?=
 =?utf-8?B?UnVkbkEvWnRSbGk4a1EzMVdVL2Y2djdwTGtpbHJqVUdkbHpYR1VqN2tsb1Vt?=
 =?utf-8?B?R0F5bzM0bGRKYXJXekNuZHBtYS9iV2d6eHRvSWxWRS9lRk11ekp3aHd6U25Z?=
 =?utf-8?B?NXFQcXVaaGsrdUZpeUtxNG5OdW9qRWt4QVNRUlBWM3hlT3NZeFdxK3pLY01J?=
 =?utf-8?B?RnFTbzNJamxuMlFqMnRJNnJRcGxVWVZNT2lYMHJMVnBXVFkxZCsyaTIvQXA5?=
 =?utf-8?B?R0MvRWt5MGNvKzFhSzlZcHlpeDV6MzY4REEzTWlyc2ZjL1J6Y01FS01QanE4?=
 =?utf-8?B?NE0xaDFRYVhQVVhqZ3hJdVk5dnBMQ0JtdXBsaTJYN1FSTmh2T0FrZ0srdjlx?=
 =?utf-8?B?dXZFMnlRdEppQ0U5R0tPSmgvMllBT2IwcTFHblpNN2pkUjlPT2xSb0thZEM3?=
 =?utf-8?B?WUFHV3VRVUNGdEZ0eVhxUFlKM1VvWmE0YWtlK3VzbmdwcXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZsN3oyNllYeVhEemJrbWNQdmlsV3VhUjZUamp1cHNsYnJFcmFHc1hqZjhT?=
 =?utf-8?B?aFBSZm14d1F2RDEyYWNnTGJucms0SncvK0dqcU9zVVZ4c3B4cDk4SDZxTExm?=
 =?utf-8?B?K2pRWmdROEJXOUh6NzVNZC81NExZR0ZCaGtoWkxCcWs1ZlFIWTJ6MG95bFBh?=
 =?utf-8?B?WGtRVWNEM3ZjNkp5ZXI3SEh6ZmlqM1F3Rm1tbVRXKzlMR0Jab2ZKM2R6cGth?=
 =?utf-8?B?U2FPamxvNFQ0eEtDOWxLek81QitiVGZSRHc2bzJPVzhta2ZycnFEQnNHSlVr?=
 =?utf-8?B?dTFvVDNyalFkb1JETFNqdXJHTmhBV29tWjh4SHV6VEc1a2RjT0F0OElaeVZr?=
 =?utf-8?B?VFhiSGxNWU9nU2N1cFA1ZFBIUlhYa2FVY1JpWGZDS2xwaGxOSzdBejk5OThh?=
 =?utf-8?B?bDJHYVZ5MUlqbTEyaFE1OFJmZlNFdHFqUHJnKzFzYm1NTWU4VXU5bHFQZ0d1?=
 =?utf-8?B?WWFkTlorNy9xc1djMXEyczA0U1dNYWZ6RXFYMEYxWmNTWE9MNFk3Nnhkd3BS?=
 =?utf-8?B?MmNOQkUrWUk3T1UvNEpHLzZGUG03RzE5K1lrZStVWFBFd3UzTE1EQnVUOEtw?=
 =?utf-8?B?R0pOVzR5aHFXNGdBYXJsbERQNHRCbyszQkh3VVh5SWc4RXdjbWVCY1BFU1F2?=
 =?utf-8?B?ZDFOUk9mWnZPQWxRTE9NOEx4OHo1cVJiaE13elVFZjQrVkJQcEo5RmxaOXFj?=
 =?utf-8?B?MTZLQUlnS3gxWXhiRDE0WWRSLzRybkx5bFhERjBSZzBYT0ZtUmcwVm1jKzJw?=
 =?utf-8?B?eWY4dy9pRnpraEZ1U0ZyTUlDWVRIV1F2SzEyQmcvQ2xCMEV2d2hnejNPZW5J?=
 =?utf-8?B?MnJVazdGV3lRM2ZWV0lGV3ozeWF3bmFnZXVnSHpRUjFuWTI1R21uVCtieGsv?=
 =?utf-8?B?ZlpSbXNBd2JyaHNMR2c4R1UvMUR0ZWN3N2hCMTRwV1NKM2pqMG1oMzNxVUNI?=
 =?utf-8?B?ZGNQd21HeWpvN0RsZjR4Z1lmczdLa1hXM0pJNjVIeFB4T0xLOCtTd3dqRHNp?=
 =?utf-8?B?UDMwa0QydHpta2pzbkp3aWlUUVZiRkRLdlhIVG9IYmovMEtQMlFMQzJVNlM5?=
 =?utf-8?B?WXlpa2p0WHN5OWRjdUpOejBaMnRENkZzTzJZVXB3VjdkT0IvNXdlS0dyT0RC?=
 =?utf-8?B?Q2RHeEZoSzlnSXRpak9ZV2JsZWxZcDZoUTljQXB4dlQ0RkEzajVWbXIyQ2FW?=
 =?utf-8?B?R1NmRkF0WnllejhJVXRDbDU3Zjh0YnNWdUx6ZGp3Z0VBSkcvS2hVeWNrL3BK?=
 =?utf-8?B?ck5EeGpnZWJzYThvVlltaEYvdmhvYmZ3VXRRY0lMNGd5NTMyL0o0emdLY2xU?=
 =?utf-8?B?OFZYT2huMG9BUDNVbHZhaVRDYUZUaWhFbXllMVg2NmhPWmgrRnAyUkZ1STR6?=
 =?utf-8?B?UnhJUEJWUWVwV1RFVExHdXc4NGhQZjdGUlpBVmVPbkt3a3gxZWp4N3dBSTNa?=
 =?utf-8?B?ZjQ3ajVTNjJiQUdacndpVjFXNWc1cWx3SDNVbGE2K29JRWJreEpxVzRjbStH?=
 =?utf-8?B?bE5CVUluZWRLSFdwaE5TRktNVFcvZnFEVzFOd00rNTJMMHJNb29kYUhsaFho?=
 =?utf-8?B?a1NLUXgxY3I1aW1YM2VCb2FGdVF0TGsxajFiSVRvWmJzbFdaalBMdHJYZXMw?=
 =?utf-8?B?b3pjWnljSHN4QnZEMFRTS21pdDFlQWM5aFp4NFh1am52RGNkbWplQ0NXZW5Q?=
 =?utf-8?B?NU9ZeGZ2a3BsZFdIYUo4QmVRTDlYNU1kMTBWSk1vN0hTSTYxMEdyUWNKQmNO?=
 =?utf-8?B?UzZCMm1uS3BRTkkvZ1BWZ1J4NU9MNTN3K0hHOVQzb2dQb01saHBKRksxeWF2?=
 =?utf-8?B?dXRodkRVT2ZEQjE3OGFUOFBZZnQvVG1EcVBMV1RETStFRVlFbFRnV0RoNTVs?=
 =?utf-8?B?UGU5cEN0dzZwa3lURU9PbWpJL1Z6S3ZqT1lwZkVoVWtSZG50cVpBZEdLbENK?=
 =?utf-8?B?K09xdTUzVmdqREpZaGJqMmc1SzlVRzBmMnQ3TlluZW5PMVRQdVFDZ1pjYXNF?=
 =?utf-8?B?aUljdmdmcTBTb0N3TzRONmY2aEhza09lcGtFcWdncUlRUXc3ZWlhNzI3cUFU?=
 =?utf-8?B?WWJGT01iNVJXa3dRK3A3RXRzMHFKTjZTTUFRVk5lTHZWWEVia0orU1Q5MzBl?=
 =?utf-8?Q?Z+Xd1e0d8Bt+skXZoupgzuDJ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6b76bc-7418-42c5-2465-08de38e54d14
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 18:44:22.7329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE1D1UG5uZ9axH6dW98PxagwMQ0L6t9Wnqmu8dYS1Hlge3DUlWEGqrVqJaRz9J27bPeplahEWvG5mC2Vx2T/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

Hi Mario,

On 12/10/2025 11:01 PM, Nirujogi, Pratap wrote:
>
> On 12/10/2025 9:19 PM, Mario Limonciello wrote:
>>
>>
>> On 12/10/2025 5:13 PM, Nirujogi, Pratap wrote:
>>> Hi Mario,
>>>
>>> On 12/9/2025 10:28 PM, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
>>>>> ISP mfd child devices are using genpd and the system suspend-resume
>>>>> operations between genpd and amdgpu parent device which uses only
>>>>> runtime suspend-resume are not in sync.
>>>>>
>>>>> Linux power manager during suspend-resume resuming the genpd devices
>>>>> earlier than the amdgpu parent device. This is resulting in the below
>>>>> warning as SMU is in suspended state when genpd attempts to resume 
>>>>> ISP.
>>>>>
>>>>> WARNING: CPU: 13 PID: 5435 at 
>>>>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/ amdgpu_smu.c:398 
>>>>> smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
>>>>>
>>>>> To fix this warning isp suspend-resume is handled as part of amdgpu
>>>>> parent device suspend-resume instead of genpd sequence. Each ISP MFD
>>>>> child device is marked as dev_pm_syscore_device to skip genpd
>>>>> suspend-resume and use pm_runtime_force api's to suspend-resume
>>>>> the devices when callbacks from amdgpu are received.
>>>>>
>>>>> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
>>>>> Signed-off-by: Bin Du <bin.du@amd.com>
>>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>>
>>>> Who is the patch author?  If you guys worked together, there should 
>>>> be Co-developed-by tags to represent it.
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
>>>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 
>>>>> +++++++++++++++++++++++++
>>>>>   3 files changed, 85 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_isp.c
>>>>> index 37270c4dab8d..532f83d783d1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, 
>>>>> u64 *gpu_addr, void **cpu_addr)
>>>>>   }
>>>>>   EXPORT_SYMBOL(isp_kernel_buffer_free);
>>>>>   +static int isp_resume(struct amdgpu_ip_block *ip_block)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>>> +    struct amdgpu_isp *isp = &adev->isp;
>>>>> +
>>>>> +    if (isp->funcs->hw_resume)
>>>>> +        return isp->funcs->hw_resume(isp);
>>>>> +
>>>>> +    return -ENODEV;
>>>>> +}
>>>>> +
>>>>> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>>> +    struct amdgpu_isp *isp = &adev->isp;
>>>>> +
>>>>> +    if (isp->funcs->hw_suspend)
>>>>> +        return isp->funcs->hw_suspend(isp);
>>>>> +
>>>>> +    return -ENODEV;
>>>>> +}
>>>>> +
>>>>>   static const struct amd_ip_funcs isp_ip_funcs = {
>>>>>       .name = "isp_ip",
>>>>>       .early_init = isp_early_init,
>>>>>       .hw_init = isp_hw_init,
>>>>>       .hw_fini = isp_hw_fini,
>>>>>       .is_idle = isp_is_idle,
>>>>> +    .suspend = isp_suspend,
>>>>> +    .resume = isp_resume,
>>>>>       .set_clockgating_state = isp_set_clockgating_state,
>>>>>       .set_powergating_state = isp_set_powergating_state,
>>>>>   };
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h 
>>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_isp.h
>>>>> index d6f4ffa4c97c..9a5d2b1dff9e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>>>> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>>>>>   struct isp_funcs {
>>>>>       int (*hw_init)(struct amdgpu_isp *isp);
>>>>>       int (*hw_fini)(struct amdgpu_isp *isp);
>>>>> +    int (*hw_suspend)(struct amdgpu_isp *isp);
>>>>> +    int (*hw_resume)(struct amdgpu_isp *isp);
>>>>>   };
>>>>>     struct amdgpu_isp {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c 
>>>>> b/drivers/gpu/ drm/amd/amdgpu/isp_v4_1_1.c
>>>>> index 4258d3e0b706..560c398e14fc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> @@ -26,6 +26,7 @@
>>>>>    */
>>>>>     #include <linux/gpio/machine.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>>   #include "amdgpu.h"
>>>>>   #include "isp_v4_1_1.h"
>>>>>   @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct 
>>>>> device *dev, void *data)
>>>>>           return -ENODEV;
>>>>>       }
>>>>>   +    /* The devcies will be managed by the pm ops from the 
>>>>> parent */
>>>>
>>>> devices
>>>>
>>>>> +    dev_pm_syscore_device(dev, true);
>>>>> +
>>>>>   exit:
>>>>>       /* Continue to add */
>>>>>       return 0;
>>>>> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct 
>>>>> device *dev, void *data)
>>>>>           drm_err(&adev->ddev, "Failed to remove dev from genpd 
>>>>> %d\n", ret);
>>>>>           return -ENODEV;
>>>>>       }
>>>>> +    dev_pm_syscore_device(dev, false);
>>>>>     exit:
>>>>>       /* Continue to remove */
>>>>>       return 0;
>>>>>   }
>>>>>   +static int isp_suspend_device(struct device *dev, void *data)
>>>>> +{
>>>>> +    struct platform_device *pdev = container_of(dev, struct 
>>>>> platform_device, dev);
>>>>> +
>>>>> +    if (!dev->type || !dev->type->name)
>>>>> +        return 0;
>>>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>>>> +        return 0;
>>>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>>>> +        return 0;
>>>>
>>>> Could we store the mfd_cell pointer instead and just compare the 
>>>> pointers?
>>>
>>> I don't think I can do a pointer comparision to identify the correct 
>>> mfd_cell, string comparision seems like required in this case.
>>>
>>> Its because when isp mfd child devices are created using 
>>> mfd_add_hotplug_devices(), it is not returning the pdev or mfd_cell 
>>> handles
>>> to store in the amdgpu_isp and later use in suspend/resume to 
>>> compare with incoming pdev->mfd_cell to detect the correct the device.
>>>
>>> The mfd-core is doing a kmemdup of mfd_cells data passed to 
>>> mfd_add_hotplug_devices() to create the platform device.
>>>
>>> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L163 
>>>
>>>
>>> I'm considering to add this function to check for valid isp mfd 
>>> child devices that are allowed to do suspend-resume, this can 
>>> minimize the checks, but still cannot eliminate the string 
>>> comparsion, please let us know your thoughts.
>>
>> Well actually is a check needed at all?
>>
>> isp_v4_1_1_hw_suspend() calls device_for_each_child(isp->parent) 
>> which is a platform device. Are there other children below that 
>> platform device?
>>
>> The platform device was made explicitly for this purpose wasn't it?  
>> So maybe drop the check overall?
>
> yes, there are more children than the 3 isp mfd devices. Below is the 
> list:
>
> child-1: mfd_device (amd_isp_capture)
> child-2: mfd_device (amd_isp_i2c_designware)
> child-3: mfd_device (amdisp-pinctrl)
> child-4: drm_minor
> child-5: drm_minor
>
> Without the check, suspend-resume will be called for every child of 
> amdgpu.
>
> We intend to call suspend-resume only for child-1 and 2 as these are 
> the only devices registered with genpd to control ISP power.
>
> I did a quick test removing the checks, device failed to wake up from 
> resume, I can recheck and update if it is safe to remove the checks.
>
> Thanks,
>
> Pratap
>
Thank you. It works fine on removing all the checks. pm_runtime is able 
to handle well even if called for all child devices. yesterday's issue 
was because of a logging error at my end. Will remove the checks in the 
next version.

Thanks,

Pratap

>>
>>>
>>> static bool is_valid_mfd_device(struct platform_device *pdev)
>>> {
>>>      const struct mfd_cell *mc = mfd_get_cell(pdev);
>>>      if (!mc)
>>>          return false;
>>>      if (!strncmp(mc->name, "amdisp-pinctrl", 14))
>>>          return false;
>>>      return true;
>>> }
>>>
>>> Thanks,
>>>
>>> Pratap
>>>
>>>>
>>>>> +
>>>>> +    return pm_runtime_force_suspend(dev);
>>>>> +}
>>>>> +
>>>>> +static int isp_resume_device(struct device *dev, void *data)
>>>>> +{
>>>>> +    struct platform_device *pdev = container_of(dev, struct 
>>>>> platform_device, dev);
>>>>> +
>>>>> +    if (!dev->type || !dev->type->name)
>>>>> +        return 0;
>>>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>>>> +        return 0;
>>>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>>>> +        return 0;
>>>>
>>>> same comment as above
>>>>
>>>>> +
>>>>> +    return pm_runtime_force_resume(dev);
>>>>> +}
>>>>> +
>>>>> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
>>>>> +{
>>>>> +    int r;
>>>>> +
>>>>> +    r = device_for_each_child(isp->parent, NULL,
>>>>> +                  isp_suspend_device);
>>>>> +    if (r)
>>>>> +        dev_err(isp->parent, "failed to suspend hw devices 
>>>>> (%d)\n", r);
>>>>> +
>>>>> +    return 0;
>>>>
>>>> Shouldn't you return r?
>>>>
>>>>> +}
>>>>> +
>>>>> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
>>>>> +{
>>>>> +    int r;
>>>>> +
>>>>> +    r = device_for_each_child(isp->parent, NULL,
>>>>> +                  isp_resume_device);
>>>>> +    if (r)
>>>>> +        dev_err(isp->parent, "failed to resume hw device (%d)\n", 
>>>>> r);
>>>>> +
>>>>> +    return 0;
>>>>
>>>> Shouldn't you return r?
>>>>
>>>>> +}
>>>>> +
>>>>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>>>>   {
>>>>>       const struct software_node *amd_camera_node, *isp4_node;
>>>>> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct 
>>>>> amdgpu_isp *isp)
>>>>>   static const struct isp_funcs isp_v4_1_1_funcs = {
>>>>>       .hw_init = isp_v4_1_1_hw_init,
>>>>>       .hw_fini = isp_v4_1_1_hw_fini,
>>>>> +    .hw_suspend = isp_v4_1_1_hw_suspend,
>>>>> +    .hw_resume = isp_v4_1_1_hw_resume,
>>>>>   };
>>>>>     void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
>>>>
>>
