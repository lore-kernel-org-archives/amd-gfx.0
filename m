Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3327CAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 15:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C12A10E0F7;
	Fri, 26 Sep 2025 15:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+IyJd6i";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A66810E0F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 15:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yV4Nx/wGN/GN+aawXUqjWyBdy0+RipJzk2BEXwxPtGCY+Wyi+X4SiiXEFrwap+gy8e7mPLb41a1hufkL+serM2oYRux4wj6OCHlK8VBc6q0KQ4QNShseWI1zlDHw/bLtXOmQISyGBVHRkG4F8c5ow1QF0MvMbta0VwzLvcIAuztRuHs+soK8ggaqOEItlEjRIBOCHi0nuO2SegTXYbRM9wXhx/PetHnIkyqiPNket3sl3ZYLBwIgoFJ+i+1dynmW5HtJWtsgAj7/N5jkuBhFDBLFyWAvyLqDRduBuh7Fk1IBjhnfrjlq5ljNZHTR1bjLBZq2EearB1Mxzw3/jtyByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHEZrH8O6/okZ6rj/7mgevqMVbjCLJi+KUcrLu3VTzM=;
 b=ytvb0vongT/NHZOPtG3lB4moLnNvDSgiq/I8obZWJg2U9vS8J6W09W6MQhDYjdd/TAmsOrbCXz71M0dImMKeKJDx9oqpRjz9Kw5fuTE9xawb0P2+skRnfJ7xW+hbsMUFOPys8Fw0TC4TMxOI4bN3cnbq58eFiuvnXBMrvE6qgtqIQASZofM+QxACKnNUN30dINjJ7VuVLyz1CU0wiyaEE68xC923vZCEE8AfQnLE4jYnhe2wBha7bSd651RYt+GkSpek2JSPiREZ9XgFqk3Tgnlu1OljY6bOoT+/EJrcJv7M9pZ7WzdUywDTkfU6BVZcFoaocMeA8c2pEYanL134fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHEZrH8O6/okZ6rj/7mgevqMVbjCLJi+KUcrLu3VTzM=;
 b=s+IyJd6iAoQ7Xx+fNYaW8BvqdN6okP81K0vNGtcmBwMGb6RcYXfv8CbBGiOXf3Vgp5ug9UgpLZNngH2droGEEKZQe8PxkQd6chsvLHV5iDnH5NJFrQBaoYfswN05eXx35bK7AQJjS3YGlTIIkx9CgbAflMcT3f22AUChT50/ao4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 15:26:37 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 15:26:36 +0000
Message-ID: <ed839495-0c90-47d8-bfad-5d4ae87a3c05@amd.com>
Date: Fri, 26 Sep 2025 10:26:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
 <08f80a38-2aa6-49fd-a16d-2b460f2a2403@amd.com>
 <CY5PR12MB6369CEE4F7341EA964855FBDC11EA@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <CY5PR12MB6369CEE4F7341EA964855FBDC11EA@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:805:ca::33) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 1098193b-e21d-4db8-8010-08ddfd1114e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGdUMXgzS1ZabGVOUkk3aTRMNjh1c1NYSkRSbnptaWhNQ0NjSXhuTXdqaElF?=
 =?utf-8?B?bjdWQ3FndzdLVFAzVVB2aEl5UHA1K3QrRXNzTG9wTkhVVHh6cTlXKzJqdnVF?=
 =?utf-8?B?TSs5aEVFMGhMcUNQQUNmUGc1czMzWXQrVnpUR1NUSXl4bXhTZWt1QzJCSmRD?=
 =?utf-8?B?cGFmdzAxUnU1Smk5S3NUemE3OWc2U2xWS3pMSlZMeFJGQThWMCtlWTdPT1NF?=
 =?utf-8?B?S1BSMUdkb3FtNHdNWlNGTG41Z3JSSkJEN01zMlV6ajZWQzFKSXQrdit3bWJV?=
 =?utf-8?B?TGErbWY3eHlJZmx5WW9kbUVROWNiUU5kL3dmRFhMZ0JkSmwyZi96V0I0TTU4?=
 =?utf-8?B?dkxxTlMwQVFxRUpuc1hQNFB5Nk1FSncrcG45Y21kL2RtYk5tcE56c2tQdmwx?=
 =?utf-8?B?QjhvbzVXNGxHMldmQnNmMXQreEVqU29BeFNWSnplMmNxYkFna3VsYjU0SURs?=
 =?utf-8?B?VGlaTm9qSXgvMkhrNExNV1NwRG9kQXd2cDBqVUE1N2x5akEzZHNIVHYrSHVs?=
 =?utf-8?B?VGo1cG9LajZUL21EUnFTQ0Q0Qm1lcTdNZE02R0dFQ3Y4bHF2enNEdWpsaWFK?=
 =?utf-8?B?c2M2eW5kZDk3b2VKSlVRdzcyMTRnVkNqZnVhdGtIYkJCSWZaS2IrQzk5cXJZ?=
 =?utf-8?B?V0l5VTRONlFXblZkQnVLN1JvdzlrTlpEY3RWbWpERnhHYWQ2R2ZPWWo3L3RU?=
 =?utf-8?B?TWg1Zm10Ri9lOGpOSjh0MnJ4N1UvQVRDZVRVUnI4VGNnVFdzdGY5N2Q4YkMr?=
 =?utf-8?B?OXpGcmhmT2pTaDhpWWYxKzh3MXJLd2Z4QStOQ0dtSWc5T0lSNExxVjJrZzVj?=
 =?utf-8?B?YTdFSENRM1R4eG5pempKcW1mUXdUajFkNFVPZVhUSGZDTzFseEMwd3V1R2NE?=
 =?utf-8?B?cEhVZUFNK295a3Fsbk9xZkw2RktIUW93TVhrd0FnMzd0U0lYS003bWc4Qjcz?=
 =?utf-8?B?NzhlZ0ZYd3FWRzh4dlBYREVlN1BWY3JpbVdsaXk4RDdBVlk3UDYxZWZLSS9K?=
 =?utf-8?B?L3lxVE01N3lzYld0ZDNkTjFaZXV0N3dEcVB6a3YwNHJIME9RdTZpaU51ZjdR?=
 =?utf-8?B?SHhySGU5T1dkM01ZaXJla2ZXVTJha1FFZjF1bGZkMldHSTFlNkZkcVVKcVhO?=
 =?utf-8?B?UHMzMitrc0VvRDVuMWcrUXZpVTRMaE9vZ0p5eVE0dlJxZzJVNGVUd09nYUIr?=
 =?utf-8?B?Qjgyck9PaXhQd0ZtZnZ1Si9PT0ZPZlJnZjNvWGc3TFQvc3hHa3JaLzhWeFJY?=
 =?utf-8?B?NStGWmZpcWw5SGNwVXFyRzZ5MFNremoyU0tqeXpPd2hWckNtR01HcFB1Y21q?=
 =?utf-8?B?NHBtS1F0VWd6dTZic1E1S0dSTURoZjJuc1FSaW9FQ0RwSVFETk1MT0MvZ0ZK?=
 =?utf-8?B?Kyt1eUVzK016U2JMakJzcEhHeGpCUkdPQWJxSVNDUWU2ajhkY1cyV2RxbVZI?=
 =?utf-8?B?dDE3UDJpL05iZnVxSHhaM1d6NTZSTkQvN0VadmQ2ZjJrMHdkRjNrblkzZHJH?=
 =?utf-8?B?UXRkd21ZRVpyQUFPaXhpRnlKK1laMzZ2NWJIV2U4cGtoTVdvemdlVkErTTZs?=
 =?utf-8?B?Ym9WYi80Q2V6cUJTWEMvbDJpcXFsUFExZzNsc2NzYWUxdlArN2I2YjdadUtI?=
 =?utf-8?B?czd5aUpMSHRMeDZDQk9LWnlyd0FnQm9oeUJzSUdEckQrVUJ1NzFwaWwrQis3?=
 =?utf-8?B?VnBsbG0zQ0FsWkYweUdtdFZ0ZkwwS2VIdXplNDhTdXYrNGpUN2xsK21wOG1C?=
 =?utf-8?B?Zkg0bXQxSmFkMHMrRytRUDdBWDQ2Z3RydWl4dElaYXB5ZnpEOTNzOEVRN0E2?=
 =?utf-8?B?WDVtUklZdXZJMHBxeFZLbkc1RWFaYmtNYkN0dDVLeWFJWVhQSExkQktJMUdS?=
 =?utf-8?B?TDArUXdmUEhLZWhZaC81aElkQkFLYVlISWJhendOR2dYQnd3T0dUMDFDSjdB?=
 =?utf-8?Q?BjAfSCm5q7U5zk45L0euP9nUdt1varIM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFgvZG52TXJPaDIrcTZDZVBxRUtKSzJISTRTWFBsMjk5V1pMZlNiaFByY2dT?=
 =?utf-8?B?dFFjb1BFR3BXSFFoSXFjcGRtRWlIR0MwR0lWR0U1V1ZmempyK3lZSnpxaWc2?=
 =?utf-8?B?Qk0vVFZ2ZzBtcytMSVJ0alhPNXVybGQ4aHZxZFV0dXNUNTdiQXozMGZidXVO?=
 =?utf-8?B?Y1VGanRabVpHWDRVY0I5YkVoTDV1c2tIbE0yN1F5OFhhRVVlemVyeGtxVDhF?=
 =?utf-8?B?VlFzbjE3Q21FNmp5Y0grSXpvVUN4ejB4M0ZJSHM2VEhJcjFONFNabFpFcjln?=
 =?utf-8?B?dHVtMERZV0d4MHNoSE94Vk9iangxQVVENm1Bb3JaYTF3V0xOb2FKa2dHYmRS?=
 =?utf-8?B?d2l5Mlo2aCtzaVF2UnhFWllqNVBXcTJ2blU4Q2lsYkgrVHVxRmNsMTVFVmg4?=
 =?utf-8?B?ODFjOWJXU0UxcklFaDBQdGg5cnVzcXVtdkZTQ0xsbHJMMTY0Qk8xWEdydG1i?=
 =?utf-8?B?cnEwR09lYlVBUkFTZ28zMDFmTm5CZjB3L3VaS09XMnEySUp0T1BZNk1Kdmds?=
 =?utf-8?B?Rmdhem1UV2VCd2FhcWoxQ0piQS9ma0xlemFVQkNkWW5YVWhKbGJiRHdSRity?=
 =?utf-8?B?VDdFNnN5N0ladERHVnlNTHRQUFdoelpmUlkxdmRBcTBNRmhKa2h5NGNNTkMv?=
 =?utf-8?B?ZDNMVUhtbXZ2dmFXR1d6YjROemxNUXFobWZOMGpXSUZjL0w5U2hOWmt1RFBO?=
 =?utf-8?B?cTBnT0tqWE1EaUJQMUhMUitoWXA2TXhKNG03ZzA1eks0eVhFcnJjM2dJUnNB?=
 =?utf-8?B?WmEyeWNxVVpPSmszRStBN0w1ZHVVZzVheUdkMWtRZ0JnZW1YQzFRMGlVbVlL?=
 =?utf-8?B?aFcwREVtVDFubVhNZnZGV01HZDh5ODlSL1A4UG50NzJEM1F2TGdZcmlWckpV?=
 =?utf-8?B?aXJXZXRoTUZpdWN4eWY0MTBVZGVUdUNnbUhEK0RUa0hmTFpCcEl4VE5GSHhN?=
 =?utf-8?B?SEp6ZVVZcU9qZ1IxM0prTUFlWFlHeDZBL09xaHV6SmQyQjB3QUFZWTZocFpX?=
 =?utf-8?B?a3VQRlVpME9Ta0FpUThkbjc2UUZFNjI2ZGs2TTdYOWs3Wnk2dlBHQzBQT1BD?=
 =?utf-8?B?ejNWeU9lL0J1K292dmtKbHErSzJ3VGUwbnNHKzh5ZXR2eWx1OTVpSXIwbjJu?=
 =?utf-8?B?TU8vUUwvRWZJUFJBQ1dQMjBGYjgvcmZLSitSaG5hejJES05ncXVYTUhWWHVs?=
 =?utf-8?B?NkZGSUZKcEFDNUt5eHphWTUvemNFbVBkQjdkU1BGbHVIVjV5NlZaaVJIN0RX?=
 =?utf-8?B?QllFOXE0NEEyU0JvT0xzT2pRekg2cjR3SEdkcit4eTJTc1lxaUZNWFBuNGE0?=
 =?utf-8?B?Zzd0ZGtNT0xPdFhWVGZDenpic2N1YWpuc0pSRllyZUorQXBCaWd0NFRxcWg4?=
 =?utf-8?B?WXJXL1VLTmtqaHo1OVpnMXFBWHlhSkVZZ0dvc2o4V0dDUXBKN0xxZE9BUTJ0?=
 =?utf-8?B?enNSc3dobUx2SU45bE9DeHFUOHIwOTV1OHBBNTA1ZUMwZkVWNHNlR21oRnRG?=
 =?utf-8?B?OGRTRTlsUEJ4elJWbGhZT0IrMEhtMjJzcGgwa2FNUFV0cE9oT3lSeUdScytT?=
 =?utf-8?B?NnJXT3BkVEphSEhlUUh0OVNkS0gyZ3dIUW5md2MxaHhRUklYRFc0SzZuN1NZ?=
 =?utf-8?B?YnFKUnFlQ2xiWmpmQklsZDJLcmtKb1V4aWVVV1gyRXBkYTZWSThuMFNUd0s5?=
 =?utf-8?B?VEtFMlJTQ2pDUW1Bd0NkNGptWHZqZlQ5ZElHcmM2UUlSV0FPWS9YLzhzbDNC?=
 =?utf-8?B?bVdqNEJSMEZPcXppNmt0R1JOWnhJa2dXd0xkRWRkamgyK2wycVUwUUE3VEZp?=
 =?utf-8?B?SlJiR243bWhWOEJjdkZSRlgyMmFib1g5akd3WjB0NmRDb2tPbXZCL2N1eTY1?=
 =?utf-8?B?Ni9Wb1cxYk9RMkd4WUczcjU3REMxeUpHbnVZaDlmV01FeFU1WjNrVkhwOEp0?=
 =?utf-8?B?OWxDeHFsbnpPMGt4NFdWdmtqaDlwM0pCenN3WkdQWVRtcG5EQkdsQ1R4Y1RM?=
 =?utf-8?B?MFlTWlFZOVBBN3pnV3RGY3RrMHZHL3Y2c080K29sSlJ3bDhvTlNwNHI4bjM1?=
 =?utf-8?B?aDdrd1A5bXlVSk9zc3J4MUVHeDMrZEpiMTMyc0Jrdm9xZFpScWpMNEo0SDEy?=
 =?utf-8?Q?Imro=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1098193b-e21d-4db8-8010-08ddfd1114e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:26:36.5177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9WVRl0wKffEBaVDt2arVjyk/gJTFMmEV7jxhcsw1VYeCV44I6630+IEMQsJ+McT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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


On 9/25/2025 8:15 PM, Zhang, Yifan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> flush_workqueue(kfd->ih_wq) and destroy_workqueue(kfd->ih_wq) in kfd_cleanup_nodes clean up pending work items, and node->interrupts_active check prevent new work items from being enqueued. So after kfd_cleanup_nodes free kfd node, there is no pending kfd ih_wq work items.
>
> And I agree there is still potential race here, since kfd->nodes[i] NULL check is not protected by lock. Will address it together with the issue Lijo mentioned.

yes, the ih_wq is flushed and destroyed before kfd node got freed. But 
still, kfd->nodes[i] can be null at any time for kgd2kfd_interrupt at a 
different task.

I think the real issue is kfd->nodes[i] was not checked under 
node->interrupt_lock. Both kfd_cleanup_nodes and kgd2kfd_interrupt need 
use this lock when operate on a kfd node. Currently only 
kgd2kfd_interrupt uses it and does not include kfd->nodes[i]. 
kfd_cleanup_nodes also needs use this lock to exclude operation on kfd 
node from kgd2kfd_interrupt.

Regards

Xiaogang

>
>
> -----Original Message-----
> From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
> Sent: Friday, September 26, 2025 3:11 AM
> To: Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: Re: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_device_fini_sw
>
>
> On 9/24/2025 5:48 PM, Philip Yang wrote:
>> On 2025-09-24 11:29, Yifan Zhang wrote:
>>> There is race in amdgpu_amdkfd_device_fini_sw and interrupt.
>>> if amdgpu_amdkfd_device_fini_sw run in b/w kfd_cleanup_nodes and
>>>     kfree(kfd), and KGD interrupt generated.
>>>
>>> kernel panic log:
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000098
>>> amdgpu 0000:c8:00.0: amdgpu: Requesting 4 partitions through PSP
>>>
>>> PGD d78c68067 P4D d78c68067
>>>
>>> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>>>
>>> PUD 1465b8067 PMD @
>>>
>>> Oops: @002 [#1] SMP NOPTI
>>>
>>> kfd kfd: amdgpu: Total number of KFD nodes to be created: 4
>>> CPU: 115 PID: @ Comm: swapper/115 Kdump: loaded Tainted: G S W OE K
>>>
>>> RIP: 0010:_raw_spin_lock_irqsave+0x12/0x40
>>>
>>> Code: 89 e@ 41 5c c3 cc cc cc cc 66 66 2e Of 1f 84 00 00 00 00 00 OF
>>> 1f 40 00 Of 1f 44% 00 00 41 54 9c 41 5c fa 31 cO ba 01 00 00 00 <fO>
>>> OF b1 17 75 Ba 4c 89 e@ 41 Sc
>>>
>>> 89 c6 e8 07 38 5d
>>>
>>> RSP: 0018: ffffc90@1a6b0e28 EFLAGS: 00010046
>>>
>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018
>>> 0000000000000001 RSI: ffff8883bb623e00 RDI: 0000000000000098
>>> ffff8883bb000000 RO8: ffff888100055020 ROO: ffff888100055020
>>> 0000000000000000 R11: 0000000000000000 R12: 0900000000000002
>>> ffff888F2b97da0@ R14: @000000000000098 R15: ffff8883babdfo00
>>>
>>> CS: 010 DS: 0000 ES: 0000 CRO: 0000000080050033
>>>
>>> CR2: 0000000000000098 CR3: 0000000e7cae2006 CR4: 0000000002770ce0
>>> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> 0000000000000000 DR6: 00000000fffeO7FO DR7: 0000000000000400
>>>
>>> PKRU: 55555554
>>>
>>> Call Trace:
>>>
>>> <IRQ>
>>>
>>> kgd2kfd_interrupt+@x6b/0x1f@ [amdgpu]
>>>
>>> ? amdgpu_fence_process+0xa4/0x150 [amdgpu]
>>>
>>> kfd kfd: amdgpu: Node: 0, interrupt_bitmap: 3 YcpxFl Rant tErace
>>>
>>> amdgpu_irq_dispatch+0x165/0x210 [amdgpu]
>>>
>>> amdgpu_ih_process+0x80/0x100 [amdgpu]
>>>
>>> amdgpu: Virtual CRAT table created for GPU
>>>
>>> amdgpu_irq_handler+0x1f/@x60 [amdgpu]
>>>
>>> __handle_irq_event_percpu+0x3d/0x170
>>>
>>> amdgpu: Topology: Add dGPU node [0x74a2:0x1002]
>>>
>>> handle_irq_event+0x5a/@xcO
>>>
>>> handle_edge_irq+0x93/0x240
>>>
>>> kfd kfd: amdgpu: KFD node 1 partition @ size 49148M
>>>
>>> asm_call_irq_on_stack+0xf/@x20
>>>
>>> </IRQ>
>>>
>>> common_interrupt+0xb3/0x130
>>>
>>> asm_common_interrupt+0x1le/0x40
>>>
>>> 5.10.134-010.a1i5000.a18.x86_64 #1
>>>
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 349c351e242b..051a00152b08 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -1133,7 +1133,15 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd,
>>> const void *ih_ring_entry)
>>>        }
>>>          for (i = 0; i < kfd->num_nodes; i++) {
>>> -        node = kfd->nodes[i];
>>> +        /* Race if another thread in b/w
>>> +         * kfd_cleanup_nodes and kfree(kfd),
>>> +         * when kfd->nodes[i] = NULL
>>> +         */
>>> +        if (kfd->nodes[i])
>>> +            node = kfd->nodes[i];
>>> +        else
>>> +            return;
>>> +
> KFD interrupt is handled later in wq node->kfd->ih_wq at interrupt_wq which uses  kfd->nodes[i].  Checking " kfd->nodes[i] == NULL" here is not enough as kfd_cleanup_nodes can free kfd node at any time.
>
> Regards
>
> Xiaogang
>
>>> spin_lock_irqsave(&node->interrupt_lock, flags);
>>>              if (node->interrupts_active
