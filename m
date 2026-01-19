Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2A4D29C32
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 17:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D39F10E05F;
	Mon, 19 Jan 2026 17:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="13uzuiFk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBF710E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 17:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO9TkmfbVyf06fWUSLzwFcV+p4UeQ5ONDBZtHLUxdg3nZFVWPDxLweJ6uxLuoGhDofVlaz6z9nWkTEN8GJDqijwZ3C9dbYRpF46ZlrV3bw7ow4+exmaMntJ6IFztkYWLKtxQAaUWmUA7E1FBYrPO3mA0rx1K5g5eKLLF1p7BSkCnejQ1WUwqbWKfCxrhdOXnRkbQ2rZTtmh27HcZtX9gkhSSY0G443eEkXNB5Bj1SHcIwspprOpIdONmyIFEFwLOIGQCYEFatP8ZqmibRjaeRR0xXOLaMYfE2LvwNrAgtw5QIv2bjLQReDwY0hhiCydO9gZTXpYadyHWb4H1LF0u5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQBg2GB5SV4jluk2v3d5/UUHIAiZfgM0Yh0mWEmbXCs=;
 b=GwvUPNrkdXqvV++vCpHZg3kQOjNTEXuTU4cvqQTVL0aZxYOQ3nOOiffyDuSmVI/g4utJbB0VWjJz3L8be7YPHwml9G/ty9b/VZ4hSF61+65V1zWaEVxYflr8qhBc5R+66jpBUYm+goeUkr3sDIspLmCVerYxB4QjS0BZEhuMosaTYnjJrpsmMU09YNSnZfJQ2O0tMEMZ8LILvJ8rx2Tqs01bpKB0WD44smjCUFDRHdnRktGeza1gMlicPYYNvKz8Vpc3tkwc5mpTzA9oLguzEWmc3LQL8tlPbCkfSjZVtkxJhgakHHMfVuczqToIetCNotc2gra7iRKm7EeItY47Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQBg2GB5SV4jluk2v3d5/UUHIAiZfgM0Yh0mWEmbXCs=;
 b=13uzuiFkNyOyLT5N+CwgQqHkQPkdyqeLtK+evCGbMWBii2IKjpxRLWVGxrv2zohsuuMZp8Ho3Cb1PeIqGHvZ+j3SRD61R94l1A7HlviLwyn9WzpdN42XIpqmv8QbWpsYRJkXFuaIJjDWG7DQWWF8RlSulq1CRfsxVRajcpr7z6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 17:21:48 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:21:48 +0000
Message-ID: <47aaaa83-012c-45bb-8f51-8f09c0ad20ce@amd.com>
Date: Mon, 19 Jan 2026 12:21:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Only poll analog connectors
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260118130345.43356-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260118130345.43356-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0311.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::14) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1d9ff2-108e-491c-a6d7-08de577f3a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHVwQm9ubFVrTU0rYVV3Q0VGeUpZM1JOeFBoTjhrdjc3aHVEVXh4eUxMTWE2?=
 =?utf-8?B?TUVCUFFnT2JJNjR5dm8zOVBwNDBSWDdCSHAxSHRGN2NxOFB6NlB2d3RTa0pF?=
 =?utf-8?B?VVU1Ym1xQXVWM0pzdjA4ZWpRQ2M5RG05M1Z1UklCTVF2TTArblFVRk1YWUF4?=
 =?utf-8?B?TCtvQXhFWHVSSUdwVmpqbnRqUVZlMUVmenhMWWl3eC95Q0N5b0ZCaVZaY1Va?=
 =?utf-8?B?cDlWZHU3UXJ4d1NpZEhSMVJWVGIzVS9DYnBHaGE2dWJJVlV3WDdhTGdrT1lV?=
 =?utf-8?B?dnhTOG9zTlZWOUtlUTYzR1NRcnI2c1o5U1lVdHVKSDlwN0k4bzFaejdKL0I0?=
 =?utf-8?B?QkpvUjhWZDN2L2dSNSt6dHNvMStZYkorSGVycDRSUnNsOHRoU3p3MTdsQXZx?=
 =?utf-8?B?Wkc2SXZhUUZLVzhGSmNycHg4VDl5eCs0T2hONGVONjd6ZmNKVVhrRjBaM3l5?=
 =?utf-8?B?aUx0UmhaMFljRndrNmRrS0ljdi9oK29TWnFMVEFsR0p0NTBoOFBvZCtmb1pY?=
 =?utf-8?B?VUJKV25PQmNaTk9rdldKLzdGQ2ZYdm5QOTd4SHFTYWliV0VLZllLcDZDbnFi?=
 =?utf-8?B?VlFNTzBQV2ExMENDemRwcFNMZkhHRjVkL0M5TnB2TnQvaGRvbzdxWHlaREF5?=
 =?utf-8?B?N3YzZ3hPNlBhekx0NU1kZXhpWmJnUk04SkZSa2IyNHpwMVNRVVhwajZ3b1JY?=
 =?utf-8?B?anpWYVpMSTNtQ1hpU0t3YUs2M0dVbEVzQ24wZStVMktndGtWU2RIWGZYbUlU?=
 =?utf-8?B?WlBxSUQ3VGRzRzdXYmZuN1R1OUY4MElpRUZnS2o0OTNSdnVqTXBjNklhNlBM?=
 =?utf-8?B?S2R1VFErbmp4MURaeWpqNmQxVU00cDFvTzczUVJ2VFFMRWlqSW5TQmRrSWRB?=
 =?utf-8?B?azhaSDhiN05iUkNPM3B1Uytyc2t3MWJFL1ZDNDFjeWpYbjZsSVpUc0I2Uytl?=
 =?utf-8?B?dmRQblhMWTVGUmRNRlQzdnFMSEhmdldRclFUS0JhdzN2MDJsSEpwQWZBaHpH?=
 =?utf-8?B?SEtDWTBMNlFNNXZVelh1R0V0VFRGbzk1cTJiWnI5bzVPMFN0djNPRXZuVUFU?=
 =?utf-8?B?bzRCeVpWZjJYMmJPUWM3aEdQV3pLUlNySWphZng2VEtwU09FcFd1ZTNnWkkw?=
 =?utf-8?B?OWlhRXNWNkNaaFBJZWJTaWtxeXBFNFV1djJRY3AwRXBDczdTdDdqek0rc0FX?=
 =?utf-8?B?cnZuanFPNVY1bVlDMTNGamFLOEg3SEtVejA1clp1VldRb1d1ZVF1dlV6NGRz?=
 =?utf-8?B?Z3d4Nm1BaW9XdmM3R0F4RTJOcktYMTRVZlQvbDc3RlhlWHFDZU5FN01iZ3k3?=
 =?utf-8?B?cXhsTzNVeTkyQnp6cHFDZ0lwTlFPSEpibE5mTWQ1aE5DUWZaeXFCcUdiMmxZ?=
 =?utf-8?B?M0VxcFpBQXl4c3VHOVRUWkp0dnpTaXp1VmhmSk9GT2cra0NhWklpaGhTbTgy?=
 =?utf-8?B?aGhCNGRGbE9nWWFwZVBucWpBSEpIc3loeEJtRVR6S1FnRE1heDExbjNrb2hh?=
 =?utf-8?B?UWtOdDdya0ZhQy9mcHdtbmpocWtJSHZzdUtjT1pQSmpUUkZVKzdzRVlsbFpm?=
 =?utf-8?B?WFl0UEhWVjZwOVVtM2liM1B1SGNJNDY1UGxMSWNydjFHQjhRWGV3OGpaWGQy?=
 =?utf-8?B?bzdBUDVxYXc0UENyV1prb2tQM0ovbnhaRm1PcGxWeVV6MXNQNlY0MGRTMTE2?=
 =?utf-8?B?UmNydHZKQ0RIS2dkZmJwa1E2NzFhRDh3RnlQUEFQTUZoK3dIeHljaEZiZkxo?=
 =?utf-8?B?Vm9sNi9naVl6VEhOdDMxenVzNHQ1YVU2RzR5SWs1TVZwVDY5dGorcnpVVnls?=
 =?utf-8?B?V2RJQ3orNit4REpqVktKVUtaZHd4UlRRUTNmcStZRXpoWUZsNFNjUXRhZUdN?=
 =?utf-8?B?QkJobEpkN3RRMTRQUkw3THdoY0ZrT0Y4bGYwcGFnY3R3WnA1Nkg4YVJRQnBt?=
 =?utf-8?B?SWR3S0J3aGY2bGhzRkloSUU4dFp0UDlaMGk4N2kvWDludlp0dzc0VWdsVDhE?=
 =?utf-8?B?UnVKdGdYeE9lWWVLcGJwT1BpVzBKRkJBdDA0K05CY3VtQWlBVFl4djBJZUc3?=
 =?utf-8?B?TyswVmdrdmxib3IzU2gydi9RT0liRTFyZi9mV2hjd2ttWFVQRUovQTl0Q0kz?=
 =?utf-8?Q?RlWo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGd5bWFsMURPcXg0bmFkT2dvNHhYZWVCeUJUYjVrTGYwYW1GMCtldFM1dlpP?=
 =?utf-8?B?bnlScytUUnBXamlTbThScHo4T1A1MDV3N1d6OTdBMWdZeE45S1pXVllhRmpn?=
 =?utf-8?B?d0k0NUNzN1ZoMmhGMzZLMk03ekVqbHBiV1RZYmJ6Vk9mcGI1Q0VuazJXZXow?=
 =?utf-8?B?UXNHQ2g4R1hxYkRzaXlzeWt6WUd1V1NaSnFRelhiMzc1NDI5OUdxelB2WGZZ?=
 =?utf-8?B?UDVqZk1LSzBMT0dpZHFTNUgyMy9ma3gvenU2NktRaUZMSks4U0VMNDc2cXVn?=
 =?utf-8?B?d2VTdVd2ckdVSXptL05NdldjQjJBODd0QXNuSEUwTTVDaFltY2pGNjBpaVhs?=
 =?utf-8?B?WkQvSlQrelZWUkQzdW1lU1hLM1BualBoY09NTEU1bDA3RzZVNHZuNmNJRW5Y?=
 =?utf-8?B?ak1zREJzVnhKUnFraWthRXpGVUJtWHZtMnFoL3dPaWhuM1VZV2oxUzBTSkZx?=
 =?utf-8?B?UlJLSHRuYy9xdVM2eTdCQmFXTmlnOHI4N0xraURiRGdVWEVJVDVua2pHckk4?=
 =?utf-8?B?WVF5Rk1vN0hIMlJPeUZRVEZjRTNwNzNXWVprTU1UNEhGMklEWlUraUk5R1gy?=
 =?utf-8?B?eUUrUHFKeVRPbVRuZUZ5bzV5N1hkcXNKdjdmK25GVGdqYXcrdERZdHBmcUpO?=
 =?utf-8?B?WTNRZ2J6eW5MaldVSXZMMmY4LzB5ZTBidEdlcERSeUgxcU82MTI3aHdQZElL?=
 =?utf-8?B?dW1DcjV4N3hhUVM2eHFIOGdSNDgwVHVGZkFISXJwcEU1TkppMDBVb3dma1U0?=
 =?utf-8?B?QTBMS2wyWU1aYnpPVVJBV1dwSEUrclV1WkQrR0p4bzZVTldLOTUwcVg3TlRr?=
 =?utf-8?B?aTFZT3JvSThUdURVTXVCTkdScmg2R25PNnQyaGJXM28rOWlIRGZ3cTlkcUJP?=
 =?utf-8?B?MTNCZmlFVDNob1B4K1ExYitpalQrQ2dWRS92OUwwVHpwMWR3T2txemdsajdJ?=
 =?utf-8?B?M215QmhBRnlXM3E4Rm9NckFMVzZXeG1nTzN1Z2dnZFBPNGhjSll0ZEFUV2ZH?=
 =?utf-8?B?am1Jb25ZUnJwYUpsTzdmNnB0Rm1IbnNkcVNNVy9mYmF6bkVjSEsrYmVjU3Qz?=
 =?utf-8?B?L01uTE5KbC81Q2FCU0hkcmMrWU5tbEpka3FuZUt4RFhwL09UUzlkSDZ1RGNZ?=
 =?utf-8?B?c3ROWHJmNmZwTm1QeEVWSTltVHRZTm1vb0tSQlhTQWgvcGs1dUJBMHB5OFBm?=
 =?utf-8?B?Vy9sWThic3Z3U3pqYmdHdVdqb2E5V0cydDBucXVBSlB3TEowSmpSOWdVNjdT?=
 =?utf-8?B?NEhySGZIWjJHejJJTnJlOEh6bmQwamlnYUt3OGdRU09UanZld1h5UzlDVnNY?=
 =?utf-8?B?UzR6TlovaGgxdG1ndEM2eFJyYVczN3o1MXE3OGREU2lvRTRvaHZ6Smw4Nldt?=
 =?utf-8?B?L1NJa0EvU2VQLzFzblI4S3JHZk5Wd28vNDVxN0tySkRiWTlaNzhETWVBZ09N?=
 =?utf-8?B?cURhb3pFRDB3RDdmekNCVjRxcy93K3BPSDU0ZDdEWTY1UkxRVVUxc1JLczJv?=
 =?utf-8?B?T2JHamluaWVJNXI3TVBpL3NqWFJkQVJ4ejh3ZStWU0RBdmJENCtIeFhCeTZt?=
 =?utf-8?B?em82a2dXUEs0WlFqMWkzeVV4b1E0MDJteFRIMlZqbjZicjVMR2VMMG1ydlFI?=
 =?utf-8?B?VWlnVlhVaVZBR1FHU3MvV2hMMUZYdWhxV240TTlIdmZkWFNZTHMrRXFYQUlz?=
 =?utf-8?B?OW9LR3Ztb05ObllUY3FpU3c4YjJ1Um1LN0labTFEN3FoRlRzNWwzZ2FURFF2?=
 =?utf-8?B?VUFzQ0x2dDRyZDJrTHYxQzRhWldCMmh5aU9DZWxTYTh2eGQ1SGN6MVdGRzhB?=
 =?utf-8?B?VmlxaHM1d25zSjFhMmJaa3hFUFNDMmUzdTZZUE93Z3VFSEY0U3JDcDIxRU9t?=
 =?utf-8?B?bUt3RlhjSk1xV2FmS0EvcXRiOTFGT2hHU1ZBNTFrK0J1bmRPaW15SXdqcmZw?=
 =?utf-8?B?aFY2ajFZWGU2aXg4YWtIMlMySERrQnpJSlV5cUtaWXdEbWtHSnZoenFEWURO?=
 =?utf-8?B?VXRqaDdidVhEYVRUZk9DZTNCQzV6RDFpajZTcGNHODhmdWMwb2RCWWhSY2p5?=
 =?utf-8?B?Q0tVbHdZR1RiQy9EMGxWaDBSYWdHaUxnVHJXdWM1aTZQWGgrTEI2TDJzQ0tM?=
 =?utf-8?B?Y2k4aUFJS3Y0a0VoUDY2Y0NhMW5XWGx5V0JtdjE5ODBpa244Y3kvK2pqV1ds?=
 =?utf-8?B?a29OK01IM2RrRnBSMjlDTFhwWnlNSEVqOS9uK0tkdXMrcVVvN2hndVdtTS9K?=
 =?utf-8?B?cng5dm8xM1RoZ2ZEMlB1ZWhpOC9HNFZWN2RSSGU1VCtlK09mZjJPaG43K1FE?=
 =?utf-8?B?SkFlMHIzKzg3U1dQeExFYjBCYjFvSVNybjlHemVmN2lJTnhWRGtNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1d9ff2-108e-491c-a6d7-08de577f3a40
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:21:48.4167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyGJWAf0hhLvqSOaZuTlsQqlV2npIDGk8sCqtssc0+perZib0q593nRvA+z72bHKlyQCHCWf+svtzoi1AWdtVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809
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



On 2026-01-18 08:03, Timur Kristóf wrote:
> Analog connectors may be hot-plugged unlike other connector
> types that don't support HPD.
> 
> Stop DRM from polling other connector types that don't
> support HPD, such as eDP, LVDS, etc. These were wrongly
> polled when analog connector support was added,
> causing issues with the seamless boot process.
> 
> Fixes: c4f3f114e73c ("drm/amd/display: Poll analog connectors (v3)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 0a2a3f233a0e..e7b0928bd3db 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -915,13 +915,19 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>  		struct amdgpu_dm_connector *amdgpu_dm_connector;
>  		const struct dc_link *dc_link;
>  
> -		use_polling |= connector->polled != DRM_CONNECTOR_POLL_HPD;
> -
>  		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
>  			continue;
>  
>  		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>  
> +		/*
> +		 * Analog connectors may be hot-plugged unlike other connector
> +		 * types that don't support HPD. Only poll analog connectors.
> +		 */
> +		use_polling |=
> +			amdgpu_dm_connector->dc_link &&
> +			dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);

Why isn't the aconnector->base.polled assignment in
amdgpu_dm_connector_init_helper doing the trick?

Harry

> +
>  		dc_link = amdgpu_dm_connector->dc_link;
>  
>  		/*

