Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA6FD0D78D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 13:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E2610EAE7;
	Fri, 11 Oct 2024 13:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4jurD8rd";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFFC10EAE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 13:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVdAdSaa/UpEsUPsf9B/BiakNoCkCa6r1RY2//Lma3mPuptLSnnLbq3wzUQ6CBbKPfe5Gq+MpzXG596YK4QXMDXOA4Fhdt+OQhfBpTcCFDRCOL9la8hSTChBO50pHJSBZtMfUxH0Z8ehuJGZUydySIsW4s+ola0wQYO+MRi4RxtKi+fNB2Ud0mNuqLhoSrxcbT9dMnVML49AaKGD8c8Us/4ux48Z4LrvJrL4/ea6InuJR96J4xfY0UT/ThUHEWac3tAlQh6lA666Z3fN56FrPXRqd2DUbgs2+r8PmdSyrD7w4TYWNn+0BTGDH4nyGuYmBjyZ6XdKdZJo3MhIoy67gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abEGvAC+HmZkRPlPco5i0jS0SrrMLMM9GLgdARGbgFM=;
 b=YPu3/Y4XtYLgHOYn90DwLThOY7SCt2Hnu/mztqFLA9J8IQIV7h9fybWdNC4GsdU5etlVZqPh3d8QV5I2z4nv2JXAdaBFuNekedlPu/3HXHU2T4LyH1Uo5BcdFqW99F4BjImOv2fGk9o/bVcTpNhb9uK/Gyq/JeVa5BmdMkOf+4p+KTMP68l2etrXPhxZOXkt5iMvHn+YOa9A2UuO8RHyE3Jd9W5xx6/z2UaBA0JF3Immd/3gw+ElkmnGRQawFFnuclcSEOF/iEMew77kMYszwJmjdazdcpCM3dqfURVS9sN5/emLnh38+RWEy8gAAuD9G8vbA/I7LFdsd4ImMe0r8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abEGvAC+HmZkRPlPco5i0jS0SrrMLMM9GLgdARGbgFM=;
 b=4jurD8rdn5xEBjienSz9/SMJo20FgfZu6W8W/rBVMpzHpqh1oG5e2Rt/JuwvcpccZx77XgbaIxbWDUkT1TlVDnTnN5YDg2HJAWADNiaMTeSsVY197IhCy1mHFgmXTtu0fJ0wYz7Yhz10deFXede37qa5oiLmnIoyj3IGZYDP3UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 13:23:23 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 13:23:22 +0000
Message-ID: <5f6f5e6f-3c1b-30ff-cab8-231544a63976@amd.com>
Date: Fri, 11 Oct 2024 09:23:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Accounting pdd vram_usage for svm
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241004202808.30740-1-Philip.Yang@amd.com>
 <d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d1af40-8bc7-4dda-9d93-08dce9f7e12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG5QdkxER3J0akdpTk9RNjNDV09va2lQL1RWSDBnTnlUZVNLY3EvTGpuNERI?=
 =?utf-8?B?UGFGeHk3dTJSb3M2dkFMdlBIOVlBd0xRNUdlWWdvWGtsaFo5cU1PRHFLdnly?=
 =?utf-8?B?RFhCVXYwTS84SGplc3F6eDczQ29BZHAvWmZ1bGlETGs4aFh1TERoSUFFTk4y?=
 =?utf-8?B?akI5WjFlQU1McFBrbXUya3VUbWFVeFpNVTYyUjJQVGhyZThiQ2xhbjFkUEZL?=
 =?utf-8?B?OVhOUjkzZTkvdkk1d0Y1V3NwZ2c1WXFEOTRTQU5NYytmakhDWElDTlJCQVkz?=
 =?utf-8?B?d2FIWVUzbFFQQnI1SitSNUpOeWxvY0NkdFlPWDhsUlFiU09zM2ZmYlRLeXpG?=
 =?utf-8?B?SU0xYzdqSDltekgvaVZXU3drTDZtZ2cxSy9heU1nWmZRYW1xNXErWFlSNVph?=
 =?utf-8?B?U1dwU01QeTJzRDRhY2NiMG0vd0hxWmRpU0htR1FMN1UxWHZXbG4zREhPczR2?=
 =?utf-8?B?YU5BN0ZoRlhuckFhNHQzQWM0K3k3Y1l4YzBXaS96alVCQng4UmtLbHhSQnFT?=
 =?utf-8?B?L2FGVUhOOFJZL3BRT0REdE5nckJNTkJhRmZnaytSS1dKaTNmSy9JUkNseXpY?=
 =?utf-8?B?SXpJSGg2aktmaEdQUlp3OUk5Nkg3d2lIdUtUQWhweTk5WnE2VitBbEQ3YTV2?=
 =?utf-8?B?cFRCMU1xSVdWa2hFZzhQZGRWWkowWTZoV0paUmRLR1kva3Nkc1hyamVzZzA0?=
 =?utf-8?B?MzVNZVFRUEhKaE5tc0h2U2R5K0VMUTY3MCt6VnhrRnVXSU9xK3RiZWZ6U2h6?=
 =?utf-8?B?aGk4OXUwSThWcU5zakwxVUh2MW1hU3JYMkRvMWJTeDVtdzYyQjNUVDVHVTc3?=
 =?utf-8?B?d3NtQldIY2tObm5xUU0vdjBJcThJeVVXWnVlVDFuQTFGc0E4V1NBU1ZTOGxz?=
 =?utf-8?B?bVB6RTVQOWo2Y2c1UUdZMUNqWGFBbjRVOE02UUhJN1loVEU2ZldWWUhyRjhP?=
 =?utf-8?B?Y1lxRXdtRmZsS0ZvRjBCQVljS29LOG1QTDJmVXUrejhRaGtxbTFsTFJabmZv?=
 =?utf-8?B?MEZ4TkF2Sm9OTUtSb2txaTZKVFd5NWUvNXZXc0JqT3hmVDZuZWswZWg5Uk5O?=
 =?utf-8?B?dnBvYXpwSzcyVWc0azBwNkFFd2JWT252Vy9neFl0bEVGemhKbFBONGlSMU5t?=
 =?utf-8?B?T3R0RytFOGp6YXA3WHJla09tQXJLZjVMcTNUcTFsRjR6OUpPc2hMbzJWS2po?=
 =?utf-8?B?elU5QUhyMUhYWlgwQW5DN0FnVStsWjFoeG5pbklEQmJBd3Rpdk5sZXdseUhX?=
 =?utf-8?B?TnJXcTZmRm02ZlJqVllheUZ0Vmd2VXdybHhRMFlWblp2WGxGRVgvRUFxRVpT?=
 =?utf-8?B?V0pEMXlFOE54ZUpPRG50RmJrL3Z0Q1BKWURvQTNKQVhZblQrd013c29Jc1NK?=
 =?utf-8?B?ODkvVkc1UXRNSzJhQ3lkODluODRpSk50NTUyZE5QZHZqQnh4ZzBkWFNVQi9R?=
 =?utf-8?B?Njh3dHhBdVVpS296a0d2c3lGaGgxM0trRW1LVm9MdVVnaWlkU0RpYWg2OUNm?=
 =?utf-8?B?Q1lKTjEvUmxDN1hxaGZSL2FtNlFPeGQ3VVhHYmdtQVNIMlV1dXQxUlp6V3ZO?=
 =?utf-8?B?WTkrRFQ1YTlCWE5yUU9UNkFSek05aytMNFZqdGJUWVQ5aW51dXNsUStOQ1l1?=
 =?utf-8?B?QlNJZjVBSTUvaGtRd2ZhSVdHZGlMVjkrREZSc1pZaHlpQTF4ZDRiQ09TN1pX?=
 =?utf-8?B?L2IyaG9iTG9SSVpGeW16T0pBVFQvdHVGbjg0N2ZzZWszanFqTHd1Si9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWV1SzltL3pkNm0vT1p4RlA0TDBlQkYzRkJKVC8xWWkra0pFMmdLLzM0MVdL?=
 =?utf-8?B?TjNuNFN5bEwzWE9BVGlFQ0lEZXB6RnZISlpQajQ4aSs0NERFN09JVEVXTnFj?=
 =?utf-8?B?aFJka09hTXNoeGUyNE1zY29EbFJhOUp3QTFaSHhQalVVaitud20rTUd2MjE4?=
 =?utf-8?B?ZlUvNXkvRERURy9VTlgrcUc1Tzk2eFR2UURkYStnWm9NdmNqVXBibEpaYU5E?=
 =?utf-8?B?ZjhTTVVsRWxoQ2I2OVUvL2hYbXdtU0dBS3l5T3NkVFkyQ2NKMjFiM1NmT0FT?=
 =?utf-8?B?N3NYU3FGL2c0V01XM2xNb0RZcmJJZ082OVVFdkYrV0lOTmIxM2YwS1hreklw?=
 =?utf-8?B?T1UwNW5YQU5majRRNlErQ2ZMd2ZSUUZBL3FSRWZyL2IvVUE5QUNXbklnZjdN?=
 =?utf-8?B?R1pCWCs2QWxnVFlDQ3FGaGUwbG1yUis2ano1YVNkaHpZTjc0dEpxcVZnQmdX?=
 =?utf-8?B?d2UxNjU0Qjd1Qlo3Q0FhVzVIb0p2N1NWSnhacTlWWUUxbEFhdlpaTEtiTEdP?=
 =?utf-8?B?REJGWHpWSFdiWkx4NFVQL2FaemVtdFZwN2s5dXVlOHYyUVUwNEtmMktGNG8v?=
 =?utf-8?B?RlVBTUpsVGdFSnNmbnRtc0JiV1N6VThXd0IvamRPTjFYN3dwdVYyemtwMUdn?=
 =?utf-8?B?SmRRblUvbi9nMHg2d1dXcC9CYjM4VnE2Ump5UjBNWW9PZjNxZzU4Yi9mMzVN?=
 =?utf-8?B?YmdYaHpVcDBaK1hHbFlnaWxRSGtTU0NzSUFaRWpoYnNDU1ZyWUZ1VWRMaDdD?=
 =?utf-8?B?akJnenBVNWo2MS9tOHllRDJHODltZnNIMkdOc2xKVHFFWDEvUk5DKzNLV1lM?=
 =?utf-8?B?Ym80S1g1ZzVha2pKZ1ZhZmJ6ekdXOVU3S081cElwSDk0ZjBGN2VET0JjMHBv?=
 =?utf-8?B?b3VZMkZ3dVZJR1ZFZEpiY1JqeVBjNTFzZDQyOGZJOEZUeGg5VEFOQVl6ZGNq?=
 =?utf-8?B?bGY0emxyZ0NZaUY3Y280Vk11MU5xNXZieklvQUVuRTQrSFdiNmd4NGRvcEtG?=
 =?utf-8?B?Qkh3bFU3RW1KMXdSSUFRR2R4MUR5ZTJCc1Jib2VmM2R0YkZ5QmFPdjI5aDFm?=
 =?utf-8?B?d0UvU2VVWTRsTHdVa1pPUkUzWGF1V2RSYVlXdmR0UjBBQkllclRYVmdqSm50?=
 =?utf-8?B?VjI2c0Z5UVpBZkI1czR5aUd2UnhNM1I5VFNDQ240TXE5UzRRWU1KTExqdlNr?=
 =?utf-8?B?UFFhNUJjMm9mL0RMSHNBazJIbDkxSVplNWR4VmNBQ1JQYStHUzY5OVJEbVFq?=
 =?utf-8?B?dUZ0Z0o0dzlRdldwc2dQbHZPYjlsNktQZUFzZndncWg0NmExT1FUc0JhME1t?=
 =?utf-8?B?QU5GdHNId0pqeDJ6STdZek14elVxZS9QWnExWC9FZEdWc0NXZ3VtRXJvSjdz?=
 =?utf-8?B?TVpncVNESGtaN3BvVEkzTFdpR0hjOXJ4K1NucHE1aXJ6Uy9oQmxCZ3FwVEFS?=
 =?utf-8?B?RUQyRW50WDZhNTN6N3JKK1lHRmhVcUR0Q3N3eW9iWTRrMkJOekg1aUdqZndH?=
 =?utf-8?B?cHhWTm5DbEJwcjd6VWRkaDRpVWxvN2tkSjJtcUdjTTJEd1RIRGtaemtXcTlp?=
 =?utf-8?B?aW8wNFJLanVXOXk3Z25NTEY0TTIzRVBrYVB4Y0JRUEcxTk8yL2tqd0kwREZm?=
 =?utf-8?B?NEttb25FQmlGbmZxemxXNytXVVo1azROUnhEOVVwdEdEVWpvWitPc1VzbnA5?=
 =?utf-8?B?ZXRpaVYxS2ZUTCsvVDUyaU9WcG8wQVRzNjlQSThRUkRMaWFEYkJHQXIyeFB4?=
 =?utf-8?B?Zml5c1VXMkhWZ2oyTm1QcTlPYUFQRWk1c2R6L1BzUkNjTHZSZk5NYk9Tak90?=
 =?utf-8?B?WkV0cHVVN0J4QWo4OW10UXNkN1dFNGhicG1zZ1hZMWZYTjhENFVmZitCRXk2?=
 =?utf-8?B?b2I2SUgrditFTnZYdG5Uc1dNcUt6QWp0bUtCR2VJbnd4cVZmNC83OUJSRlFa?=
 =?utf-8?B?eDM2TnZpNGVvTmdEQ2dqckNYdmJvalhzMUtrVkpoRDJaN2xhUjZhZ0pKaEtL?=
 =?utf-8?B?WjZDNlhhclYxYStveGR4cWdQcUNxMU5pWWlSajY5aVM4ZG5LTjdETno5WkNx?=
 =?utf-8?B?TXQ5a2Vpb1pVMG02MHh4SFZPWUhVRy9Nb2Z1cUJuQktrQ204YUpyeUo2djRk?=
 =?utf-8?Q?tCaY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d1af40-8bc7-4dda-9d93-08dce9f7e12f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 13:23:22.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1nCH/N35AJvj0G4he/wEAgjd0ymG0eyrq+TAQcSP8bg3/AXCteq/klhhZOawygr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-10-09 17:20, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com">
      <br>
      On 2024-10-04 16:28, Philip Yang wrote:
      <br>
      <blockquote type="cite">Per process device data pdd-&gt;vram_usage
        is used by rocm-smi to report
        <br>
        VRAM usage, this is currently missing the svm_bo usage
        accounting, so
        <br>
        &quot;rocm-smi --showpids&quot; per process report is incorrect.
        <br>
        <br>
        Add pdd-&gt;vram_usage accounting for svm_bo and change type to
        atomic64_t
        <br>
        because it is updated outside process mutex now.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |&nbsp; 6 +++---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 4 ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 22
        ++++++++++++++++++++++
        <br>
        &nbsp; 4 files changed, 28 insertions(+), 6 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index a1f191a5984b..065d87841459 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -1148,7 +1148,7 @@ static int
        kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &gt;&gt;= 1;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(pdd-&gt;vram_usage, pdd-&gt;vram_usage +
        PAGE_ALIGN(size));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_add(PAGE_ALIGN(size),
        &amp;pdd-&gt;vram_usage);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);
        <br>
        @@ -1219,7 +1219,7 @@ static int
        kfd_ioctl_free_memory_of_gpu(struct file *filep,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_device_remove_obj_handle(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd, GET_IDR_HANDLE(args-&gt;handle));
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; WRITE_ONCE(pdd-&gt;vram_usage, pdd-&gt;vram_usage -
        size);
        <br>
        +&nbsp;&nbsp;&nbsp; atomic64_sub(size, &amp;pdd-&gt;vram_usage);
        <br>
        &nbsp; &nbsp; err_unlock:
        <br>
        &nbsp; err_pdd:
        <br>
        @@ -2347,7 +2347,7 @@ static int
        criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (bo_bucket-&gt;alloc_flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_bucket-&gt;restored_offset = offset;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update the VRAM usage count */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(pdd-&gt;vram_usage, pdd-&gt;vram_usage +
        bo_bucket-&gt;size);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_add(bo_bucket-&gt;size,
        &amp;pdd-&gt;vram_usage);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 6a5bf88cc232..9e5ca0b93b2a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -775,7 +775,7 @@ struct kfd_process_device {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_pdd_bound bound;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VRAM usage */
        <br>
        -&nbsp;&nbsp;&nbsp; uint64_t vram_usage;
        <br>
        +&nbsp;&nbsp;&nbsp; atomic64_t vram_usage;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute attr_vram;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char vram_filename[MAX_SYSFS_FILENAME_LEN];
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index 7909dfd158be..4810521736a9 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -332,7 +332,7 @@ static ssize_t kfd_procfs_show(struct
        kobject *kobj, struct attribute *attr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
        struct kfd_process_device,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_vram);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;,
        READ_ONCE(pdd-&gt;vram_usage));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;,
        atomic64_read(&amp;pdd-&gt;vram_usage));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(attr-&gt;name, &quot;sdma_&quot;, 5) == 0) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
        struct kfd_process_device,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_sdma);
        <br>
        @@ -1625,7 +1625,7 @@ struct kfd_process_device
        *kfd_create_process_device_data(struct kfd_node *dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;bound = PDD_UNBOUND;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;already_dequeued = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;runtime_inuse = false;
        <br>
        -&nbsp;&nbsp;&nbsp; pdd-&gt;vram_usage = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; atomic64_set(&amp;pdd-&gt;vram_usage, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;sdma_past_activity_counter = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;user_gpu_id = dev-&gt;id;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_set(&amp;pdd-&gt;evict_duration_counter, 0);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 857ec6f23bba..61891ea6b1ac 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -379,6 +379,7 @@ static bool svm_bo_ref_unless_zero(struct
        svm_range_bo *svm_bo)
        <br>
        &nbsp; static void svm_range_bo_release(struct kref *kref)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_bo *svm_bo;
        <br>
        +&nbsp;&nbsp;&nbsp; struct mm_struct *mm = NULL;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_bo = container_of(kref, struct svm_range_bo, kref);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svm_bo 0x%p\n&quot;, svm_bo);
        <br>
        @@ -405,6 +406,22 @@ static void svm_range_bo_release(struct
        kref *kref)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svm_bo-&gt;list_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;svm_bo-&gt;list_lock);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (mmget_not_zero(svm_bo-&gt;eviction_fence-&gt;mm)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;
        <br>
      </blockquote>
      <br>
      Move struct mm_struct *mm here as well. It's only needed in this
      block and should not be used outside.
      <br>
    </blockquote>
    yes, mm is only used here. If changing svm_bo-&gt;node to
    svm_bo-&gt;pdd, the entire block will be dropped.&nbsp; <br>
    <blockquote type="cite" cite="mid:d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com">
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = svm_bo-&gt;eviction_fence-&gt;mm;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = kfd_lookup_process_by_mm(mm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = kfd_get_process_device_data(svm_bo-&gt;node,
        p);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_sub(amdgpu_bo_size(svm_bo-&gt;bo),
        &amp;pdd-&gt;vram_usage);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmput(mm);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (!dma_fence_is_signaled(&amp;svm_bo-&gt;eviction_fence-&gt;base))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We're not in the eviction worker. Signal the fence.
        */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        dma_fence_signal(&amp;svm_bo-&gt;eviction_fence-&gt;base);
        <br>
        @@ -532,6 +549,7 @@ int
        <br>
        &nbsp; svm_range_vram_node_new(struct kfd_node *node, struct
        svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool clear)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_bo *svm_bo;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_user *ubo;
        <br>
        @@ -623,6 +641,10 @@ svm_range_vram_node_new(struct kfd_node
        *node, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;prange-&gt;svm_bo_list,
        &amp;svm_bo-&gt;range_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;svm_bo-&gt;list_lock);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; pdd = svm_range_get_pdd_by_node(prange, node);
        <br>
        +&nbsp;&nbsp;&nbsp; if (pdd)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_add(amdgpu_bo_size(bo),
        &amp;pdd-&gt;vram_usage);
        <br>
        +
        <br>
      </blockquote>
      <br>
      Would it make sense to save the pdd pointer in the svm_bo struct?
      The effort to look up the mm, process and pdd in
      svm_range_bo_release seems quite high.
      <br>
    </blockquote>
    Thanks for the good idea.<br>
    <blockquote type="cite" cite="mid:d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com">
      <br>
      You could replace svm_bo-&gt;node with svm_bo-&gt;pdd. Then you
      can still get the node with svm_bo-&gt;pdd-&gt;dev without growing
      the size of the structure. This assumes that the svm_bo cannot
      outlive the pdd.
      <br>
    </blockquote>
    <p>yes, svm_range_list_fini is called before calling
      kfd_process_destroy_pdds after process exit, so svm_bo-&gt;pdd
      will always be valid. I will send new patch series.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; &nbsp; reserve_bo_failed:
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
