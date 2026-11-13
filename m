Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2E8606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kQ9VK71Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BC310E727;
	Fri, 13 Nov 2026 10:24:57 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D7D112398
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 10:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9KBxMgzcI9dIpcBM5kfyv2nVfukl1tQ2ZpjVuDaEEdDxBDzA2PJL/EYNUawTnOYnp6T6PJjs9fclrPCAFRV0AAHW5Tvi7lH51IbUNp/2RewizS6LPF9OP/Ki2WOd96kY72UPvb5DX1uJFkhrv/oJ37XyNbETDeSYWXG8Osnzzn+JSXJTeNOobuAzT5L9QCzwr/vcHYMhj5AGRt3mXsTA6stCL6LnAAcvRbasq6HTYAl5m/0Jj7i5lYkSxQPjhtesRHX/pDnz3iFwYbBfUHzkm8pX9RGahtl589A2/GHZNSBXjPqVjPnjEJ2LG6Us4zXuu16Mkx+jNFY3M5Wx8I1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYrRg+x9c8N6+xgJr+8pNj+vLFs+NhuWM4cOM11y+3g=;
 b=mpi3L3Qj+VRyfP7Shk74sTe4/tLlJ85h+3/dRDL6baYEoPBlOYa7x7sbPX9ADYUeL5EzAV7eYYAHTXKhYsEJ7LoWRQ2ydVDVOOSq9uaS43OWbEkIpP3vHqnvCY5G1nLrgaMK0Tx/1K7hrc21UERe7TTdaw/Nh+hRqNrynK3BA9Asa0PqkMk1nTnogYxcEB6oVNuDFbazSs/hLaIq31cPey5kjPgqTKZ2UymeT3ppDm38AC9oJWnu2HK4FMtQTFhPxfYOP+7MDLkfbtwFnJRmYwtqvN+mqBqC1esXlw9Z0c7mJfuZvwhV6+X1PBR9OuwJ3Pgtu3hKlQcFycFlMvHojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYrRg+x9c8N6+xgJr+8pNj+vLFs+NhuWM4cOM11y+3g=;
 b=kQ9VK71YClThJKuWqnYaVs/vmKn6rH7Rogi+yiNwhCRaGvk8fIKUfdQuJuVABrKZJt7+T58p4xj3L7YIZVyZSoXAx9H0zsGkvVMXZWWsukrYpMfvEEVlQdIlqXOkGSDw1NKewfYVcebhBnSmqEPkKfbJr5jVwvXYAXzxhmK094c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 10:20:34 +0000
Received: from CYYPR12MB8701.namprd12.prod.outlook.com
 ([fe80::2d1d:d718:e022:2e18]) by CYYPR12MB8701.namprd12.prod.outlook.com
 ([fe80::2d1d:d718:e022:2e18%5]) with mapi id 15.21.0592.007; Fri, 13 Nov 2026
 10:20:34 +0000
Message-ID: <5ea40447-8afc-4666-8f45-368faa43b0f7@amd.com>
Date: Fri, 13 Nov 2026 18:20:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/74] DC Patches November 16, 2026
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To CYYPR12MB8701.namprd12.prod.outlook.com
 (2603:10b6:930:bf::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8701:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 686c9f8a-0f4f-4d0e-5719-08df416fc0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|3023799007|10067099003|11063799006|5023799004|56012099006|261022113327099003|261102123227099003|261009223027099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: TxgdXdAE+5429CQwodMTIhqVC1qJvI/VtvlqiVB6KrspywSRD4eEqsP+tP0NFShbK7MrBZQikcQKCCcdD6OdNcLF7J/IUOG7NLE8mPTcFAagHQDjZIfpXA+eOnyBwE7JMO55OCGGmqEDyB9xhgi2Zze40OZYfES8+/blkYtqRQgzWRHDUFy4l3hfvzDQuY8H2eFoEMVNVSsWAz26SsWvog47eORUKOGkDveftzkqX6cbnxETIoHaPjO7fjwOc2IfjeCwg7K+s2KHCorwUFz2cXhNXS3CQ/oQdKT8OrgO3hql1JtjPqthadcynoxHbTLSwSbkMnKdtaMwLKE4dWpiP11Sldlqa80LjVj7nV+4m08lVKLKjA2jVQbXcNOWLOutsk4BcSeTnhjcnKkaSfleNVBMlCtwTsem2tGOi9ahqU042gtLYfXOIG5EYQNpWNhe0d1+BG2S57aAScc/2N0bVTNyVu+eg9DEeAIl/IYN42eQd/uIyB4ao8U7ecq2zI+UkIbi/C9fvgVrlXuKj94MnhVeREy6mCb2sRXTY5R+jJRZmWVRRR8q3D2AoyrYyuoiFPGmz0p+O8WhcovJoUKPEdvvB1IlRrMAwb1l8PdruCzcB0piPaBmr+eo93phASXaMMAKAHK1Q42WQBWBtF3eOphujawOb0Zz4/uBtDA3P14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8701.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(261022113327099003)(261102123227099003)(261009223027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRiaUR3MWJ1eTQvRXoyVnhyYzQyajY3c0FoazJabTFhbWdNOHhUMm54dUow?=
 =?utf-8?B?R2ZlVyt2YWVVOVBOdmdCOWVZZ3I5cG9oK0ZENVJXanJodWI4SGZTRWZHdWI3?=
 =?utf-8?B?MzBjbFFUeVlia2wwSHhhZ25hRStJMDdLRDJyWi9nOGtFejFEbWR0ZU5yb1B3?=
 =?utf-8?B?MS9reXp4S0toN2FUYUJpV2FsZXNyaWppMnpJeEU4a3lwL0drRU9YbUtFZHlX?=
 =?utf-8?B?OWMzK3VEY2xVMEJWZkg3bHZQYjVxaWRaQUMwbUNQR2g2M0tPTXFSaEpYWWlH?=
 =?utf-8?B?T0phYWlUNjFjY04wSG1CWmgyNGV1MUxDUVcrWmk0b1VtNjFDbmppMi8vWmVj?=
 =?utf-8?B?bTJNd3ROWUhEM2t5OVE5YVREbWhRMG90bXErQXp2NENtR05NVG9IemJaM0k4?=
 =?utf-8?B?R3hiOTR6ckR6eVBsR2RSWUhESlE0azBkWitUVWYyLy9uVTJMOTY1dEJ3Z01U?=
 =?utf-8?B?VENTRHEveTFpY1JSYmNham1rVk9YZkZUY01VK2tqb2NXME5na2FxNTZHS004?=
 =?utf-8?B?Z3E2OW92SDcxVVdWZlFaVTA2eHdINTNVZWV4bDFJZzNTb2wzVW1ZeFV6T0p1?=
 =?utf-8?B?WkFUMFdIc1Z0MVVTdEFiWUJDMnh1VzMzcnNxL3phQkVLdUJYWUdWbUJSTDhE?=
 =?utf-8?B?NE9IdFpyMG81SWwxWVVPMmU2dU5DRW84bVU0bXFOd050Z2liZGx6QkRaODNO?=
 =?utf-8?B?SGNxZWpMenZ5Yjh5UHRrL2FaeXZ0eWFIUnVqem9yemkyTGsrL0xIRFpJR0lU?=
 =?utf-8?B?blZ4dFE5eHEySlB0Qmd2N09MT3RDM3pxN1BHRyt1RktSRmVacVIra2RYQkE4?=
 =?utf-8?B?MitkZ2FpQW53OW1KSzVhK1ZXVUJkb2Uxc0U5bnQrSDVLSlRHUEtFVzJzbmh6?=
 =?utf-8?B?bUorYURPR3VHZVlLWWtiQWF1L0NsZTM0U3ZUQ1VHaDJwTzdNVDVmR05Hbm9z?=
 =?utf-8?B?d25JUG5EUWF2YXRISHQ3SUFsZnk4UUdBeEt1azBkVnJrV3RqdVV0ZzdUQ0g2?=
 =?utf-8?B?cGk5MkFVYkcrUkpmUHlhZjNoc1VIOVArSzhOSytjUmpGUmRobFllYzBwRWdW?=
 =?utf-8?B?aUttcmJIWDhkdFAzTWtNbkVIaVNGQlRKWWltTE9oZHhBdWhLUlZJVWZXQjB1?=
 =?utf-8?B?N2xEbTFORHp1TEVkT2YwcGFNNy9GS1psTytadzN2aGZONWhuRm1VVkltV2tO?=
 =?utf-8?B?UDhXQUhiY0JiV0pwOEg1bmllY21INnpkZ2VvdTUvSTBEdlZnM3VJNnJaQ3RE?=
 =?utf-8?B?QS8zczg1bzBBWUU3Vk43aXJyVUZFSVRodm96ZzNoZXJnWUY0SzRzZGtQR2lZ?=
 =?utf-8?B?Z0o5YlZDc1hPa1YxcjFjZWQ4cTZXNWx1SjFNSG1yYmxLTW1ua2Nib0I2Nkhk?=
 =?utf-8?B?ZG9IMXV5U256WUhmQU9ZVUl2dWVkdFJiOG1oVzRkOGE2QkM1MUo2UkNwc3pu?=
 =?utf-8?B?cEtVOFBHOHA4dm14T0R6SExKRlgvUnB1cnhvUkI3V1Y1UVRwdjg4N2thczJh?=
 =?utf-8?B?S3hKOFhWTUFVSEc2NVQ2cS9oQmk0eU51SldzZWR6VUh1MjU2Wm5ER3ZMSzBm?=
 =?utf-8?B?bEpUN1ZMMDRlUVBLc1FQUnNkWXRHME9WQTh2eXJYSUljTnlZWGEwUVhoZ1lQ?=
 =?utf-8?B?R2JiVllwaHNSNWNRTWxRNkQxTW40T1dya243bHB3TkMwRkczc0JCbTFhODRT?=
 =?utf-8?B?aHVtazZ3MTFLN0Z6WUlmTjdpT2ZQOXV6WG5NSzB4TUtKcUF3WVpvT2JzR3R4?=
 =?utf-8?B?VHJHdGNkc3BqMTlINlpwRHhDdndGcklZK1JpdUxNQVdUUVR2aW14NUJ6cDc0?=
 =?utf-8?B?Y1RhdlBjU295aTNJSjIwOGtwUW16Q2Y3dEtSOE50SDlvcmJxQi96dHJCL20r?=
 =?utf-8?B?bXZJcXhVOTVEMFZVSk5sMEJwYUh1Ny9zTTZDT2JXdkJFUEJpQTZnUWp2cmg0?=
 =?utf-8?B?aDRzNXc2eDJrRWhpczVuYzRwQ3dsUFZVbnNJQTV4NUlhMnE0SmNVNTZpSzZ3?=
 =?utf-8?B?YWJVbFJjdHUvSWFRNmZGQmN5VEh1TDdkbllDK3ZNM3d4SG9SYkZLTFlWTkVn?=
 =?utf-8?B?ZFcvekMzYXV0NjVPNXlWV0JWSEhqNWtLYURGK0tja0ozZ3IvZFpVQlJ3YS9R?=
 =?utf-8?B?ZThoN2tMajhKZkY2SmErbnBpcEJERHlXNHlrbnFDTUdqKzFrejFsYURnNDB2?=
 =?utf-8?B?SW8wUkNjUEJmSGJNQzZxM3JTOVZpY2tSY3N0MDdjTm9DYUtYSC9ZbXpnSzVE?=
 =?utf-8?B?WUJhUVNLeGRSTnZWbWtZTUxOQmwwQ09XV3dQc2Z5YU5qcEY4Y2RDVm9nRWZI?=
 =?utf-8?B?QUlZc1Y5NnFTWER5ei9tS25PR2F2bnFnOEN0b2pGZUZhaU43MXRvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686c9f8a-0f4f-4d0e-5719-08df416fc0e6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8701.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 10:20:34.6023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI8t4jHRrOyihuG57t29Jfm/OSQyYW191gwOdIj70yudzYxOzE8LczI19J9x+QoDXbEIfQhHZdX+SqJewhbgrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/11/2026 9:28 AM, Wayne Lin wrote:
> This DC patchset brings improvements in multiple areas. In summary, we highlight:
>
> - Build DCN401 virtual commits and seamless plane updates in DC2, and
>    dispatch the hardware span of a commit through dc2_funcs.
> - Add the leaf block-sequence entries a virtual commit needs, and read
>    the accelerated-mode bit through a query builder.
> - Resolve watermark policy and the DPP, DTBCLK and DCN401 DENTIST
>    targets when the sequence is built.
> - Fix DSC teardown gating in the post-unlock sequence.
> - Move HDMI FRL status polling outside dc_lock and stop it on fini.
> - Relax stutter constraints for DRR streams, including ramless idle,
>    track static-screen idle, and enable the relaxation on DCN42. Raise
>    the DCN42 DDR5 stutter latency.
> - Let DC_PSR_MASK enable PSR without a DMUB PSR cap.
> - Enable HDCP on DCN6 and the DF C-state vote on DCN42B.
> - Enable SST PCON FRL DSC passthrough and program the correct DP HPO
>    APG instance.
> - Exit IPS before checking flip pending, and keep the HPD IRQ reset
>    path from taking dc_lock.
> - Skip UPSP programming when the registers are absent, and skip
>    visual confirm color programming when firmware owns it.
> - Align DCN42B with DCN42 and extend the IOMMU mismatch workaround to
>    DCN42B. Restore the missing DCN6 vtotal cap and vstartup assignment.
> - Update the DMUB interface to 0.1.83.0 with an extended SoC bounding
>    box, RAMLESS_LOBF commands, and a seamless-boot eDP request.
> - Initialize the DMUB LSDMA ring, accept a 1932-byte PSP footer, and
>    update the default VCO frequency.
> - Fix the FFE link-rate change path and the p-state enable sequence.
>    Commit the validated target when a minimal transition cannot be
>    built.
> - Fix KUnit tiled EDID size
> - fix hubbub read state logging
> - skip_lcdvdd_off for eDP link lost retrain
> - Don't shrink zero-area recout in full viewport visual confirm
> - panel specific wa not fall back to tmds
> - Use expanded DMUB-provided SoC BB and IP caps
> - Only force P-State on first plane if TTU is below WM
> - Program the kept-plane scaler in DC2
> - Add and remove two MPO planes in DC2
> - Add DC2 state facts and split the builders
> - Program DC2 commit stereo once
> - Maximum SOP states is 8
> - Use soc_bb hostvm fraction instead of hardcoded value
> - Increase state if dcfclk deep sleep needed exceeds dcfclk
> - Flip dml2_core_utils_get_segment_horizontal_contiguous() Inputs
> - Update DCN6 Calcs
> - Add effective_number_of_dpp parameter
> - Read DRAM channel width from SMU init table
> - Update DCN42B stutter latency to match DCN42
> - Expect VRAM|GTT for the DMUB framebuffer
> - Report QoS latency bounds and request
> - upsp fixes
> - Limit VRAM aperture retrieval to DCN6
> - Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant
> - Seed boot clocks to avoid lowering pre-OS display clocks
> - Account for split pipe overlap in alt channel copy size
> - Get OPP heads and DPP pipes by stream in dc_resource
> - Program ODM 2:1 and 3:1 on one stream in DC2
> - Enable Replay timing sync by default
> - Various cleanups.

Series is

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

Tom

>
> ---
>
> Alex Hung (2):
>    drm/amd/display: Fix elapsed time indentation
>    drm/amd/display: Fix KUnit tiled EDID size
>
> Allen Pan (1):
>    drm/amd/display: Update DCN42B stutter latency to match DCN42
>
> Alvin Lee (4):
>    drm/amd/display: Update indicate pstate enable sequence
>    drm/amd/display: Update DP HPO to use correct APG instance
>    drm/amd/display: Updating missing assignments for DCN6
>    drm/amd/display: Don't shrink zero-area recout in full viewport visual
>      confirm
>
> Aric Cyr (1):
>    drm/amd/display: Ensure exit IPS before checking flip status
>
> Ashwin Santhosh (2):
>    drm/amd/display: Skip visual confirm color programming when FW owns it
>    drm/amd/display: Account for split pipe overlap in alt channel copy
>      size
>
> Austin Zheng (5):
>    drm/amd/display: Fix Stage Optimizer Parameter Naming
>    drm/amd/display: Read DCN6 SOP constraints from the idle row
>    drm/amd/display: Use soc_bb hostvm fraction instead of hardcoded value
>    drm/amd/display: Flip
>      dml2_core_utils_get_segment_horizontal_contiguous() Inputs
>    drm/amd/display: Add effective_number_of_dpp parameter
>
> Charlene Liu (6):
>    drm/amd/display: Extend the IOMMU mismatch workaround to DCN42B
>    drm/amd/display: update dcn42b based on dcn42
>    drm/amd/display: enable DF C-state vote on DCN42B
>    drm/amd/display: Increase the DCN42 DDR5 stutter latency
>    drm/amd/display: Keep panel power across link-loss retrain
>    drm/amd/display: Keep patched HDMI panels on FRL across detect
>
> Dillon Varone (3):
>    drm/amd/display: Relax stutter constraints for DRR streams
>    drm/amd/display: cleanup tiling and address formats
>    drm/amd/display: Enable DRR stutter constraint relaxation on DCN42
>
> Eric Bernstein (1):
>    drm/amd/display: Skip UPSP programming when UPSP regs are absent
>
> Fangzhi Zuo (4):
>    drm/amd/display: Correct the forced YCbCr420 comment
>    drm/amd/display: Move HDMI FRL Polling Outside dc_lock
>    drm/amd/display: Stop HDMI FRL status polling on fini
>    drm/amd/display: Enable SST PCON FRL DSC passthrough
>
> Gabriel Abarca (2):
>    drm/amd/display: Increase state if dcfclk deep sleep needed exceeds
>      dcfclk
>    drm/amd/display: Update DCN6 Calcs
>
> George Zhang (1):
>    drm/amd/display: Don't let HPD IRQ handler take dc_lock in reset
>
> Ilya Bakoulin (1):
>    drm/amd/display: Fix FFE test automation link rate change
>
> Ivan Lipski (4):
>    drm/amd/display: Initialize DMUB LSDMA ring buffer
>    drm/amd/display: Enable HDCP on DCN6
>    drm/amd/display: Use expanded DMUB-provided SoC BB and IP caps
>    drm/amd/display: Limit VRAM aperture retrieval to DCN6
>
> James Lin (1):
>    drm/amd/display: commit validated target when minimal transition
>      cannot be built
>
> Jing Zhou (1):
>    drm/amd/display: Seed boot clocks to avoid lowering pre-OS display
>      clocks
>
> Karen Chen (1):
>    drm/amd/display: fix hubbub read state logging
>
> Nevenko Stupar (1):
>    drm/amd/display: Update default VCO frequency
>
> Ovidiu Bunea (1):
>    drm/amd/display: Only force P-State on first plane if TTU is below WM
>
> Piotr Maziarz (3):
>    drm/amd/display: Resolve clk_mgr DPP DTO targets when the sequence is
>      built
>    drm/amd/display: Resolve clk_mgr DTBCLK DTO targets when the sequence
>      is built
>    drm/amd/display: Resolve the DCN401 DENTIST divider when the sequence
>      is built
>
> Rafal Ostrowski (4):
>    drm/amd/display: Remove duplicate block sequence leftovers
>    drm/amd/display: HWSS Refactor - Watermarks
>    drm/amd/display: Fix DSC teardown gating in post-unlock BLS sequence
>    drm/amd/display: Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant
>
> Ray Wu (2):
>    drm/amd/display: Allow DC_PSR_MASK to enable PSR without DMUB PSR cap
>    drm/amd/display: Enable Replay timing sync by default
>
> Sreeja Golui (2):
>    drm/amd/display: Include Ramless Idle in stutter relaxation
>    drm/amd/display: detect static screen state and propagate
>
> Sridevi Arvindekar (1):
>    drm/amd/display: Bypass chroma upsampling without the DPP cap
>
> Taimur Hassan (4):
>    drm/amd/display: [FW Promotion] Release 0.1.83.0
>    drm/amd/display: Promote DC to 3.2.406
>    drm/amd/display: [FW Promotion] Release 0.1.84.0
>    drm/amd/display: Promote DC to 3.2.407
>
> Tony Cheng (13):
>    drm/amd/display: Dispatch commit_state_hw through dc2_funcs
>    drm/amd/display: Add leaf BLS entries for a virtual commit
>    drm/amd/display: Build the dcn401 virtual commit natively
>    drm/amd/display: Build the dcn401 seamless update in DC2
>    drm/amd/display: Read accelerated mode through a query builder
>    drm/amd/display: Build the kept-plane surface update in DC2
>    drm/amd/display: Skip first-enable steps on a kept plane
>    drm/amd/display: Program the kept-plane scaler in DC2
>    drm/amd/display: Add and remove two MPO planes in DC2
>    drm/amd/display: Add DC2 state facts and split the builders
>    drm/amd/display: Program DC2 commit stereo once
>    drm/amd/display: Get OPP heads and DPP pipes by stream in dc_resource
>    drm/amd/display: Program ODM 2:1 and 3:1 on one stream in DC2
>
> Wayne Lin (1):
>    drm/amd/display: Expect VRAM|GTT for the DMUB framebuffer
>
> Wenjing Liu (2):
>    drm/amd/display: Read DRAM channel width from SMU init table
>    drm/amd/display: Report QoS latency bounds and request
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   17 +-
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   |   16 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   15 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    3 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    9 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   10 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    3 +-
>   .../tests/amdgpu_dm_connector_test.c          |    9 +-
>   .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |   45 +-
>   .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |   27 +
>   .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |    6 +
>   .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |   35 +-
>   drivers/gpu/drm/amd/display/dc/Makefile       |    3 +
>   .../amd/display/dc/bls_builder/bls_builder.h  |    6 +-
>   .../dc/bls_builder/bls_builder_internal.h     |    2 +
>   .../bls_builder/bls_builder_private_types.h   |  137 +
>   .../dc/bls_builder/dcn401_builder_internal.h  |  110 +
>   .../dc/bls_builder/dcn401_init_builder.c      |   36 +
>   .../bls_builder/dcn401_non_seamless_builder.c |  501 ++++
>   .../dc/bls_builder/dcn401_seamless_builder.c  | 2235 +++++++++++++++++
>   .../display/dc/bls_executor/bls_executor.c    | 1076 ++++++++
>   .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   83 +
>   .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  170 +-
>   .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   15 +-
>   .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   31 +-
>   .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   25 +-
>   .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h        |    1 +
>   .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |    3 +-
>   .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  157 +-
>   .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |   14 +-
>   drivers/gpu/drm/amd/display/dc/core/dc.c      |  115 +-
>   .../drm/amd/display/dc/core/dc_hw_sequencer.c |  317 ++-
>   .../gpu/drm/amd/display/dc/core/dc_resource.c |   48 +-
>   .../amd/display/dc/core/dc_resource_helper.c  |    7 +-
>   .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  341 ++-
>   .../gpu/drm/amd/display/dc/core2/dc_core2.h   |    1 +
>   .../drm/amd/display/dc/core2/dc_core2_init.c  |    2 +-
>   .../display/dc/core2/dc_core2_legacy_init.c   |    2 +-
>   drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
>   .../amd/display/dc/dc_api_dispatch/api_shim.c |   25 +
>   .../amd/display/dc/dc_api_dispatch/api_shim.h |    9 +-
>   drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    1 +
>   .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |    1 +
>   drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   16 +-
>   .../gpu/drm/amd/display/dc/dc_spl_translate.c |    8 +-
>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |    3 +
>   .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |    4 +-
>   .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |    4 +-
>   .../dml21/inc/dml_top_display_cfg_types.h     |    1 +
>   .../dc/dml2_0/dml21/inc/dml_top_types.h       |    2 +
>   .../src/dml2_core/dml2_core_dcn4_calcs.c      |    2 +
>   .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   75 +-
>   .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |   30 +-
>   .../dml2_core_dcn6_funcs_mode_programming.c   |   34 +-
>   .../dml2_core_dcn6_funcs_mode_support.c       |   19 +-
>   .../src/dml2_core/dml2_core_shared_types.h    |    3 +
>   .../dml21/src/dml2_core/dml2_core_utils.c     |    4 +
>   .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   20 +-
>   .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h |    4 +-
>   .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h |    8 +-
>   .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   19 +-
>   .../src/inc/dml2_internal_shared_types.h      |    4 +-
>   .../dml21_wrapper/dml21_translation_helper.c  |   17 +-
>   .../dc/dml2_wrapper/dml2_mall_phantom.c       |    1 -
>   .../display/dc/dml2_wrapper/dml2_wrapper.h    |    1 +
>   .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |    2 +-
>   .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |    4 +
>   .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |    3 +-
>   .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |    1 +
>   .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |    8 +-
>   .../display/dc/hubbub/dcn201/dcn201_hubbub.c  |    3 +-
>   .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |    3 +-
>   .../display/dc/hubbub/dcn21/dcn21_hubbub.h    |    1 +
>   .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |    5 +-
>   .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |    1 +
>   .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |    5 +-
>   .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |   23 +-
>   .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    7 +-
>   .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |    1 +
>   .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   12 +-
>   .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |    3 +-
>   .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   20 +-
>   .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |    3 +-
>   .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |   52 +-
>   .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   61 +-
>   .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    9 +-
>   .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   48 +-
>   .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    9 +-
>   .../amd/display/dc/hwss/dcn302/dcn302_hwseq.c |   15 +-
>   .../amd/display/dc/hwss/dcn302/dcn302_hwseq.h |    6 +-
>   .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c |   11 +-
>   .../amd/display/dc/hwss/dcn303/dcn303_hwseq.h |    6 +-
>   .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    8 +-
>   .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |    3 +-
>   .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   15 +-
>   .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |    3 +-
>   .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    7 +-
>   .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |    3 +-
>   .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  180 +-
>   .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    2 +
>   .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 +
>   .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |    9 +
>   .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    1 +
>   .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    2 +-
>   .../drm/amd/display/dc/hwss/hw_sequencer.h    |  422 +++-
>   .../display/dc/hwss/hw_sequencer_private.h    |   14 +-
>   .../amd/display/dc/inc/dc_core_interface.h    |   12 +
>   .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   38 +
>   .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   22 +-
>   drivers/gpu/drm/amd/display/dc/inc/resource.h |   21 +-
>   .../display/dc/inc/soc_and_ip_translator.h    |    4 +-
>   .../drm/amd/display/dc/link/link_detection.c  |   26 +
>   .../dc/link/protocols/link_dp_irq_handler.c   |    8 +-
>   .../display/dc/link/protocols/link_hdmi_frl.c |   30 +-
>   .../dc/resource/dcn42/dcn42_resource.c        |    2 +
>   .../dc/resource/dcn42b/dcn42b_resource.c      |    5 +-
>   .../dc/resource/dcn60/dcn60_resource.c        |   30 +-
>   .../dcn401/dcn401_soc_and_ip_translator.c     |    4 +-
>   .../dcn42/dcn42_soc_and_ip_translator.c       |    4 +-
>   .../dcn42b/dcn42b_soc_and_ip_translator.c     |    4 +-
>   .../dcn60/dcn60_soc_and_ip_translator.c       |   96 +-
>   .../amd/display/dc/state_facts/state_facts.c  |  294 +++
>   .../amd/display/dc/state_facts/state_facts.h  |  132 +
>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  213 +-
>   .../amd/display/modules/power/power_replay.c  |    2 +-
>   125 files changed, 6985 insertions(+), 905 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
>   create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
>   create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h
>
