Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C79BCA0ECB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 02:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ED510E268;
	Tue, 12 Sep 2023 02:52:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DFA10E268
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 02:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1SR3PIpTIJFAyv9vjCeEFZLiGkdp0T5fc90+toiTHJCkg8MBQvhFf+6AEAPi1fLzL7Vm89TkNDYrPT42Ix8xb1ofJ4AD/kO2ZgTIingfyhLrh9UjD2HymsImRsiTGsx0KrkF4fFUgLGTqVYoMtiEgozlGRO4l3nmrr3PVqEm6ioefXcjX5UVpZlj1M4DwiLuFRDMvkDPYae3KXCx8wyy/nDBO4pLul9WnqAvGgy+/4HYs8HkjIT0kQfxjESy85rFmp8mE/RkAwApipAzyNTt9/rnns1pwUzGoC1YVBUgHDidYgJlct9kq+MnVrk6M5OrQHxWs0XTEKUSbQ+gRRsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEsuKHPNA4ubqO+VSd3SnOiopVNzETaConuWpqGFbYU=;
 b=lL0ddMbCg/+puTaYGGD+LAtakeYHAY9dXvDWO0t4foHB6VBaT2Z/n30vSnaTzgK+nVQ0CA8MAn5i/QXrQZTYfCdcXsy97H1paB5yvSx3O4VRgZZB7X8MlKiHpuJU82kLeg4+tCSOejj9muWoifLNbnLLlmJ8c+0ah8PlQUiv73Ml/qKQps3LTMrimS2647SdQylPeU/h8n9XwRZNKrFHpkD4XXeSVmiGPbmELUBQl90YcBpyyBteGcqRpgwKVLPD+yQSvfx2cf8AAY7egBkhIAtdfEPBbJFNYHYab1Nndojol+y2J2nvd6XjGIs6apN2YYdbT3IXqfwfsmpJTVnzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEsuKHPNA4ubqO+VSd3SnOiopVNzETaConuWpqGFbYU=;
 b=Vc1kvikEdGaSeWRpJxUPck/nL/qdiSm4jkteRB1rxKni3CAu7/XkgAEojOK6JJSwGZ933QB4aHA+QW7K9yGnGn0p7N6ZrSp1eK3YvdYVUnACJftjSz5ahYwxA6Tof8OLalF3/zMUJ6tiQ6tuUB6QtRxcoQev1+kr5mzfv0T8vE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 02:52:49 +0000
Received: from CH3PR12MB8902.namprd12.prod.outlook.com
 ([fe80::8a1d:7018:5100:e7d0]) by CH3PR12MB8902.namprd12.prod.outlook.com
 ([fe80::8a1d:7018:5100:e7d0%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 02:52:49 +0000
Date: Tue, 12 Sep 2023 10:52:37 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Message-ID: <ZP/SdUd9am/f2WJw@lang-desktop>
References: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To CH3PR12MB8902.namprd12.prod.outlook.com
 (2603:10b6:610:17d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8902:EE_|BN9PR12MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: c5713fc3-ce2e-4db7-67d7-08dbb33b598a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+FVfR4Ceacx1yvVFbT+x6R7VWbGAZCGRJFpF6UgHAHTyrC2xg2+BwGxdE8gsT33iQzbmEzbCOx8CZsQEjZB43ociUWVW5LR3x/sDdHlHZW+RC8eFQurbAnyj5HRdcjGem1edYUvyenMR9eUpVP7vJ+hcr9JJiq1n8up9iYWTIJgJzGZzM/1iM7DVqJKKH0yqyUEezAA2bH5ETeUI+za8HDXGo3W25+DUWeNAJGdh7TQpQq5O8OT0Whc3rZ+tu/MLEnuM++CPriOn/gX0d+9ZyStjhiELcwNlY0NzClwi27pM3TZEdjIFA7LK9Ofp0+pN0ApzVGOBOrT5LGo8xKarCHrs8f2CL444BH5zsOV6I/S2+xRNdy8hMUcEqco0wgTJXfcSDMjgtTlwoFUaWQmiP+b7LBs9HFYjpJOPOXx33OWQdFWqy/f9b2aeg8Bd/e/e/9txHaErIQGrlT7OLeQAbgvPNgLdSeBL8/XXIOPybMp/BP+rDwHEvE+J21ckpOvi4InpTPvVCTp2j8fhP8k6vv2RsxL3bbeusF+Jc/5rdAMwBp5hAiwVzOOJF9J5p1G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(136003)(39860400002)(366004)(396003)(346002)(376002)(1800799009)(186009)(451199024)(6666004)(6512007)(9686003)(6486002)(6506007)(478600001)(26005)(83380400001)(2906002)(41300700001)(66556008)(316002)(6636002)(66946007)(66476007)(5660300002)(4326008)(33716001)(6862004)(8676002)(8936002)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kOwhfehmPZS1lsR/wUPwK1GNyQVYWK8THEG0tSukYOGrRAHcvzydTAwHPkhJ?=
 =?us-ascii?Q?Hjxjp/bc0fwQ6GIUXxRjN2mPrUuvCkznXNApcKrXG4oozdhzJSdPpU7e0csd?=
 =?us-ascii?Q?O/2BjCBzbe3xSdilU04SQBRCx9DvyIZD7IG/+GmoEL7ZdaPOO6U7vqyD1c2Y?=
 =?us-ascii?Q?SdLJpBPkyRXitlNjroRDlQ7SNFNNIl8vmiOBtaEGIRUnI9YVEm16yVYL7HjE?=
 =?us-ascii?Q?qvP8TId9p58NxlR5sge+Oc7PDwmElfwxizT+lhshj/B7iVz2ZmzaxkcY66D/?=
 =?us-ascii?Q?2jmeSnNC70cQ+EPwq18V+Jzv3aOxgvhgPDnUmKweeMEUmU4QXF9RvN/im1gW?=
 =?us-ascii?Q?JMzcghDfa/qXSwp6u2YPWs+QGUz4v7nyaHvv8XMUirTQB5B5CB98/a4ljoh9?=
 =?us-ascii?Q?0Fueq8ds1l7/vliz6IA2NbbcqUmo70/i1xFvFmFZgq86hj7QpsDcBr4IzKPo?=
 =?us-ascii?Q?mKG7XjvrvQpVdQktuxcrbUiUi/JET6C+mK8MT0gj6Ixe5RJAA9eWr6ijRmGJ?=
 =?us-ascii?Q?whRIgrQx8oKmf+27h+GOfz17pW+oEWjrW0D4rfxM50Ugry4m4vq9zFtb+M0U?=
 =?us-ascii?Q?Xh+oB1z6DHLmjFKGfJ2I45EpXHzOEgdyHYbQ8Xw8oFX0HkZ14i1tDM8GUP1F?=
 =?us-ascii?Q?u9iZjSLPOaXMzBFUhDZZvBMyyMfEr+2tBDG/eXfNKh2iC+DLvIbKeZnaNUKm?=
 =?us-ascii?Q?Hcr/XmUafDCFekADp2yYLEkGfm+TrNskfip74CxLlL+avHRyWA+czIPBGLLA?=
 =?us-ascii?Q?CPl3uw2rn1XpMlSeEuF/tPDsoqKYeNa1dWwNjHNw4xUyGPuqLl4QsHKwIZYB?=
 =?us-ascii?Q?pTJnEBJr0JEJSTeFTn9/baTK2zEB/o9Um4RGxPPrDcghihnFB40+GSQ5Zadr?=
 =?us-ascii?Q?dNAzg3TZHoa03COS4OHgD47HvrKGkWM5zhCQqEiMrlSVoQbtvRDvleaamAJw?=
 =?us-ascii?Q?HIvnz6jSA+gu4duSwKABRlIjOyBOvns7tdwPuyQ8Qj9gGtT/w0q2mxUpR/Ev?=
 =?us-ascii?Q?wt15H0hxE3HNZcMpxTXws3BEJl/fK0HEIf0svE5AF9pds18ldG04SbW9dvKN?=
 =?us-ascii?Q?RqKmKjKosxO9Z2AN+JPGixgQRBM0bCP4lj17gI0XwdgHD++WefesDLU9CMwU?=
 =?us-ascii?Q?EIIIjNcM6jbP+z60fIV1tEn5M8rI8um9pgTnjEwGjQttGKjZ981wfRj/Nce/?=
 =?us-ascii?Q?xQtw/6cB+A9De2k/r7pcAK1sy4k+QTv9iKngoJp2hT7RvIjxeEeml2CPnHDy?=
 =?us-ascii?Q?j12aEhW3sxEn7Q57JkTbIalleHNGvwEZnXglMLrsSqLi2lPvJ+dqeLlnqelY?=
 =?us-ascii?Q?3SvIazs22trlA72KBprYb348YTLHP07zDvWo/c2RCKq/331fQ1z8bwtbmtH+?=
 =?us-ascii?Q?M0FymjxiTmQjiRmo+vFeejl23z0Ll7cv0t0KtnLE2zJxDih1/kNiMON1Yd6K?=
 =?us-ascii?Q?TdnsVZjIrOjF7IHZ6+9GQpov1rX8Mr1MRyS4MOWCpkTD0EZM1MYiqG2ikZiL?=
 =?us-ascii?Q?9F8rN7KqhIhCAa1SYxCT1SlTExaPJc5ZvuFmR1DJuWOaKSuvyaySrveYInjS?=
 =?us-ascii?Q?C8SEEXfKiEa6Xm/NW8OtbG3jKq+cgBJM3fi/wDUE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5713fc3-ce2e-4db7-67d7-08dbb33b598a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 02:52:49.1350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MoSDHf8FSAtbE+aBwoJK+aUZwhJy8f+ES6PoV52VVKmwmPkkcxGrMWrI9P2r9VpiiOHBfvA38hgoHh4TVt+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/11/ , Harish Kasiviswanathan wrote:
> Heavy-weight TLB flush is required after unmap on all GPUs for
> correctness and security.
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b315311dfe2a..b9950074aee0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>  
>  static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>  {
> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
> -	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
>  	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
>  	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>  }

1, If TLB_FLUSH_HEAVYWEIGHT is required after unmap on all GPUs
as described in commmit message, why we have this whitelist
instead of a blacklist?

2, kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is also called
in svm_range_unmap_from_gpus(). Why not add this whitelist there?

Regards,
Lang

> -- 
> 2.34.1
> 
