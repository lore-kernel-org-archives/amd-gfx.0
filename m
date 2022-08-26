Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044BEECAAD4
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 15:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A40810E97C;
	Fri, 26 Aug 2022 15:19:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EBA10E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 15:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7amXHyxNLK7UR1xsCwE6yIGv+siNv/9FLFd4ASeG8omeV9CnxRWflWiko2dugUkggrTN8T/5YpYoG0wuVxuUO9ySmEKIKaXPTcarC9yu1P6Ol1w9ubhWA5ucz8C9wf/YlPmfSUeWTDpX5ZfgVDwSP/zTh4aVoNo0oP2x5MdpUuPmECB+dSdMGZxIuCk6/TBz7k2yR5J+dkFZeax3TeJRc5U1CA1S7O80kc74IvDPexqt5YSAivUPl7989aXhhZLmaF+QseTIVEXHPMIxxQ9hCFADCu/YFhEufot50Tp53FUUn+ZJMGcEtmIY3hx5XHxEfMtwYB0ZaCJ9eonXI8DTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be1wJOOl+92imqBKqDRqPqHz8bsR85GgXqKzeo7Ritc=;
 b=B7VujtOdBEZpdKKIIf62Sr6sf4MzPnJhLGrDxUGI0E03ow1QehqbPyCaMm7jF7rXYvcQ60/rfIL6q78Zor/QiXIS6qaL+Dws/vw1l1pEVbuUWrVCNr8IrvWNmkO1uoAtqp+stkx212kFgDj74kodw/d1tEO77bigcs8oNKZ+vlr6pgB9RVWNI38eUogrZc9ENXm0U7kFknpdqBZ763FIspgnKIBQa8ccU2vAc2gEcjRCTfjCMzSAb6bvT58sBfisjoEqqcEglg9Sry+ULZvaKutZzrxub5lpz6zHcZMG68ug1lIHp40keUmR1mfvyFIOZVqeMq9BRaKBQrp+8J9V0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be1wJOOl+92imqBKqDRqPqHz8bsR85GgXqKzeo7Ritc=;
 b=WS7JUuejQMTP+FiGgVLu2S6Nt+8ixsdc2Z5wG3uUF7uL1SuF/0yNR1VfyKX1JD8WiR56C4v5SkXW7qAI4IO0hDGO9dFsDSVApLzGS99SDMJ1hi4SGrnWXBSr8Oy3/Wh01uRQqgYaCbqj4rXyxi6mTfynqW9KYs8FuKHbFjmmD8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 15:19:45 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8cb2:3d2f:c63e:be2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8cb2:3d2f:c63e:be2%5]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 15:19:45 +0000
Date: Fri, 26 Aug 2022 15:19:37 +0000
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Message-ID: <YwjkiZCTGpWNFaD6@yaz-fattaah>
References: <20220815153123.138156-1-kent.russell@amd.com>
 <DM5PR12MB1308B61FF812A91CA0FC77EC85729@DM5PR12MB1308.namprd12.prod.outlook.com>
 <4f4292c0-7841-a955-c07c-1eb8f1aa9293@amd.com>
 <DM5PR12MB1308A8C9A177803B3FF55D9185729@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM5PR12MB1308E2A5CC5682F7DA944BFD85729@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1308E2A5CC5682F7DA944BFD85729@DM5PR12MB1308.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfe12871-35ab-4515-055f-08da8776680a
X-MS-TrafficTypeDiagnostic: MW4PR12MB6780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWkY2EeG5AHimmiNBgkEH9mY4yhNWDjFeWo+aKMh/RPCCRhMThxf3vo+RHqc/szviYAegWX3Z9NYL3FfRirxQjZr0gaRdyHJ/y62fExk1h+Ox5Qve2WCI1YEMsFOGZXGnnCGySqE/IjUsXKkjePeOSWFEU/z80+W1BUAp9z499cHimiB9ikxW/WBrwsg369keOQzC3x5dUrkOTAUyU1TFIhFb0NDGk+eEP5EdZjt+1dyeJ2xSatH6svSm3En2Ejw4oYtvTVKtY1xkLXjbdvhekPWNDO1JPBcqpYcgDcQu6XG61VT1EzLOW5Nn4erh/mMGcIszAtyVHzatjMD4SBxgFf9iDJjy8vPkDlMnHePflGbVUITMb8f5SBhJQmLCckPuw7X5U579sQGSK2MUyNY791m/gIg1of4gL2NdiGlYvRJl9ySrVfVhIO1GGDhPwq9izGLi7HLX8o1afOew6DW2WoY7Upo8MOyJcDUtsqAu8rIZQwCVlnk+ky0wezopeTzspudBoA5K9QjbGh+lrdWDkihFACNA8biERHAMRLMK0PcgbvEddkep3MN99YBnwI/ldIysAtILoiSlF0FzFTGQzZw8t2Xu5tz6j311NSK75KhnhPoXoGDpWkADy8BKRx+6a+9jH0krnNlxT2ncjeum55LuF5Pr7udJPUYi+w26kp/UI2OLMTFUsH7D3XQPqI55EVMGpXLkN5hVt2rEiVwug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(83380400001)(2906002)(186003)(9686003)(41300700001)(6512007)(6666004)(478600001)(6506007)(26005)(44832011)(5660300002)(6862004)(38100700002)(6486002)(8936002)(316002)(86362001)(54906003)(6636002)(4326008)(66476007)(66556008)(66946007)(8676002)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cAs9cCLp1W8QJfJKtk7U2SePancTPBpdnNXRbCmfMyXONRMVikc1aXCDROW?=
 =?us-ascii?Q?xTP3RJshQ8rg9jTZBKx4TBM2jd/hxDbkChJ8v+CQrCJciNd+cXNoG9q7hIuE?=
 =?us-ascii?Q?CsezJXGD6R5kcmAcolVfEOuk7jMsOE6LDhQ9rK8fDuQA7FsjSoYOKUu+2nvu?=
 =?us-ascii?Q?NiCQDNMgGwKSZbW/NQfIOh/OM/RL3bg0LVbw++6ffh56qzjSSlN5NU960nT+?=
 =?us-ascii?Q?D2e71uZsVp2w7QPliHRCvW6pB6qf5L4gjrG+rdFuIly3BaVJh7jyCzFhSpjx?=
 =?us-ascii?Q?19BDRHqE57hbWSRZWK8yZ/DwMid8AfW6KRDg78OYDhcaT7kAxsr6ldR07qI0?=
 =?us-ascii?Q?vioP7isPCBwiTY6/dscTNSNPSNNwyzFL2h8uXjv9uXSRdQJnr6lhHIcCvF1d?=
 =?us-ascii?Q?JD5oSeK6bJkk5kcnc/fcU651QytdrcL8I8trl3OFjYA9S/uglHUbeT+dqeV0?=
 =?us-ascii?Q?ajHJPEQ5ZGHxSOKIg+Tg+OBp94pgdJRbc58UMjgRO2IyB3LgEbKlf5O6+OKs?=
 =?us-ascii?Q?9ogoPAtO9coiLCENN6R5PX17eZyOmx86EuXX9ruOXWjyAN0cC5o+uR+cd6Rv?=
 =?us-ascii?Q?zaRc5PolmqgMjj0rh/CRkcGW10ApnSGpZ8ZOSngV+OQsuwIk2DrWwwdnoqah?=
 =?us-ascii?Q?qdqtyxeO+4hsaEtVp0SFErQV6zXxpVif2NBZnPl+jhmVduCgedDtKp/BfRXO?=
 =?us-ascii?Q?+L+JwIa8VfsTVisi0qqNpgvkRXKSZz/m59npB7LulhVe1pODXGw+kyfRw0KY?=
 =?us-ascii?Q?5gjraEtWeYSldhfcFwdsrVXTGSUnEO/Mi4n4Y/VDkXj0UQ2QmQpMNONXLcEb?=
 =?us-ascii?Q?qsr7OSfeVRG411igI4im8U4U7S9K/1DAlcGgya2QA9+oHmaTHRyYXML+wR90?=
 =?us-ascii?Q?Z24iF3Q6ztrAHzCK4YTWpycx2uqkDQn1LgxnIggtKAaVsI5/NltkiI593e2c?=
 =?us-ascii?Q?iIblYPy8hjAJ4eXnEmDu2eFD9AdPgoMcdPxFkLvPdrPnZColbZmJQKoQLtoj?=
 =?us-ascii?Q?GTHqf6O9fSUirppwRa6ZVpvUiymdfPc/wN698sv1sXWiikWzE3rPPH4SkERZ?=
 =?us-ascii?Q?3x7bFm7jyzls/IsDZfMoIUYNmb0/9zIbB2BbFllYebYoZwoJE8d/a5QDJQy1?=
 =?us-ascii?Q?PvyT27NpBxDz5ebZl1Ecy+wsNLcL/wmgKMRThqx49h7lvxF976Bp1IT/P533?=
 =?us-ascii?Q?eOj5cy4O0yaH6e144F0frOewZaEMsXGj8GVrp78Ql6Gg/KqEq/d5ki1I679u?=
 =?us-ascii?Q?jcHuOzh+eDY+BsZoSHV0OafE5oEjopOsxkc7xC3H/g9e/8Mcbkeb8gFK0ndm?=
 =?us-ascii?Q?sjlD/JQpjNH1nJPv7YROXEXVAT+eGaJhr1rHWflJuQzWEStpIJMC31gI6ksC?=
 =?us-ascii?Q?HmgfUGOt3CqJL7IDMtzJoatKdEYlHadS7zTX6DXoHQMp8Us1VyXaTXkdcQzU?=
 =?us-ascii?Q?Ymhh1d9dsCzdXgJiQmrvUjIxuoiVln5Gj78L4AbS87nHj2mxuN0kH+o9ZgWh?=
 =?us-ascii?Q?15NrQQuA4BrKXf28yiX9zLw7/iDpkBstH2LuEn4yTYf6z+Keh03Oa9KwW6PS?=
 =?us-ascii?Q?BvIflQO/QGbt6um0KMaIgo4KhlwGJp8wywkaDfhK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe12871-35ab-4515-055f-08da8776680a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 15:19:44.9442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfbK+BhDfJHVN6TKduEwSdLH9QTBJ9cZWeYQEJrv3R/P2z/q+YqnEu4qmofVaEZNR8ZOExDJelI+pEVoasz2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 25, 2022 at 08:54:46AM -0400, Russell, Kent wrote:
> [AMD Official Use Only - General]
> 
> It does indeed short-circuit on || (If the left side of an || statement is not 0, it doesn't evaluate the right side and returns true). So we can ignore this patch, since checking for each individual field on the 2nd term is probably overkill. We were still investigating what got passed in and why it wasn't valid, so I'll drop this for now. Thanks Lijo!

Right, the "||" will short-circuit, but not the "&&".

...

> > +	if (!m)
> > +		return NOTIFY_DONE;
> > +
> >   	/*
> >   	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
> >   	 * and error occurred in DramECC (Extended error code = 0) then only
> >   	 * process the error, else bail out.
> >   	 */
> > -	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
> > +	if (!((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
> >   		    (XEC(m->status, 0x3f) == 0x0)))

If m is NULL, then we get (!m || "Don't care") = true. We avoid the second
operand.

But then we have (true && "Something with 'm->' in it"). The second operand in
the && needs to be checked, and this will cause a NULL pointer dereference if
m is NULL.

What do you guys think?

Thanks,
Yazen
