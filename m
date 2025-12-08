Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6133DD3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 20:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C724410E181;
	Mon,  8 Dec 2025 20:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jev92ki6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3636910E181
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 20:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv2wDbyCzqKg5fNJdXNd2YI0y7uEsY5CDqdnSS3C87IQYrOLRMzbbrJPDCOIF8z9i37qNb7k5Dri3Rqqbq37jzjCS4BobQJJw6MH/thbv4vVWPa61UBs8WRqUgd1vb/HusctnvqAsrhTVrP8b8yltkExHbSNluGiumkewbUYsuFWeyLHXQNtpMMj5NNspolG4KpohiZwyBzCAN/gKTBogv2WB4yo+zPuuaAgasquNgiJsoceF/AmbkEiVMIs8vwN+1u8v+mHI/PzPkncIGknvyn16HqsqOXddjncZ/m63kxQ+X7kgTmBRI8Bk4xQb64PLSzbjwOHzwbB3D7gdoeMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMEe3Y9rDAWyRZ5f3yj0AkS6XZiOQT6LTSKpuWSrwTM=;
 b=S+vfobCjoFCWzoFRBaKPrwzJhCSa/bkX/6FGwCQesmajyx34+DqN7DMf6qGCt78VQqrhNydarOmi4Joxk3FPAvMq3SFCSGYOupxiIVM63BBNbBS/hdWp630forINXmu37nFkyNpexEhPouxa66SSK/JPPlrOXJ6YSKKDGVfYtdKb1BaQgLiDri8vIRkllPa+J02XMy2Uysgv5qhEBgX5Mz+ilOHl01CRtXO0v4U5VGSkVpyGhMX5yOIOjNPVJXu2bE1EjwZpV94KuaB5FJS4cDg32AuEJBqqcc8dqNoNaVSeNIAYlHO6Wk74DkmqPU1PPI3Sz2uOQNeezkVPHfFqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMEe3Y9rDAWyRZ5f3yj0AkS6XZiOQT6LTSKpuWSrwTM=;
 b=jev92ki6BDiZ3arZP0WjzDWXej26PXQp/Rk0l3+65lSRUfScocTu2x7iX2AaFZmmGsmG7NfXIVvA7cda83a5ZmVFf+zQM1cuhLhXgRmRXEz+xNOUaW8SDIg+S62j8SMKjCptLlDNLvobeEUdkQ07qT3VseXgHnvNci0bOJ7hMAM=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 20:57:50 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::b7) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 20:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 20:57:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:57:48 -0600
Received: from [10.4.12.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Dec 2025 12:57:48 -0800
Content-Type: multipart/mixed; boundary="------------B96JNbdjZNh7e0nsvFd1g7bs"
Message-ID: <303ed7b8-fbd3-400d-86ef-ac93c0c5c291@amd.com>
Date: Mon, 8 Dec 2025 15:57:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Black screen on HDMI power-cycle after commit
 3471b9a31ce3 (7900XTX + LG C3)
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>
CC: "Vojvodic, Relja (Reggie)" <Relja.Vojvodic@amd.com>, "Liu, Wenjing"
 <Wenjing.Liu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CABXGCsOcjjD1f5vCxbv-CCCMZPearMnY6GE-WPc_N=_k1TtfXQ@mail.gmail.com>
 <CABXGCsOfOuWqzV=3wZXSUJRmJpWQf6f3qQ=93=DqtN2ZjhyhGg@mail.gmail.com>
 <CH0PR12MB5284525FDCC5F2261D7FA6BF8BA2A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284880C09ACD7DFB6670ECC8BA2A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CABXGCsMH-4mC9n-ZySb=QtCLkM0eSX1sKaDTzXT8cG9mFS0rRQ@mail.gmail.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <CABXGCsMH-4mC9n-ZySb=QtCLkM0eSX1sKaDTzXT8cG9mFS0rRQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: b93111ca-a595-4338-fabe-08de369c72fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|4053099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXVsK1RSZ25TUjVGYmpvNXZiQ0VNcWlZbFU5dE9uMmdxb3RFMjJGL1N2YjBM?=
 =?utf-8?B?WG1lZTFTejBobFdTZURVV0xyZndnaUU3VkVOcjZEcGtpZGJVZW9nbXNWaFB0?=
 =?utf-8?B?SHZNMmY5ZVMwL1ZHUjRWdzh5UDQyNmhtUmQ4cHRXYkFXUEpIMTl0UjcwL1po?=
 =?utf-8?B?Y0lEVU9NVWxGVjd3QTRMZ2EvdmVQeDduMFhxaldVbGRpQUVSWVNuV3puU1hX?=
 =?utf-8?B?blpCSWMvUHJzVUV3TDVjZFlmUDRlaGRDWWxFRlBzbUlmWStka3czRElaeVNl?=
 =?utf-8?B?Q1ltcnhLZjhaSjFWSGlReXhGZUtRWlpZQTlQS01mYWgzdVBsYzRmRTduVWo1?=
 =?utf-8?B?NEpxQnM2dTYyc1U5RGtFV3JSNFNBYWRULys1RFZlRythOUJwZXNYTGVuKzJ3?=
 =?utf-8?B?VnFleldDb0p1Y212cXVLTHJLRUJyZ3F0cHRpMHdoMXVLb3hmc3o0N0Fyc25Q?=
 =?utf-8?B?ZE5wTG9xYlg1OXN6bnVkNUpBV0hpUFhrTlVDdXdMVVkrMVozR1VwSkI1bTdz?=
 =?utf-8?B?and4Y000M0cwN3JTTHdGRmloaUswdkJkMzdOUUc1SVpaTVYxOUNUbFJCbnZR?=
 =?utf-8?B?WVBsbkxOQ0R0cGp6MlJpYnlJZXBzN3VlOVpwTEZHRzFkR2h0SjNzdjZNK1ow?=
 =?utf-8?B?Uk9BRlZ3SythR0Jud3NLL3hxRU9KMVpwSHRSSCtQVW9LSkIrN3lUVythMW1F?=
 =?utf-8?B?a1E3c08zcVN0VWtRbUF4cVdEQWhOZ1Nxdkt0c3lybUtTd1BHQWR1dEFxVTJl?=
 =?utf-8?B?UU9FWEpBOVlFWWhLNjhWV1IrTlQ1cWxad05waTRLbURCTjQrTEpUbkpSVmNS?=
 =?utf-8?B?MHFhSndYaTV0U0x3YlhhbWhqdUJEVEMzZkpwVHlSRkE1Y0o1M3A0dnJvdnVV?=
 =?utf-8?B?L2VyWFk5dE9uejRDd0dZV0h1bmhyaG95RWtUR3pacDJaVDl6eDQ3RFhkR0Mr?=
 =?utf-8?B?Ym5BK25rWk5kYks5V3JFamtqMy9mbDlrS3FxNTBMSGVYM0tjdk52ZlJIUk85?=
 =?utf-8?B?MDJZUFRMYnNsVk1BWk5CTEJzMFF1Q1UyZFVtQ1JMZGNEeDZJQXFOVEt5QnVC?=
 =?utf-8?B?cWUxZlVkNnY5Z2dGaEp0VFZ4UEQrUGY3bmM0YlhaQitXVlh5YTdpdGxYLzhF?=
 =?utf-8?B?MjlwTHZ6Mmo5cEZLQjU5NG01cWZJODI0MUhvS2dQbXV6MHoxUEpQREhTdkU1?=
 =?utf-8?B?Yzh6c3NLZDF1TEprL0g0cGgvUzNleXgzU0pYenRlYXQ3VlMwcWhSdG5CMVRv?=
 =?utf-8?B?UVE3WGNkcVUwaXlxc3lLNG5oMm1remRyVVYvODVxaDN4S1N1R0hUeWplNm5K?=
 =?utf-8?B?UlMxUDhXMGMyQWZYMko4bERyTzZnTmEwclFZUWZTVVlPekZTQVJQaitxMlow?=
 =?utf-8?B?N2RoWlhDbDBHQ3M1ZFFCbjY4QkpESVBjbHhYTmJZT3lKS05lRVpUYU1meHNJ?=
 =?utf-8?B?TCtmSkFPRjlVcVVEaXpuT3dnOVNTUnJoV0NubjJIdjI0ZGNqSWdqSU0xRUFY?=
 =?utf-8?B?QTZyWWtKUDlnM3A0UE82OHhFNVhhQWwrWnZZTjRsZGkxOWM5dVlzZy9aWUhp?=
 =?utf-8?B?Tk1ESDNtMm9ZMEZjSE1VeXhlbVliOXJRQ2wvSDhrb1d3OEZjd2FDeWV6eW5Q?=
 =?utf-8?B?Y3dTc0s1ZnpsNDdyeEJDdGxLekNrSWJKeGhsRXlEeUVZOUFTd01FZlhWVW9t?=
 =?utf-8?B?VVZGeDYySUpmTDVHUTN1TTlNQVpxbTNWRlRsRXBBd3pudVhnOXl5aXN0akFS?=
 =?utf-8?B?SXBLdWJ1ZFB6YmtoT3dXVGJQc1lKTXM2VEZ3cWk4RVdBcVBsSEhWZFBzR1Rv?=
 =?utf-8?B?OGZsKzhteFluNzZpRmdMUmhuMlZ6NXNyeXFXY2pWZGFHM2YrWEh2M1RrQjQz?=
 =?utf-8?B?QSswUzlGQTk1Wjcway81V3g2MkZUV2dXNjdIaUVJU3Irejh4Y0RNcXpUV1lr?=
 =?utf-8?B?b2NjVmttUlRybEpnc0lNZVBZTy9INkw0Ujdtc2tUYWlrY3N0U3BlTk5IUE12?=
 =?utf-8?B?bS8yYUNxZTEyNU10cHJFRVVIYzI1RE9mK01pSGlHT2tSUnRuQkkyNHg4aE41?=
 =?utf-8?B?K2pFL2ZGQnVLeFI1ekN4bUxDTHJaRTJIRWhVbXl0aHRPNVVvSjFhRlJGc3Vz?=
 =?utf-8?Q?4+yI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(4053099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 20:57:50.3826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93111ca-a595-4338-fabe-08de369c72fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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

--------------B96JNbdjZNh7e0nsvFd1g7bs
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 12/8/25 12:11 PM, Mikhail Gavrilov wrote:
> On Mon, Dec 8, 2025 at 9:42 PM Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com> wrote:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi Mikhail,
>>
>> Turns out we had a followup fix for this issue: "drm/amd/display: Improve HDMI info retrieval". Do you have this in your tree?
> 
> Hi Aurabindo,
> 
> No, I do not have this commit in my tree. I am currently testing on
> the mainline Linux repository (Torvalds' tree), and it seems this fix
> hasn't landed there yet.
> 
> I just updated to the latest master (commit c2f2b01b74be) and searched
> for it, but found nothing:
> mikhail@primary-ws ~/p/g/linux (master)> git remote -v
> origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fetch)
> origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (push)
> 
> mikhail@primary-ws ~/p/g/linux (master)> git log --all --grep="Improve
> HDMI info retrieval" -i --oneline
> mikhail@primary-ws ~/p/g/linux (master)>
> 
> Could you please point me to the tree/branch where this fix is
> located, or send it as a patch? I would be happy to apply it and test
> if it resolves the regression.
>

It is available on amd-staging-drm-next. I'm also attaching here. Let me 
know if this helps.
--------------B96JNbdjZNh7e0nsvFd1g7bs
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-drm-amd-display-Improve-HDMI-info-retrieval.patch"
Content-Disposition: attachment;
	filename="0001-drm-amd-display-Improve-HDMI-info-retrieval.patch"
Content-Transfer-Encoding: base64

RnJvbSA5Yjk5MTE1YzI3NDM4MjU4NWU3NzYwMzlkZGRhYjFhYTljZjEzYWU2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBJdmFuIExpcHNraSA8aXZhbi5saXBza2lAYW1kLmNv
bT4KRGF0ZTogRnJpLCA3IE5vdiAyMDI1IDE2OjUwOjM3IC0wNTAwClN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZC9kaXNwbGF5OiBJbXByb3ZlIEhETUkgaW5mbyByZXRyaWV2YWwKCltXSFkg
JiBIT1ddCk1ha2UgYSBkZWRpY2F0ZWQgZnVuY3Rpb24gdG8gcmVhZCBIRE1JLXJlbGF0ZWQg
bW9uaXRvciBpbmZvLCBpbmNsdWRpbmcKbW9uaXRvcidzIFNDREMgc3VwcG9ydC4KClN1Z2dl
c3RlZC1ieTogRmFuZ3poaSBadW8gPGplcnJ5Lnp1b0BhbWQuY29tPgpSZXZpZXdlZC1ieTog
SmVycnkgWnVvIDxqZXJyeS56dW9AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogSXZhbiBMaXBz
a2kgPGl2YW4ubGlwc2tpQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggSHVuZyA8YWxl
eC5odW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uaCAgICAgICAgIHwgMyArKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYyB8IDggKysrKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oCmluZGV4IGVmOTdjZWRl
OTkyNi4uYmQwNDAzMDA1ZjM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmgKQEAgLTEwNjMsNiArMTA2Myw5IEBAIGlu
dCBhbWRncHVfZG1fdXBkYXRlX3BsYW5lX2NvbG9yX21nbXQoc3RydWN0IGRtX2NydGNfc3Rh
dGUgKmNydGMsCiB2b2lkIGFtZGdwdV9kbV91cGRhdGVfY29ubmVjdG9yX2FmdGVyX2RldGVj
dCgKIAkJc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IpOwogCit2b2lk
IHBvcHVsYXRlX2hkbWlfaW5mb19mcm9tX2Nvbm5lY3RvcihzdHJ1Y3QgZHJtX2hkbWlfaW5m
byAqaW5mbywKKwkJCQkgICAgICBzdHJ1Y3QgZGNfZWRpZF9jYXBzICplZGlkX2NhcHMpOwor
CiBleHRlcm4gY29uc3Qgc3RydWN0IGRybV9lbmNvZGVyX2hlbHBlcl9mdW5jcyBhbWRncHVf
ZG1fZW5jb2Rlcl9oZWxwZXJfZnVuY3M7CiAKIGludCBhbWRncHVfZG1fcHJvY2Vzc19kbXVi
X2F1eF90cmFuc2Zlcl9zeW5jKHN0cnVjdCBkY19jb250ZXh0ICpjdHgsIHVuc2lnbmVkIGlu
dCBsaW5rX2luZGV4LApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCmluZGV4IGFjOThjNzQ2YzNk
ZS4uZTVlOTkzZDNlZjc0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCkBAIC0xMzksNiAr
MTM5LDkgQEAgZW51bSBkY19lZGlkX3N0YXR1cyBkbV9oZWxwZXJzX3BhcnNlX2VkaWRfY2Fw
cygKIAogCWVkaWRfY2Fwcy0+ZWRpZF9oZG1pID0gY29ubmVjdG9yLT5kaXNwbGF5X2luZm8u
aXNfaGRtaTsKIAorCWlmIChlZGlkX2NhcHMtPmVkaWRfaGRtaSkKKwkJcG9wdWxhdGVfaGRt
aV9pbmZvX2Zyb21fY29ubmVjdG9yKCZjb25uZWN0b3ItPmRpc3BsYXlfaW5mby5oZG1pLCBl
ZGlkX2NhcHMpOworCiAJYXBwbHlfZWRpZF9xdWlya3MoZGV2LCBlZGlkX2J1ZiwgZWRpZF9j
YXBzKTsKIAogCXNhZF9jb3VudCA9IGRybV9lZGlkX3RvX3NhZCgoc3RydWN0IGVkaWQgKikg
ZWRpZC0+cmF3X2VkaWQsICZzYWRzKTsKQEAgLTk5MCw2ICs5OTMsMTEgQEAgZG1faGVscGVy
c19yZWFkX2FjcGlfZWRpZChzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5lY3Rv
cikKIAlyZXR1cm4gZHJtX2VkaWRfcmVhZF9jdXN0b20oY29ubmVjdG9yLCBkbV9oZWxwZXJz
X3Byb2JlX2FjcGlfZWRpZCwgY29ubmVjdG9yKTsKIH0KIAordm9pZCBwb3B1bGF0ZV9oZG1p
X2luZm9fZnJvbV9jb25uZWN0b3Ioc3RydWN0IGRybV9oZG1pX2luZm8gKmhkbWksIHN0cnVj
dCBkY19lZGlkX2NhcHMgKmVkaWRfY2FwcykKK3sKKwllZGlkX2NhcHMtPnNjZGNfcHJlc2Vu
dCA9IGhkbWktPnNjZGMuc3VwcG9ydGVkOworfQorCiBlbnVtIGRjX2VkaWRfc3RhdHVzIGRt
X2hlbHBlcnNfcmVhZF9sb2NhbF9lZGlkKAogCQlzdHJ1Y3QgZGNfY29udGV4dCAqY3R4LAog
CQlzdHJ1Y3QgZGNfbGluayAqbGluaywKLS0gCjIuNTIuMAoK

--------------B96JNbdjZNh7e0nsvFd1g7bs--
