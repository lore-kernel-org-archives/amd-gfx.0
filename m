Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F7AC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 17:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275F02053B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2JXwHiSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275F02053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC91882B5;
	Mon,  6 Jul 2020 17:45:44 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4AC882B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 17:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxwjVfYgzBe7pKvHnlGyc7KE7GCxe2bkGStrwnrpm7b4AUNgOZZh4UslbObuq3newWQWYirfM2u4zgr9KhSUM5vRUfwGQ56z/Z8uwchdEe4jQwTPbX/HeB5KsJ8piCqzcl8iCxD0wZk0RqlI3Byfv+2si0d/CfOIsDQfPIGTaI7BeEyMERu8HF1UH/prDm/3iSvfiB7+/lIuZz9eBdTSwJ5UlE7apCvMTgM9ul6i/yEzenEKatYhlWKQYyQjMHxgJhmW0bnMQfq/zCdxAczfe8qIwhZBmAQBdYOirf6VWtZynaWU0svJDFoHe4/isrSwFPCpCKZr21NBN88vI4punw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evty4pzdTCHuECtkhRTxXP96WZV7MWwDyIkDDLLtAVM=;
 b=cheq2PIwGAUJHRQmxPqOQvBwbnFtIineI9KzQNIfiTR8tGAtRh8gf0z+3jWJfXipZALZXdT6EE5uSEg+1uokwydllUIuwK7NXCM3oekpvFVhrknc2NvXAr9soPr9nL45wl45NkbTTcGTAUtBaBrbkLYtn6iwrn1o+GF+u8a4550PsnWd4GfEw3OYoKhstgiMlxWv//pVdBE2yNK97KDUvc+DbKCLrtXI1b1ufEu8tOV/r99+6ngirwD+xu6w1oG1WLETwwovqHPEUw8tiAJMNr13fgqky6cirBitZ2NidR8RhLutML4cdNCf/3W6vICoNGQuFQjcpfino627fJeh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evty4pzdTCHuECtkhRTxXP96WZV7MWwDyIkDDLLtAVM=;
 b=2JXwHiSbTIaAjVVl4ZRQyvOJvo10sU9gNVWSod2dJx+W/IX5HcO6n9p+XgDuODeY+vWgTadMbrbTEHY6YjPQAoAlMxB0vsMlxwazw45oK1s7JivmznY+26NSReD9PV0cPMBTjIK5CxQ6jJnx1ZnkzuPBFoQqBCD5CEi+5Tq1Lo0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Mon, 6 Jul
 2020 17:45:37 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::180c:9e60:d3cd:e89d]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::180c:9e60:d3cd:e89d%3]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 17:45:37 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: sparse: fix incorrect type in assignment
To: amd-gfx@lists.freedesktop.org, amber.lin@amd.com
References: <20200626233951.11724-1-Felix.Kuehling@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <39c3aad4-3676-1ade-e56c-db9cf8573e94@amd.com>
Date: Mon, 6 Jul 2020 13:45:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200626233951.11724-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::46) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.53.25) by
 YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend
 Transport; Mon, 6 Jul 2020 17:45:36 +0000
X-Originating-IP: [142.117.53.25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7d32277-5d21-4653-c2ba-08d821d46429
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2365F908438F75BAF85BF93F92690@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtCHJwPHiVDvZYkNzcOqV+Tk5r282R7QA4UNgcuvfkubfp2PKTinpY6MbF5P1n+Es7AZwzJ/D76IxFU6RDFUr2+sBgvoHTmdjzBusoZ9eignsSBB4YxJhFMsgKJwzG2ot+w7Whh/TtF5y/AN1O0Qir9je+3Ytw4EFNyYcs2vsl+B25irNi6hh3msdEZaGFu5ZZ/tzlfauWIz2ATZu7upGFa7T3XlIyo6eZ9nXxNnkVSTeot+ttdgEGwkVSlSxUd9O17Dq4eZiX83mN5QmEn/XAaLdIhRWu4rvY9GOdAtxQnNMmr9gVGKYEKhLChJmO5LyroLm7TZTHKEooJYBCjB17uNEKMggkDdPvBsbZ0VobGS/JznC3u8HV6wIu1mOk+D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(8936002)(83380400001)(26005)(2616005)(44832011)(498600001)(36756003)(8676002)(6636002)(2906002)(6486002)(66556008)(31696002)(31686004)(186003)(16526019)(52116002)(66476007)(16576012)(5660300002)(66946007)(956004)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /NF/IRPBwmgTwWePFCIy3rqVqOUp4hAE3kNQU2q+N4oH53bICOP1wmzLMooQAwfpMM6lR3dHRFgrEd4CHqfTVzee6DBgJsLTg2wjDK9+DV13tXlE3D4dylx+wfd8g+br407WOFLFPiA4kHz79Bg7t922iHx1AIsY2sqQ6QWFilf364IXOqZrNctiOCm6FX+vzosoDchbg2FXDYZ8swzkguFA3hZDi/V9i8X27cgBOqR4OJUSwj9q5Qzx1T1hPQXLRkQ6SmCBrT2tvM8mQ+duSlW/uh8OCf4L2yn+m6+9tnrYHqCHyLbF9LgMJyI5XiFdyaHxlA34FMzAm/OWwLp/lHy9qU+/eGE6hSfzLHsH5R7iSqEGJsHqKysF8h3LH1sU4SAeJidYQvTZNWkO5w/L7APXXB7zu5cHmjZGNiWGHKA7PZq3v2bfYxdOfXiwynhKGEoggVOlhVyK8TNO9B0xJZyYTJktrxuaN5ngNqYrh44=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d32277-5d21-4653-c2ba-08d821d46429
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 17:45:37.2275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS6FbY9+aX7+i6JN7u8yroyylGQuhYRwe8b0MibGIzWAp6ZCSYn7plXHSmxg2RsH8/OfDHg5uRkikyDS1ZkP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping.

Am 2020-06-26 um 7:39 p.m. schrieb Felix Kuehling:
> The correct way to implement the fops->poll callback uses EPOLL* macros.
>
> For reference see also:
> commit a9a08845e9ac ("vfs: do bulk POLL* -> EPOLL* replacement")
> commit 7a163b2195cd ("unify {de,}mangle_poll(), get rid of kernel-side POLL...")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 73b753a11ae9 ("drm/amdkfd: Provide SMI events watch")
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index f3782627407f..7b348bf9df21 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -59,13 +59,14 @@ static const struct file_operations kfd_smi_ev_fops = {
>  static __poll_t kfd_smi_ev_poll(struct file *filep,
>  				struct poll_table_struct *wait)
>  {
> -	__poll_t mask;
>  	struct kfd_smi_client *client = filep->private_data;
> +	__poll_t mask = 0;
>  
>  	poll_wait(filep, &client->wait_queue, wait);
>  
>  	spin_lock(&client->lock);
> -	mask = kfifo_is_empty(&client->fifo) ? 0 : POLLIN | POLLRDNORM;
> +	if (!kfifo_is_empty(&client->fifo))
> +		mask = EPOLLIN | EPOLLRDNORM;
>  	spin_unlock(&client->lock);
>  
>  	return mask;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
