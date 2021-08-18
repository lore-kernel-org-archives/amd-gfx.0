Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0BCC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 13:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCB56108F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 13:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABCB56108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152E66E5A0;
	Wed, 18 Aug 2021 13:18:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DAC6E5A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 13:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/gHZbXrL2yLn3g7jv4+8zP2D6UgvIIlh5MndbVBFdpm3kD+6fw7zsx7OI9nGRHqRvBEqQXJNO6sU/9EtPyzBM/KWSPNoaooxlR3kw0OpKSNcc3o3dWEwjLPDEPzTyFTRZll+jH/P/fT1r4wXqrs/2rc1zQJQQs+t+a17rmg5+nusNqBe7WNOR+U8ladP7zAm8sGJ6HS7lcgkdHa/8evE4qI/cTK9A1JeaHyyuA174ygcRkcWOmgqIVLfWZR81fTmSHn/cmbJ1a5h2BshPLx3r8Ihgc9Y0UZOnJ7UY96vgqgiZVMF9o//9zMKQDAqwpdytAvo0zqBef2b3sqgCsCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcHy0F+H91W+5umJJlx6iZ9G5AIhaW+yYp/6VuGqn3c=;
 b=aCjIjYqBZXfCulx8IRJnsv+nUwfO3TNCgYO87xdWLTxyE7VGaTEF6OgTA6fthDCefizOxu/pqc6pTyqpPcAP/lUcCJ0s2fTiDGR+MXAJODQeRaZp++XUZkWglv/tv69YkarGAI0Knhs7T8CqQfUiCFDc2Lyb38uQsYgG1TTqb3TqA0aLe/jQ3pVGeUs+jN/+lWFs0pEHCv8bIXvqEvqaKYj0uNQakpZyB1l0vZy6Rlylce6Qd567DO9TSeCuOYOOtZ7O5lX/ei1et3ssfFmQCQeozoKLZjnHKaL5IoDA4T8Hh8RanuF+7uUUZl9YmbelEIVoccvxpBptlkbIFsnhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcHy0F+H91W+5umJJlx6iZ9G5AIhaW+yYp/6VuGqn3c=;
 b=Rih48UxGWUgnAkjO3X5Yc9Uj0OJSDbpWUlbukZyOnHggYFRHJ071N1dEHj+LFPX6QdnXw7dHXUxvsuMeLYIo9EkoFkBs1vSJ5NzLWgWgEvt//xeXinhsJLKRSSnv7n2dDqMlHiV5qtMonbu+WmemwnSjFL2I+gVMrZTH9x5X2/8=
Authentication-Results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 18 Aug
 2021 13:18:28 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::1136:aecc:18da:f7cb]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::1136:aecc:18da:f7cb%9]) with mapi id 15.20.4436.019; Wed, 18 Aug 2021
 13:18:28 +0000
Date: Wed, 18 Aug 2021 09:18:24 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
 Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when
 using overlay
Message-ID: <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
X-ClientProxiedBy: BN6PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:404:11::27) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:92a3:22f4:41bc:e46f)
 by BN6PR13CA0065.namprd13.prod.outlook.com (2603:10b6:404:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.5 via Frontend
 Transport; Wed, 18 Aug 2021 13:18:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a10b69-8242-4282-8f8a-08d9624aaa68
X-MS-TrafficTypeDiagnostic: CH0PR12MB5266:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52666162B0A9533727C9715198FF9@CH0PR12MB5266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GRAQt67LRuptvBFoMzp/wnfR5NUO06nVh453btYUfr9La5uLMWSKsgBk7M5eXQomV3lDi3kr5JK1r2HEEYO+SUeklrb7fkg8pz6z3hJyFF6Dxt4bGaFFf2+qhqZ6DHa/oXqkHK0g4K7xKqtJNY2vIMAxwrnYn0k24f5Ud2+eBr45i3tyDdUpGfTIUy1N8WcR7Oc1tV8dKDYa53OPMBHt34EaURfYUk/mizc89x3lp3/5QUoPuFPCaYSMUOsY1RSGRzzv6vBYfWK5L0OUobiEMFmejXDdzEaUoPLdbQTG0MQ0aHhfUz0aON+edLwWinZcyFvdiLEdzrFU+Zszadj30mE3z3iPezEg9v1zl3zaGquNnbaGpASPbe2QmVl1w0uSM/wVBXD3Pu7DX1Db3I5405WEvlg9qdJ4iv7Q5ydXjmQsWk925tQ0JWHIEnolc6X5EZpH0EbUI9GkVOCyt4X3xAsI27ni5yTT7+g0iPhAnpyesbkSW3pKMzzndjLWaM48G7ZAKCJZmnvNFch39rF5p3nh8LilVMWoIB34CTzHdRqj9rG9Lm6tRVW3lLn+j9LhEdsZN54enmkUDNBKvGBqFm078m1U4NVleg/RTRSOCCk+AdpevasphuG5JWmcIaBgLH3+3HwLjyadKRUxIajq8AtlNcbf3J+3Uy5i01q7eMjJHW+NRMh2YN1DtkwNLmD7WrT2L0N7t55Blq+vaZaulDzk7dvv7F5awknTxWAVGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(66946007)(8676002)(478600001)(1076003)(38100700002)(6506007)(86362001)(2906002)(83380400001)(8936002)(186003)(7696005)(55016002)(4326008)(52116002)(54906003)(316002)(66476007)(5660300002)(66556008)(966005)(9686003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5+yYGsOLidIji10xRpMAlOix4cLjKPtp3fwSewlaILX3OkFAjf0LuS/Zhg7?=
 =?us-ascii?Q?88b+g3m0jyB/0xiscukQJ5PI8cWR1uEPg2quGK7ser4gVkHIoDcRuubtNzAp?=
 =?us-ascii?Q?beymnX3p8LTZPoQFYg3a9b82zGRicyiCwIjXdl21jPFtYGGBGlhYK8vGG5LW?=
 =?us-ascii?Q?V+q3GbAMqF/JHWdv6qXIUHH9CwzVxsjrcRdht9y/01kXXyvSYoLeLzIIlFsB?=
 =?us-ascii?Q?V4lJiywMWoTKu9cUoWkHH7zVWjLGm6h3DFk22u1njq4qMqUCj4oPSY5FTSI8?=
 =?us-ascii?Q?4xrhcYv87/lz0poBJMuk+seADvmmu5JvrpUhvwXmC4/Tjr+1snof2CiDeK/M?=
 =?us-ascii?Q?7a6PoVqiIoBqUk2OzudV71ZIVU35lRvK0cmt5uL7yzTlqBWvbyqt/K/8hdtu?=
 =?us-ascii?Q?NltzVKBHT/1h7coEAEdP8FYNNPfDqbtflLKYRApqWZTZyCeQI8idipiUdYTR?=
 =?us-ascii?Q?PtmOmpquVtT+raR3NXVA8bIzZ7d96d2XNypmDgaak0GK68w1dQ6paMbxZvqy?=
 =?us-ascii?Q?GZ4U822zCzO+5dD/0+s7o/yYEGJiJMhT2ofAjb+dPEOKEq33A5mKRD5cIAhc?=
 =?us-ascii?Q?TjdYQEtHXB3KM3o1S54iZePljWeF19Hbb+ADnWdMHIZGhqUv/iWi6zEJRqYZ?=
 =?us-ascii?Q?2yu5Stp5mcJSv3hC0tYwRIP6iswdNq/A6uBjlo8o/wdCYLWEtzjRjMESifMt?=
 =?us-ascii?Q?DGegtKvbXaUlni2Y8yLPKLFbKRqZ9O76jrX+VsyyBBFa0A8ADRzl9KArsvmM?=
 =?us-ascii?Q?VikL6No7D3XIw3IBHhWFI5ozp27KsQLY+MZGolzEcw5SM4mCgt+fflMh4st6?=
 =?us-ascii?Q?JjQTVT8qrWIUUZVgWr1AZ4DoTEL1XWqZlXJduuPER+fQ/JGPzVsK+kagM2AE?=
 =?us-ascii?Q?T+QEZefOA31TToIrQu7TpP5RVcTgY3MTF2rMbtRNmCFIhUgn9qmXuTdgABEn?=
 =?us-ascii?Q?f4vBxobT5DUS3XVRms6j+N9hOHoNocWivrz4PwUUzyduZe0N5xyawbbvF9A5?=
 =?us-ascii?Q?W8C4lSYtbZzR5pFDfzxp+d5ey+gxH9ETVVfY1L+z9DHutXfg6vTVx/kAKoHv?=
 =?us-ascii?Q?B2VmZBFF5Xa7BX9SpGumBPnCoTaQpXmD6UmO0XxE1PgkI/WtBvKr1z9A48z+?=
 =?us-ascii?Q?Or7vFSdB/PraqWJoleKv7rwNDEMRr2kOJLkSrLG36szO9urAIz0GNgC6mQ0u?=
 =?us-ascii?Q?CcS9fPFQU/lD87ytjKMpvppr+bbIaai0nrRZgMOUPxFtbggcvXYy8BI8EvNN?=
 =?us-ascii?Q?zq39f3dzSoyNMM2wsOHtIjiAZWWdXw37tks9qq/khROA3/MQb2HwXRLJHP3E?=
 =?us-ascii?Q?a3jXx7miHImAUgjPqcEFcmwH4YcNrfySLqpIglxJfPMP7Biav091WzEaIPXf?=
 =?us-ascii?Q?HtuzE0OV6XepFVR+Dgk3WOZmazH3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a10b69-8242-4282-8f8a-08d9624aaa68
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 13:18:27.7937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7B9KjbOXCVx5ucpBMk1DXbul8CP5KhzBwEKRNxg0IH2eiJqMozd5ICEQHnlJU3UhzjCgV6eGcXQOarChfJ2GgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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

Hi Simon,

On 08/18, Simon Ser wrote:
> Hm. This patch causes a regression for me. I was using primary + overlay
> not covering the whole primary plane + cursor before. This patch breaks it.

Which branch are you using? Recently, I reverted part of that patch,
see:

  Revert "drm/amd/display: Fix overlay validation by considering cursors"
 
> This patch makes the overlay plane very useless for me, because the primary
> plane is always under the overlay plane.

I'm curious about your use case with overlay planes. Could you help me
to understand it better? If possible, describe:

1. Context and scenario
2. Compositor
3. Kernel version
4. If you know which IGT test describe your test?

I'm investigating overlay issues in our driver, and a userspace
perspective might help me.

> > Basically, we cannot draw the cursor at the same size and position on
> > two separated pipes since it uses extra bandwidth and DML only run
> > with one cursor.
> 
> I don't understand this limitation. Why would it be necessary to draw the
> cursor on two separate pipes? Isn't it only necessary to draw it once on
> the overlay pipe, and not draw it on the primary pipe?

I will try to provide some background. Harry and Nick, feel free to
correct me or add extra information.

In the amdgpu driver and from the DRM perspective, we expose cursors as
a plane, but we don't have a real plane dedicated to cursors from the
hardware perspective. We have part of our HUPB handling cursors (see
commit "drm/amd/display: Add DCN3.1 DCHHUB" for a hardware block
overview), which requires a different way to deal with the cursor plane
since they are not planes in the hardware. As a result, we have some
limitations, such as not support multiple cursors with overlay; to
support this, we need to deal with these aspects:

1. We need to make multiple cursor match in the same position and size.
Again, keep in mind that cursors are handled in the HUBP, which is the
first part of our pipe, and it is not a plane.

2. Fwiu, our Display Mode Library (DML), has gaps with multiple cursor
support, which can lead to bandwidth problems such as underflow. Part of
these limitations came from DCN1.0; the new ASIC probably can support
multiple cursors without issues.

Additionally, we fully support a strategy named underlay, which inverts
the logic around the overlay. The idea is to put the DE in the overlay
plane covering the entire screen and the other fb in the primary plane
behind the overlay (DE); this can be useful for playback video
scenarios.

Best Regards

-- 
Rodrigo Siqueira
https://siqueira.tech
