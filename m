Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7343E9A048
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 14:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F8D10E025;
	Thu, 19 Feb 2026 14:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KuHkuO6Y";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5FC10E025
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 14:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ3KAm+OQKlsMf9n75Ef6q+OJnzrkqU7HGHAx1k6ZPQ5M8UNY8iDTawkCchw4QLjOMEhI88RBgtwXzV2vS99ET4MDkYZIl7ZLRsQ9vRNjIX0A1PmEa3CyEBfUdL+rGQ3161tKuA8FmvAcucQKMyPmlDF22KGDYOJt1KszLwNTz3VTUOVB+X/x+W8H7QdbmjlpNixUGi67xWqRXoJvuHso0i9nfL7hPtU5Uo/QdBWp856GrUcCPoNsQ+Re2YYQlkDRZq0+TxcN35QWtyC9Z3qg5txYwhPD0VQb5OXLDMxzhYefcWVVzre9rvk+nzz4RCxeQeS7iqRGGJKQuuPOe1ToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaDFDKHROKMQziYE/D6he5we3bRMr8OI8sJtCDeAF7s=;
 b=DJd0WdJuI0aE9hbjFvmS1i3rtoMpW39atFmOpoKyhbaGCWum2xHBKQllObx6wL+JeQtawZo9LBMeQ0a0f4eVx8ifjfSZ4v7zMtnV9IoftfC2aSkoMnEZ5zR9VkpOwrXejEl6hcqg/BGupElzI61ddsTMF4JOKrCDA2jLZFPpYBoBAj0ldCJCOSAqPod1h/huQvfeFdNf52Urp3EhcBubnAk2Ma/CQE/5Qni4Qffu0FCQC9bFw4ikfm7UYL+9v6hwaWqL5EVekN7dtNEFVIn9t2yKCyJoKjI22ywz9rkrptGLxtl6hOyDwzneEc66EOnKRhcwcSm3WMT+Oo7qqHquRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaDFDKHROKMQziYE/D6he5we3bRMr8OI8sJtCDeAF7s=;
 b=KuHkuO6YHDEKF+ZrhsdzufJN0jd7G/BhiUnvchrTX4mxjCRPsMp4r4gUxiJ14hUdWTfQOH/jSpJqu2+UIATJO6P7TcgW+DXgPPqy7MtqrqE6T2Ks+LE26ANklY5JkFwb+UjkuIkhvZd4GB8HtoG76Wh8qeEB5OYC2AzTandY1SU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 14:31:19 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 14:31:19 +0000
Message-ID: <3f1c28cb-9f3f-448d-8812-d0a53ee5f28a@amd.com>
Date: Thu, 19 Feb 2026 07:31:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add atomfirmware cap for DP++ Type2
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Nevenko Stupar <nevenko.stupar@amd.com>
References: <20260218205611.2539493-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260218205611.2539493-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: edcf1554-aea7-494e-f064-08de6fc38c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzZ5Zks4M2pxRDhKdGhRSm9iRVVaLzUyM1NUSHdOODdQNmJHWVRzakk4M1kw?=
 =?utf-8?B?UHJ5eFpkMmNFQkdDME00Y0JaY1M2NXVFcW55NTl4SHN5TVRNQlBFU25xc2Zp?=
 =?utf-8?B?NW1NTk04eDFYMGlOTmxwQzBNNFJndnF5TnZkbW83MS9ETHAyVEp3ZGF6cUxG?=
 =?utf-8?B?YjE3eUpkMXdEbWV1MDBmbUc1d2lPb29aQ1IvUEtQVzZ2emx4TG5PeDFhYnpj?=
 =?utf-8?B?VVFhaVJteVJ3MzJLaDZsSkRKSE9ZeW5mbDhGSHB2TXJGQndhT0x3MDRnT0NL?=
 =?utf-8?B?dVFLQlBWQ2ZheWdIWHdSR2c4WWpZeW1UT25VWkNNK3V4SkFZSFBWTEROWWFZ?=
 =?utf-8?B?YXFvckozWE1aU000cDRjZWw0OHJ0eVVET0VGejk0WWdZRW5pakljZitrVXdl?=
 =?utf-8?B?M0V6b3JhaXlDZVpQSWdUVG4yTmtwOXlsNWhFRVhNQjRURnEyU01oSHNoZXZt?=
 =?utf-8?B?RjNabU9Uc1Q2ZStGcHBRTFFWeEM1dzZ6SHlmSFZiOWdDTEg1bTBUSUY5ZmtR?=
 =?utf-8?B?V3JRMDlCM292UWs3SmlUTWFabktZbFk3S3Mzd3VBZnZ6MmhrMHY2TVN3WHdX?=
 =?utf-8?B?Qk52d1pna2xrcFBxS3RMK3Z4VmZPcEt5R2llY2QvbFZJRUUrVXF2RmFzR09l?=
 =?utf-8?B?V212b2tqQUU4Yjg3QlBJcFpYTXNLYU90S3NqT2tLVkx3WTJUSC9nNTIxRmdx?=
 =?utf-8?B?NVh3VGVid1ZzUFFpQS81Qytka3MrWFVtTklYZE5xNW9nQmJzbWVBU2FmWVlj?=
 =?utf-8?B?YmJiQ2VTdVRhY0FBZWxHR3dHNythSFpwd2trTW90SlpYcjJlK2ZreERKSENp?=
 =?utf-8?B?MHF6VENySlhNUHg4ejJFdFZjWDk1TSt0SFRmYzdOSkpRS3JydFNJY2NqWThz?=
 =?utf-8?B?K1dZaXJCcjM2NTMrSTdmODhnZmdIMTMzQmNOK29rWHBXMjNYaEhHMUUxeGRP?=
 =?utf-8?B?MFcxN3g4MW10dVdjQ0ZGUVNLR3ZCbjJmR01aS1R3NENMU0NzbGZReU90dXJx?=
 =?utf-8?B?alRGU3JRZFVDRUgraFNYOENmU0JIQXN4QnpYWXFSWFpIV1oxYk9JNGZjRlBz?=
 =?utf-8?B?VlNYYThIeU1oclJhaWtITUMrOEtDdTdlaisyZlJjYnI0VTRPamtET3A4YkRu?=
 =?utf-8?B?UW1ML3NXSzRwNTd4ZFg0N2RHTXBiNi9SQlovQk1HUVlZQXBGY1o3QzczZ3F5?=
 =?utf-8?B?eW1ZaDNTVW5ZWCs5dDhjcjkvTjVIcG0vZS9ka0tvdTFJeE5yQnplRy9WeUQr?=
 =?utf-8?B?aFY0bHRyTkdTRTV2Z2pUQXltcllDTjJaNzJKYTFXZmRIZGdRR0ZvVzQ2Yyta?=
 =?utf-8?B?UVRuQVBSYWVDU1NaQTA3Z1g5dnkxS2UxTHFIRndXaGt1ZkFBdnlJMXRYRXhi?=
 =?utf-8?B?M0VLbnZ2ZzRLM3dxM2hvb1NjMDM3RXQwRTZEUjhCK2tsVnl4WURxcy9BS3BH?=
 =?utf-8?B?QTJlNEVOZTVKUDcwZGx2YTVzbnpBR1JIaFBLY1RFbUM4dXlVMlMyejhLUkQ1?=
 =?utf-8?B?TnJvRmk1ZHNJekEzWVlteFZ1RlV4UjF5UE92bjZBallSNzcxbHJIOEVLbVRT?=
 =?utf-8?B?TWw2Qkx1VTE5NnU5aU9pelFEUzBlMFVlSjZSVkZLUlFDZ1R2YnhDMUFXeVM2?=
 =?utf-8?B?RTQ2cmNsQVhBOTZNd3U4NndxK3AzaWVJSFBUdzdCMEU2L3BKWmhySmdTRy8y?=
 =?utf-8?B?UEVrTWVjcjRJaGtVbkRzQXJMWm1aMDY5aHRXU2RYR2lEU1B2QndoZk83SkhM?=
 =?utf-8?B?ckNhV3AwdkZMSVBTSlcyZTVlYmhFeUdNaFd4RTMvRTExVHZtOU96VGhOUVFB?=
 =?utf-8?B?TTJnclpsSzFkbmRUd3FLdk0wTnVBVitJdE1maDl2KzV6SlUwTWxSazFGdGZ6?=
 =?utf-8?B?SjcyTkNmaWsyOVNxb3NyVlR4R0NPN0pqRURjeE10QmtpVWpFSldyWTRSZmhF?=
 =?utf-8?B?OUJBendDN1dvUCtuQ24xNGVYMEVPSTEvRm1STFIxb2U1Yy9XY1kyVEwvMENP?=
 =?utf-8?B?YmtlM2dvN0hibHFjN0Fra21RMzRLZCs4blZ5UkVRb3pwRzJ4R3BDTTkwdURu?=
 =?utf-8?B?VERpeFJwM2NYYkJLTkZ4SFd2NVJmR3BLVFZaOVVXOGhMMlNtZGVHdk5ML1Rm?=
 =?utf-8?Q?p2fc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW4xOGpucUxFSFRyOHBSeTlYR1JaRFlPbjVaRzBlSEhDWm54NEdvWUxpcVNw?=
 =?utf-8?B?YmNsYVJyUzJEWVJ3d3lTRTZHdGFMeGhQRGtXejRpSlN3V0JTb0ZpeHB0dmMr?=
 =?utf-8?B?VGpRV1dNdnk2YXpKVzRKc3dUMVo1dm9qMCtVOUJ1dVJkS3VPdDgxZ0xrZHRQ?=
 =?utf-8?B?QklvVmx3QitHOFJ6a05QM3dhTXBoVWNtdk5raHN3QU5oWkVSTjYySWNlTDUz?=
 =?utf-8?B?aDV3cmlYdWs5T2tuN2lXajJGZVVTQW1ramIxVm5pdFBBQ0c3NzMydFU3TmpV?=
 =?utf-8?B?b3dVNUV3ZnBNUzd6clBWdWx6S3c2d3RSWjQ4RGNYR2hUQ1h0eVMvUW9YbzI0?=
 =?utf-8?B?eHJWL09mVUdKdzRJOWtENHFFNm5CQ1JBa0FiSEhJWDc0cUsyNHdNZXJlK01O?=
 =?utf-8?B?TUN4OXlwSXMveGJUODAwQlFMMmYvN21yWndLQnd0bVNtL1d1cW9oblljbWJ4?=
 =?utf-8?B?bHJ0WXZYUDJ3NEVSNnVLZkd6ZmdSZ05UTVcyVm9iWVhrVDd3dkdyUERLMmxJ?=
 =?utf-8?B?dmg2c29KNEhXa2JYMTVlWXFZamVkTXc0aVFGMlV0YUNBU0hOQ2JjMUI5MVh4?=
 =?utf-8?B?bjRrR1FTVlFMSjAybys4RGp0NUNHUDhFNmd4TFRFUE5sTW5xcXVwR2JZVjBx?=
 =?utf-8?B?eFMyM0Fya0VNTHduMEQvL1FGUDRQaTNvN0IvR0hYN1lkcG9LVnpvWXg2R1Fr?=
 =?utf-8?B?bEdkdUc0M0Vsc0ttc0grVmwzR01ZNGxvUWtKd1g5em1FRnEyektWNmgvK0h3?=
 =?utf-8?B?RFFMQjg3TjBTam1TZEM4VVpLSkRuMEh2Qko4aU44MEx1WHlwVFVhNmg3OU5j?=
 =?utf-8?B?M1c4RExyNm1HZEZGZGZoNmhvbFlOMWthTDhlNURweEhHbGJxN2hDT2lJYTRq?=
 =?utf-8?B?a1dRM1V0d0E4TURFM0RPaGtpTHVNdVREa1BtZ2ttK3BGVjh2ZXhlMyt0K1hL?=
 =?utf-8?B?SmpMNzBwQ3oyNzNTVC9GeG5DV3pTRmgvbDBGU3FlaHNGZllUcHhaeHkzMnlk?=
 =?utf-8?B?a09pRm1EWXJ2UjVUWXFzT1ZXRzFtUXpBdzA0MWNKOWdzeStsYkxPZVpVL0NQ?=
 =?utf-8?B?b3VxV3AvQWJqU2NJM3ZRRExpNEZjZFRLdGp2bkxMNi9hREVOTnMydlZXMllE?=
 =?utf-8?B?TTFOTXVheFFiUGZvb1lpRm9ScTBDRmoyUjg3YkRFc1RmU05kVkg4aEY5dDcy?=
 =?utf-8?B?ZnlLUGNYYkNEWFJYRjU5aUhqNWVKZ2FUUk1OaHpUbXV1S01zWi9SSnZEajFW?=
 =?utf-8?B?b2JjVnZnT3RjK09RVlM5bWVDSGRGdjc3b216TDZkVFBqUy9ZeHZTb0YrL083?=
 =?utf-8?B?SUJHa29pTm1nRnM1RFNyc08xWU9XMkZIV3Y2RXdzeXlWeHJOMS9BQ3dwRTFP?=
 =?utf-8?B?OWYzZWY5alpjUUdFeFJ4eUFmZUlrUnRHQ1k5ZnRCU3U3dG0wMkVUVGd1VW9m?=
 =?utf-8?B?RlZFM1NEMVlTSVc5bEpoaGNXSDE1YU5RaUNFbitsU2hIMHJFTDhsZkh6V2dG?=
 =?utf-8?B?dGdvTnFlUHJJcStFS2c3Y0U1bG1BODBTWHRIcmluQTdHeWVSb0Nzbnpobmhq?=
 =?utf-8?B?NWFMNTlGQ0dFWGVaU2hwbnJpYXgxM2p5ZnFObTJFV0t0TlU2cnlpRkdhODdL?=
 =?utf-8?B?aDc3Tk9OWTJLV04zM2xhdzI1d0syczk4RUxBT0NyZXdETG9HbmRIdHBkaEEv?=
 =?utf-8?B?TjR0eGZOancvTUdvcUI3alEvT29YdmtIdDY3YlV6MHNYdGFaSDU5SjVqb0Ir?=
 =?utf-8?B?a3JzL1h6cjNHNXIvQVgxTU5uWU5NWTBlM2FQUXNrdG5ObXhxeE1sQ1ZVdnpi?=
 =?utf-8?B?dU1PbjhjZG9QNW83SC9YRTI2SWhiZWJ6SURNSmZQeXo3ZDlXRlJPeS9kQ3Fp?=
 =?utf-8?B?RE5FazB0dHo1R3JzbVhmRkRha3FsSElqRHFhNlZEdVRjMmYwYWFhcFhYZWZY?=
 =?utf-8?B?SFNwNkpUbWxZTmJMRW0wU0RVQ3c5cHJhUFpnNktPNFd4dEozcnN4VXhBWUZK?=
 =?utf-8?B?MEdpenF2Z2VVODlKU3daN2RsS2VtVityaU4zQXR2WU41b2NBNDdmcFVUaWR6?=
 =?utf-8?B?d0hQTkk4RFZybUI3UUpoM3J1QU1QL2g0YldHVXJJSFdiY0pGa1Q4MWdlL0RR?=
 =?utf-8?B?WGQ0cFArY24yYnp3SVUwRWN0ei9jQjJGa2NkUWpTdUdBY2ZjYUJVU1VBbmx1?=
 =?utf-8?B?eUpTd3AxNEZYcCsvelpQNVpCTHB2bTNkeEV3NWdGazlacXpJNTFFUGNtUUlO?=
 =?utf-8?B?U0kyV1Q1S1FLUDdIYmhyTVN5UlVNQUZIdFd6Z2U3UjZtVXJHWEQ5WU9Vclgx?=
 =?utf-8?Q?BkEV6+wRAuBvNiQ1Wc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcf1554-aea7-494e-f064-08de6fc38c26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:31:19.6382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0gbMt2iAW/AxpxQ4wny7/BJrV+Qw7THWoSJ8OpBwKEnQQtNe62w4CjD+O0E5o8p85kFEPIqAxzsQR0vGRxj0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

Acked-by: Alex Hung <alex.hung@amd.com>

On 2/18/26 13:56, Aurabindo Pillai wrote:
> Add ATOM_CONNECTOR_CAP_DP_PLUS_PLUS_TYPE2_ONLY in atom connector caps definitions.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
> ---
>   drivers/gpu/drm/amd/include/atomfirmware.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 3d083010e734..18f9642a42ee 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -879,6 +879,7 @@ enum atom_connector_caps_def
>   {
>     ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY         = 0x01,        //a cap bit to indicate that this non-embedded display connector is an internal display
>     ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY_BL      = 0x02,        //a cap bit to indicate that this internal display requires BL control from GPU, refers to lcd_info for BL PWM freq
> +  ATOM_CONNECTOR_CAP_DP_PLUS_PLUS_TYPE2_ONLY  = 0x10,        //a cap bit that indicates connector with DP_PLUS_PLUS_TYPE2_ONLY
>   };
>   
>   struct atom_disp_connector_caps_record

