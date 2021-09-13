Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2732C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02C460F12
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A02C460F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBD76E156;
	Mon, 13 Sep 2021 08:31:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1C06E153
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 08:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeQmL6bWmLo9Y+hJ4QKlRKHAMZhzCxrCnADYmrr6CikF7txBf78jaM2tXM2OYBvF7cCGiZ2diibns/mzQdXgsO+aio9QMv9OsnS2iLGWsc3l0Tmn1EsxkPjfQJrjomlUUkjZiB/j9PxKdILrEJq+x/+LFgGD6NvNcOKNpdSY/wNMHuHHpgIbIAiMdXjNpQ2YpyFAK13GHiah4gFhIRbWe5SxcYHbUOEkb5puNvZLwowkAi+Qvhvo0G8LB3MRhPE6Hmacbur1m8VhtLBQqO6+detpt1G/kavPn5IkJcRizHkr+92SFQNeVi9AHwTrYFJMWrzzBgmeWfFIR/BdOUZ6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=BvdtvkFKjv63rKCcOSfjkiYT5yyfxrruxpLRSUHPahE=;
 b=d3rljd40PugJQoI4AfHKVT4eQGuejKSVcnrogqtDQE/Lz3//4L0A71yJCwr1qc11yxsJ0QMJZWpVwFxLmW9/0n0zr2Scr1ROlJfjyhQphTb0q/E4+Vj4kQi7oJX9V3PvrdCfQS89r2hgvhFWfUAnelyMn4Rsc2anabiToWRbzALoArwGHIM89ZTFEuNWVJL0BqhoglvVLjiOadrp/u7v848OKyWj6nSGQyLXPZ/VQQByctUJw5TR9CfBkeGCgSaeCfHg7G4QG3nu/XY7EwNrrhDpLUnFDsb5Fosv7XlGpw2PXh0ZH6aBiWv4jWA84vUfGxeDVHk4moGIIW9fKEhe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvdtvkFKjv63rKCcOSfjkiYT5yyfxrruxpLRSUHPahE=;
 b=18BdVpKniRh22s9I07SEQga8WnBgWXregnT4MRz/FEdXx46PKO3wXHHyOZ7vQxI2aMpa256IY46L7Ri/WEZ1hxCzELSETKaexKIAVdx0APLQkr1oGkP59S3QSv0khJjoqwaYQ6AApgRS6FpBDi0/QMpA/+WwuiSxOayeC+HMIKE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 08:30:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 08:30:55 +0000
Subject: Re: [PATCH 1/1] drm/radeon: pass drm dev radeon_agp_head_init directly
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210913082742.20002-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <426ef783-b140-2658-ad1f-b083b16f976b@amd.com>
Date: Mon, 13 Sep 2021 10:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913082742.20002-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR06CA0115.eurprd06.prod.outlook.com (2603:10a6:208:ab::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415a5752-338f-43aa-aa22-08d97690cdd9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39505C4640DE25C4491B9EA583D99@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mX8sKIyc81ls6UmpsG/8vgeU0JA4Zhwl1Jm2SxUruPyM8+MfCvr14IW01u0Y3GyfqgwSjzlQuRiQOxv0SX7lCrty23ZhQtsRadNF59R7L2bQ8++efNGekYq7ft3+J67i2XmdLJD46U2m0xuDRtE+UEoWpH7uPJSbXMo+/9Mz0ocTbhTPDW35w+t/UjQCtIRscXPFWKEbGvmcXdKaLtovzkYZvBmH5Vzmyg8at4iv2S0jSf15cgRYh892tL0Ld/DDo+GErulj47O9vqRvomrBUj/rn+N553B3F5eGnetQ/k2L0AXe6lEH9JmuL5/+/4mJ87IJBbJ4ZKazMYverU7OPRgF2tnP6qHzEqC2Qr/pyMlIroiQTwQwlk24cBnEOXXZsA+//lc9wUOzF6pyQEHVH4Pep6l5OWpbzZbP9tXhtvUzhJ5unaKX20lTeLhqo3ia9TJgzVjKg6KOgNaBL49V1vVxy4peCqpI6ot9KN7USZ2mQljnZJPBKp20On91GI46nq4KxvW0phAgTqatOj2gWbXfmwFV3V4MdpShRFKJ0rknNLAvxwj2fSo8TYwX9Zelw6be10785FjCphzLbKaADll1UB4Tu9scFqZ0f9KnX4GX2o8tx1kaUBxHOFD/f1fRMxWFE7PURlaTMtOhHZ267h9VvD6x4EjANRHc7f7vyE45I7y3GZByCMk4DOhF6isQcLsskY0nZEyt4xEglmgk3tMk0GClenjNXqyxd86K/A/39gBY2vdiEgHYurYYnmA6aTxiTuv0qInbTI2i1UVpJaNoosXgiW4wPUe4tcjRezlawdmZyw0W1Q9sBf56PRYY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(66574015)(83380400001)(38100700002)(16576012)(66556008)(6666004)(31696002)(478600001)(26005)(4744005)(66476007)(8676002)(956004)(316002)(2906002)(186003)(86362001)(6486002)(8936002)(31686004)(66946007)(5660300002)(2616005)(966005)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lHNkhsaURkaHRTZW4zNFl1RE5YTkVpNTBaK3ZhTXM2QUZySjhadElxZXVs?=
 =?utf-8?B?SDI0OTByVWk2Zjk4QnN3SnpDTEhzclhVV3F1T0loVlk2Y01QdVYvcE9Ed0d0?=
 =?utf-8?B?UFRVZWp5QmFhS3FsUzlBWEYvUXZLQnJZK2JSOVF5Qi9WSGU4UlM4OC9qK3JQ?=
 =?utf-8?B?TWVJMmlsamJNK3d4bklNYXhqYUZaNE1Qb3dSK2sxaVdBdmhzbERSWm9WRU1Y?=
 =?utf-8?B?ZmFJS1NQOEFlTi9hYmRHZXQwU1c3YlA4U1d3azA5WkZtZUtndnVaQ3JzQVcv?=
 =?utf-8?B?Vi90Q04zNEtVeE0wZGxMK1FJR3VvVGFldTdzUTJqSDNDVHUxSjFxcEFSMHpw?=
 =?utf-8?B?dFp4Q3FwbC9wVXNndmlqRlljMTdRc09DTGtiRjNKajRhWm5Id3BSZ3ltclo4?=
 =?utf-8?B?WU41Rk1mU2VOeDNETTJ5UHhUblg0bjNMTUNxVmExOFd6UWtBM0tvMm1RQ1kw?=
 =?utf-8?B?S2htWmVYWTdmZmtMUlQ2SEZsbG5vRyt5Q2x4TTJyOGl2YTQybGE1dzNLNjh3?=
 =?utf-8?B?Umh3WkhMeWwxLzdkT3pEbEdYRytzekVwV1R3US9lUmptNytGbG92TVl3dlJp?=
 =?utf-8?B?RlFOQkNCSFJQYktpcUMxWG8wSU1hOWtNdnk5bURrMktOMEU5Um1Lb3VWRUwz?=
 =?utf-8?B?cWRYaS8rYU1HeUtOUjFvcit3cDk4R29YSXlFZE0yRng0bEpKbUVvZTRkRW9B?=
 =?utf-8?B?ZTlFZjVjZjlaODRVaEZaNWNvR2d6czc0aGpkRitxZXdMNkVQZXEvU2NVL3J1?=
 =?utf-8?B?MkpyZlFIazY1b1k0Qy9Rb0kxTUtZMjJPUG52Ujc4VnNWMkNpM05qdkkyaDl1?=
 =?utf-8?B?dFdUaVNBM2xpZXpRZ0FzOFRvbEJoUUl0a3gvd0MwVnNaWGpXNDZVMXJTS2RH?=
 =?utf-8?B?ZDJJWU9tMnFIbWxHVVJPUGk3b1ptc0x0b1dkZUNhSldMVXZOMnBOQXlzU051?=
 =?utf-8?B?M2VmLzk2T1NUb1VMM0JyS05TWXZiaTBQK0VGa2NzNHFJMVJtNXkza2dqOU5K?=
 =?utf-8?B?anlXQmYyclJhc2x3UW11Y0RpaEMzVTgzUzNudjNlU1JQTlI1cWJuOEpjSlM5?=
 =?utf-8?B?VDZpdkVoODZobkVKRGNRWDV2Z01JaGovUVFLWlVtbFdWRnZmK2k1QkRNWmFx?=
 =?utf-8?B?OHlrNW1qc1Q3VU5uTUp6N0FQU0VVVE5BUHp3LzZYNUo4TXlTWW5zS01UVmtt?=
 =?utf-8?B?eVJKYU9lcFQ2ZGQ3TVhPNk5USUNHaFprYVl4NXQwUWZtOW1aTWE2NTVQMHFm?=
 =?utf-8?B?WG5xelNjcWUvK1RaV254YU4vamR1TXlENlp5TVFuSFBQNDZ5UDJpeForelRk?=
 =?utf-8?B?dUE4cHlqNDBZbTl0N3JhMlZPNkZBR2NqZDR1OHN0VUk2bk9pMDh2WjBOSk9a?=
 =?utf-8?B?NGxjcUowVDJLekl0RGd3RU9EOTJPTHJNak1ndHVxc2lEMjlmZlFRam01M055?=
 =?utf-8?B?VkhYekpUL0NabGJET1VIanF5YVJ4aFNYL2lXTVdxc0o5Z2kxbDd2Skwrc2Rs?=
 =?utf-8?B?SnUyOTlDWDVXZmNuSU1ybTlZS1ZQalg0cVNiaWhOWU4vai9ZTEtkU2ZHTmx6?=
 =?utf-8?B?b2Ryd0xBUjR3TmlxL29ZdDlEWmF0MEo4dVVQeExEbGpzOGljU2NJRGFFclRO?=
 =?utf-8?B?bXpNRHRiNW1TTlpQVnp0UmFHSlBBbjA1TmlUdWxGQkpNdFRVVWRrSVgvQU1G?=
 =?utf-8?B?czJmZUtBSGFJU3FZV1hBeFhIdFg5Tk10d3JwQld5L3pmdDVkQVMwQ0M5Qm5X?=
 =?utf-8?Q?3cGvqRI1Zrsj8Mt0zHIxA7plaR9vNMwS9o8bl/+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415a5752-338f-43aa-aa22-08d97690cdd9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:30:55.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm4Wpi8Z57XNzFaNA/1O7QPBDPguWYl26tF9BrEQbnJJusC6W6cGXK9dSL9ksnD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
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

Am 13.09.21 um 10:27 schrieb Nirmoy Das:
> Pass drm dev directly as rdev->ddev gets initialized later on
> at radeon_device_init().
>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=214375
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> index 0473583dcdac..482fb0ae6cb5 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -119,7 +119,7 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
>   #endif
>   
>   	if (pci_find_capability(pdev, PCI_CAP_ID_AGP))
> -		rdev->agp = radeon_agp_head_init(rdev->ddev);
> +		rdev->agp = radeon_agp_head_init(dev);
>   	if (rdev->agp) {
>   		rdev->agp->agp_mtrr = arch_phys_wc_add(
>   			rdev->agp->agp_info.aper_base,

