Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDAC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B95760FEE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B95760FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268DD6E49B;
	Tue, 20 Apr 2021 08:49:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7403F6E49B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 08:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbO5BGFNKqbc8IRt07hIo5kFY6i9dsoUNUw/GN7v1yAYPQpYObTPGSjzZfmb4AaQVf/oediilzfjyWnr7VHsZjmCLRRdvja6GsQUUlVgWbofFvHv5pfLQBPxM1JGA2EBWy+aKHUAXqNMOIp2qmz9+H2NUtwQPljDgy1sto/25NJXSIha2n+csm/QcASxTTQuKXM9rPs3tH+2bWuRCzndN2LstsW05r4pyT2QqbUyBessjhvUKnnjt4nosymExol+EssW4uiCrweoOk7UUq6dzVP1YvoMB0ZBxvNaDvL9fH36SMQeqOgCy3Qo6N0RrkKXbSo1C5/z9OapoaRqb3YxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDsXvX/ickfHjB4uQE7ZkjJGH2t7Opirlh4pTotn3o4=;
 b=Z2UjFs2vaeBg2Ia/0ZDAy4ol28uL6HPAphb30HDGVjL+Ql7e8r/CxpZ+/0NzpXDOzIbLujWUFaIs3/hvzRdCHJG7wc+Tdpv2pYGK5P1+DjoUn3lYnnLFB5Binq0T9ppefk6TbWtwXYYUwZz9Z+ZSiu1zRCjf4jg5kf7bHTpy9kBZLfe8NgzCGqOPCFbNmaHM/SGg4op40YVn1MNJbqEUrbTDTprckQVeWGh2PjWWIn9gXILyj+SOGCwhyx+0Xj8p6k23TAXKVooxqGZ4VrMjcDM3tElvZ56TCtXZ0udMofgwk7R96oHmtIHShwqc1JRoVAAlh6jZYkfNb2lh7aXz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDsXvX/ickfHjB4uQE7ZkjJGH2t7Opirlh4pTotn3o4=;
 b=H1w+s7RJYM+sczFWXisHBzLc1KpL+irgB7TadImb7SA5ZO8LIdKa0teh0NTsjeeZrJf+fq1ZM+10nXstXoLQ1Gg1GWE1eErjHxZFuhjgKOZPhdi69aVqZGCJz3IY7iKb18IbjLP+5mYjIFkpVgtNdyQOo/eR9L8wJwCoZ2Becgk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1517.namprd12.prod.outlook.com (2603:10b6:301:10::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 08:49:24 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:49:23 +0000
Date: Tue, 20 Apr 2021 16:49:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add mem sync flag for IB allocated by SA
Message-ID: <20210420084915.GB4046046@hr-amd>
References: <20210420082730.393818-1-Jinzhou.Su@amd.com>
 <31fd0d4e-2dc5-f9bf-2a71-4e90cde52151@gmail.com>
Content-Disposition: inline
In-Reply-To: <31fd0d4e-2dc5-f9bf-2a71-4e90cde52151@gmail.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR0401CA0003.apcprd04.prod.outlook.com (2603:1096:202:2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 08:49:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9009d112-7857-45da-cfe6-08d903d931fe
X-MS-TrafficTypeDiagnostic: MWHPR12MB1517:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB15177A9CD6FA8F5613CB4260EC489@MWHPR12MB1517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf/eY7Nzp6dfSRqNHMiDGE9g9XuuWnrO72ktVNYVY4GVEDore9CQgHIJ09xBm6hnST/TB4aM9hm3rTRoUxb67t7bDQfH3U3OLQYnEugv+qIX8xbUaE38gitvkvLRWD3keDG0Kd+cLpqzrQXKRNTKHPLR6M3PqvyEPA1H2CGa0dko9DBNoKYjEDwzylWkJbRgV5npzURON3UNAzgrVAmI1Hw+YPccXaEn8pXG+KBautkxCb9Mgjwa0FmJAO4M3o2YUD9j588a8YhAB8v1B775vrg2SiYtLKR0TVR4FOx+NamlKGHRgFc5JAKY0z6R70p0iEIYJMPZ2czHtCvWEN4A5267vB4y9L8mNCGfyE1fdYnSay0X/ZmkJA9/4Jd46vT6U1WLZI5194rbExBNdwIWeClC1/V834TtA65xsIR+baaMrAAaVjGky5GA2sBPQ+GCycW0FPg4nAj5ALHVd+Y/+1oUTDH/iDi33h3dsHbJ3qXSXqQ28OVbDyeYSTQ6lVmi4nAmr99BDlSqiM7Sz1mXgCoGESS2RnJg8F/zr9YrV9zYxx+UBBqITwMH1GF6kCD/6tBoFy2dJhc1wXofua8knkrsBCIvRpqdEeKFVFU1PaSQu8TeSB1mvN2sg0kf6ULRQgaZZViPkqgIBDa4ag42EQHd1qq2PEV58PMB/tSkcr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(6496006)(186003)(66946007)(8676002)(1076003)(33716001)(26005)(316002)(16526019)(956004)(38350700002)(86362001)(38100700002)(54906003)(4326008)(2906002)(66556008)(9686003)(6666004)(66476007)(83380400001)(33656002)(55016002)(8936002)(478600001)(52116002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?GjquesPoBSQvcHxca5uq2o+KC21uy3t7fshfVFx+TJcVXjwnSzdWGG5fPy?=
 =?iso-8859-1?Q?pCyWoxgKNZa3zQgkju25IBw5uUxWUk5jrQHYNYsuu8f1OSU0VpJVxLVFSS?=
 =?iso-8859-1?Q?9YTXdyCVdeHGN+HyAk2uc69nDW1pA3f/P3hnRk6GUYyC69W8lfGywgeWyg?=
 =?iso-8859-1?Q?OunmWdynaCC1TqccidonreVMuelGgfZ8FX3LjEyflY4tqejpW5idGgUsvq?=
 =?iso-8859-1?Q?zVqHgjLaZEjxgfd8MLsOs+ASZYnBTSvVxh52vyKJB9YXDh40QI5XX5SPHS?=
 =?iso-8859-1?Q?eqr0SZKxh59Mo9ms4IzvMgI2OP2YtpTioxr0LM320MIK34DKEEFf572jwm?=
 =?iso-8859-1?Q?gb6qsvTAYAM6WgFN+12j8HmtkCIQiAqDeJMFDZIKVeOHWRfQ8p3qAdYhWt?=
 =?iso-8859-1?Q?NJCkvtECYafvylgt52AU2YM+VvLqGQNYE4nIXAG+SRGKk8W44kQKwEYZWY?=
 =?iso-8859-1?Q?da14uzuEIosayVInrz2i2kjQknxVnyywdJozj+2j5IoW/wmG6KVloIEqyc?=
 =?iso-8859-1?Q?BvaRZ+tXqADRjkYFgiaa3B58rX5ik9M9DotiWtNG55ORzLcMi/DQdIsRya?=
 =?iso-8859-1?Q?29JEoMrzNbzaZlVA3Ce7/J/6JcXzWmwzmj4eATsp4edW+KDqWHrNUgVkTE?=
 =?iso-8859-1?Q?IjT1uIhImOiuBd7p2z+Df10H9gg3cr7kkWbJXVjkSczN1RstMdnyU23RA1?=
 =?iso-8859-1?Q?8OlsFpjYzwCvnuaEx/r0r2ctmSTpCD9b8frRL+zUqv82Xx4AS9GHJLBHqg?=
 =?iso-8859-1?Q?FRL963YT132uhZxahZ/yv/xI53N+IhhWdeL+M1yfkHxmwcyGNQvcPRYMRt?=
 =?iso-8859-1?Q?IUIi6QOnMM4Oc8ULe7SFnIz5rpnQ2hGhG+a9jKpABqQHpeSzymqgpUlkI3?=
 =?iso-8859-1?Q?tpNhlIIES3RQQBqRxeN/JPVZTGfvfJRM+0AzJB4iJaoBIrnsiiCmg0xLwL?=
 =?iso-8859-1?Q?iERiFJUzmNFN4j7HxKBJ0tMLAEOei61Z7klHdzW0cCHYVFahq+1WlsFoHE?=
 =?iso-8859-1?Q?LI/r0fVMEUK2yeAFLm9NqDFfBmOOl6p+ypWT+SuiFh5w0WzDldV0zw2+fJ?=
 =?iso-8859-1?Q?g+ie06q+ZuENUC1TYzBWeRBsX9IgLYCCnk3tF16xtp3nAQ0qAfMzenjXQ9?=
 =?iso-8859-1?Q?EO7W8XtZWcozPsgx1xLzxyuX5U0WKmO98F0jd1wnimy0IgyLsFJUD7ian7?=
 =?iso-8859-1?Q?KYSatxGj2Q/svRTsIFNjPIZEULkkKTFXPmv1HqLtLeTERujcI/4FFye2Pj?=
 =?iso-8859-1?Q?GMrgT7BFusHu/QV4RFHVtXfNu7u4wkQc+dmfYMWnIxu7WJohC+TNZRNr0z?=
 =?iso-8859-1?Q?Bkb9nWtW2iDX9bdJFenmQc0f5BELWBQzeukuqcKCpu+64YZ03dFdNnH5BD?=
 =?iso-8859-1?Q?XuPxY8JO0m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9009d112-7857-45da-cfe6-08d903d931fe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:49:23.4503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxC0JhDRf2jzJ6xFPruSG1CMggTyMNtoe+BEiAxmKE2vXt9kA+ROJqO7LhKwMZnFQ0b3DzBraGfdL9PBPXC33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1517
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
Cc: "Su, Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 20, 2021 at 04:34:18PM +0800, Christian K=F6nig wrote:
> Am 20.04.21 um 10:27 schrieb Jinzhou Su:
> > The buffer of SA bo will be used by many cases. So better
> > to flush the cache of indirect buffer allocated by SA before
> > commit the IB.
> >
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index 148a3b481b12..a2fe2dac32c1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -76,6 +76,8 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct =
amdgpu_vm *vm,
> >   		}
> >   =

> >   		ib->ptr =3D amdgpu_sa_bo_cpu_addr(ib->sa_bo);
> > +		/* flush the cache before commit the IB */
> =

> Either drop the comment or change it a bit.
> =

> E.g. like "/* Invalidate the cache to make the GPU see the newest SA =

> content */
> =

> With that done the patch is Reviewed-by: Christian K=F6nig =

> <christian.koenig@amd.com>

Yes, with this fix, patch looks good for me as well.

Reviewed-by: Huang Rui <ray.huang@amd.com>

> =

> Regards,
> Christian.
> =

> > +		ib->flags =3D AMDGPU_IB_FLAG_EMIT_MEM_SYNC;
> >   =

> >   		if (!vm)
> >   			ib->gpu_addr =3D amdgpu_sa_bo_gpu_addr(ib->sa_bo);
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
