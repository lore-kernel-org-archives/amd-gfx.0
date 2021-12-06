Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901D9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119857B1A6;
	Mon,  6 Dec 2021 10:21:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D51C6E5CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 08:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=docK8hBkwCBhIA8KjOPbmvad2rB15HCXl/A3jx5psVLlPmsKJmR6j7BzZbuAUZrq50osFqpxaf2uG4imTW0Z3ZVlRqVhAG3LuxyxvWbeogW/i9d8GcXGr2NryNnR7cg+e3OA4psTpcgIvuXHU+fEzVqXQ369rXq5+8N3/D7cZ8w1qq2tJDXCt6vfaXOf/sSgOQqM5pfkcvJ+WKwZmzeh2IDW8E9hf5QgpkixRoXsDeZUPlJnB2u+FeHOQ8nDwUsQedGxiA5AiKpGmNLog39+8pwIU756sJNg9sXYLN++6scdYDWGRWbSpqhZAYCAEJ6n9L9aGXHcW728EbUGwcvDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42yWi8hqGzGs/AXXN7LldH8JW3o1+40ik9wGiXhndBs=;
 b=UHY9HJVp7yZZn79SxJj0wQ1x+QYiC59q2U7WcvinkY6Ju2NJTh3yvbUYL89e0bs4Ww8ifPV0lyOu92QuQUfLqRG7Jve+SlGpYsIRRzvKBbeuIyCsSAFR98/uOrgQSZkChe83RuuELhSED4vaWiS+ycUaaIMGXE0/mA80sfNCVWRh4JBvHCsZpSLiuvj22aL0WxqJ7OS7L0XLhxFpPuE82sM1kLTd7mZvdGoKBHGWM/cH5170jNLAqiHfv0C0+TKuJwsry3bk8ia8qu2sbxYYbQRiWP4FX9c4UIurwfXy07WkeW8BTHk1IZ1x2DyrDJmRdLqH5BRavYJghpwWf/EUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42yWi8hqGzGs/AXXN7LldH8JW3o1+40ik9wGiXhndBs=;
 b=qKDy4d3oCtF7QuMelsKWf807+3lDujRIeDMn0ZVk8exuxrR7uwTT4UE3OBd/bt51JTp6kCMPs4Lvnii/XEI1NE1Vv+8yKuaGCLO2W6AVO9HaMs6/mgyz3anoqitjb3R+DVDyF0ndvoT8+TIBAxOcUxFQE/LDu8uM7ZiO7Tac0OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Mon, 6 Dec 2021 08:44:31 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 08:44:31 +0000
Date: Mon, 6 Dec 2021 16:44:15 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
 when dpm is disabled
Message-ID: <Ya3NXykr61OqR9fS@lang-desktop>
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
 <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
 <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
 <DM6PR12MB4250FF2A11037B18176DE1EFFB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <DM6PR12MB42500FDF83B2FF999385D5E3FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <ec924948-c76c-08b4-c788-5017a2a18692@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec924948-c76c-08b4-c788-5017a2a18692@amd.com>
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by
 HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 08:44:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c2a3e0a-3f00-4e11-c13b-08d9b8949f09
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB301884C57CEA137CA138C824FB6D9@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXHUdz/UYqyrYeac4Rsd/lsj1I4mW46tM0v5TmJuHG/DINUu4EkFHp6d4vq2uCKr9fZIqs8XJ9DifDjdOBDwuN/4mF2FF9gF7lNqZR/Ko2c6buC2oh2oqH2T3eJcGkrML2RHSsFcWMCR31WWY8f+luYUkox4Rwkt8yNZALVMaL6SUjBpERc5VZ8yRknCi6oVlZwk2FlMSutSLbspRhEQw9kfMZ11kdU9ZDIhRLDfCSrJrRGuiCsrLw6aP/rmVChlQrMmG/r/Y33ZwdeLXHl9k68qyo+sP29u17eJYbh7a7apEjkRCQ/6ZOJk0NtYEnjIamtLYTTK4pO0CuI4eclHkT6LNbaSBKOu0VTHzcA3U8VvehwSLdTQZ105gbXN2FDKVXnQ2pARyL6/xzwJVS0qdjleNNxJ2ZQxH95d8CrOk9FoHSg8GguqXoTy5RV3cQTPAnlS/YNZ+Dz/S3y03/0t/S4Ple6yzGSE++bm8k9RVsNKBauNaBxLTsmUfSjCcwJfCwkjqx/vH6CcArC1pGpM+qyCZqzqEPcT/lO7UXvfwwvxgpgqiIs2E+tTnr1b5GjKkE3tUcqxcbSTsPGLZ6w2ns/wWcvD/Iy52cpIYcCg8dHwMqCIt5K31l7e4wRayb0QPx4znR1PW0WAUl2uRa8pZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(26005)(316002)(66476007)(53546011)(38100700002)(66946007)(6636002)(66556008)(33716001)(186003)(4326008)(956004)(15650500001)(83380400001)(5660300002)(6862004)(9686003)(508600001)(6666004)(8676002)(86362001)(2906002)(8936002)(6496006)(55016003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ivsMJTu9tMZ/Hn5cnDIcHWtdvpnYPgdT35e1d+ZFdyBvh6AnLlkqnH2JM+R?=
 =?us-ascii?Q?cyKdLTkbkDdTT1fsnkwA3KjU/I+T1P8+sSSgK7QUOfLjuKXmgR0SHW5NA16W?=
 =?us-ascii?Q?cfTvWwqb3tpOyLoxO1nXYvkKCusrRS8ifvtFhIEg++my4zruTwmGq8yYpuj1?=
 =?us-ascii?Q?8XNMZdqYLuQXbUJkZqy3cASjQSCnaunzoaRCn4yMYadaTLKmMYrYH7k9gp9i?=
 =?us-ascii?Q?aCIHnHUafSToaUS/wNJsUr49gsUWDjnD9K3QTNRFh3wxW+McyWQiLo3CCoFi?=
 =?us-ascii?Q?J/FEwTqIis/BaCb7XMAtjbDoZmt32SvAiNE1k2YPvu9DJAR7VsJuH6gNpQiM?=
 =?us-ascii?Q?SBgYqAzTovaIU/jfuWd+YKN5FcQ7cy3vuoUPsTFU+alJ/DkUkUDCtsjL/M/6?=
 =?us-ascii?Q?PzUzLazcsbVF3ajy+Duw/37ZSL706Vzsi6l5VflHwZNIxCediTKCJqW2WgV5?=
 =?us-ascii?Q?xD514MB6D8b9m84VdphgpzK21COgWzUufLoyDJNrrEYSTa/ya+ra56ukjTc/?=
 =?us-ascii?Q?EwxAp5kCrInb4ffkxUXaBqiLAZZ9tjWCnJmHxt+mWvfaIFddbUw0jF0GPeD+?=
 =?us-ascii?Q?TjvOU1Kb1mw6pYUT6lX/FV+yjF0dhPLY+q4AyKuRYWACKV2SEiHpO0KxRR7W?=
 =?us-ascii?Q?pcKf+iH/xdfVk1ImEbFE3DtMSA4pnM5FRvkBXEeEasl2q9WgDo6zeV5DFEho?=
 =?us-ascii?Q?ZnAOuzJlQlhxdLDweGRPjRe2mQUnlooGKhRX/51oY7eDNU7Ql5Y4N7AUIlp9?=
 =?us-ascii?Q?Ct2p4F+qE+LZa3Qr1+ivtgTES+/0T21+rCcgvRE2MXSBsRl5cg568piFWH2Z?=
 =?us-ascii?Q?2zL2gOh7UqOrlL3CsnZxMHUEqV09qxGaAfTzgMWyNU1zeou8pzHFov+Ovgym?=
 =?us-ascii?Q?aCleTnXUs5/88PSoZnTOvb1vwqNnl4dzD/mzJHiv7NGWycwRa3vvCrouwHPu?=
 =?us-ascii?Q?to7nvBuVjOZRQukX1IJEWIkVS9ZLVNrvDnYu3gL+pkfo49VZ/yd5v87k+jd2?=
 =?us-ascii?Q?G62njpD4PsmM+u5U9QoUkW3/3kdoJ9gU/egMkVK/tJcv/R7VQr808yeRcnlM?=
 =?us-ascii?Q?Mj71SI3pM9pm50jx2H30qplV6XXC22nEzH1UgVVAbrYLrxnKDBoE7sXHUu7Z?=
 =?us-ascii?Q?GwRXS46TyvIeqcWHDzQ9euV9G6AKOtELmfBHttlTJkieYyu/jsmKoRA/j1M9?=
 =?us-ascii?Q?RwD9Q4nrWukf2o4b9EfJaMC+qF1xJeTHUIsV/r/VPadxYYUPwdsDpgwAUE6x?=
 =?us-ascii?Q?H8n3+6OwOQ41fOFv+nb99FwUTkEjSWxxKN73uHIDethZaICneMM2EhP4m1v1?=
 =?us-ascii?Q?6pBJejfhvIjSuB+r455xpac0aA6TPcc4UczxGeSzpz7KJ+mP1tQuThxBLh0X?=
 =?us-ascii?Q?Y6o5NN3NuV4oiC90A36gOE02Q9qsqeUrp303bPRqxtXhAzAcjKiE3VN2e5qf?=
 =?us-ascii?Q?VzEJ1VOR82D7RJ2K7A8MEpCvo9Ao44cUfeUJUE0gWZ8kNiciOVKx6NCRz44A?=
 =?us-ascii?Q?Tp5Auej86jsKAL6BvN1WSzR3jXoy4SgerFQMVVi9cc8TGGOKVlI0nz5vFHks?=
 =?us-ascii?Q?VZorB/5sav10KOE3wFkZiVmBNnoA5r3hjQ7ircQEpYmNe1Ia8xdL7bzOLziF?=
 =?us-ascii?Q?hCvS3+AkF0zy0gyAJk4+0d0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a3e0a-3f00-4e11-c13b-08d9b8949f09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 08:44:31.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoDYkmhhATxBROd5sptUuXXNDGyo2VmLlZM9qwBxB2WcV94y7Uy+SNoORTx9UrkeWgFDOCxMfgTC7RVaOJCTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/06/ , Lazar, Lijo wrote:
> 
> 
> On 12/6/2021 12:18 PM, Yu, Lang wrote:
> > [Public]
> > 
> > A typo.
> > 
> > > -----Original Message-----
> > > From: Yu, Lang
> > > Sent: Monday, December 6, 2021 2:47 PM
> > > To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > <Ray.Huang@amd.com>
> > > Subject: RE: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
> > > when dpm is disabled
> > > 
> > > [Public]
> > > 
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > Sent: Monday, December 6, 2021 11:41 AM
> > > > To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > > <Ray.Huang@amd.com>
> > > > Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
> > > > message when dpm is disabled
> > > > 
> > > > 
> > > > 
> > > > On 12/6/2021 8:19 AM, Yu, Lang wrote:
> > > > > [Public]
> > > > > 
> > > > > 
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > > > Sent: Friday, December 3, 2021 5:52 PM
> > > > > > To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
> > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > > > > <Ray.Huang@amd.com>
> > > > > > Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
> > > > > > message when dpm is disabled
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > On 12/3/2021 12:24 PM, Lang Yu wrote:
> > > > > > > The general hw fini sequence is SMU-> ... ->SDMA-> ...
> > > > > > > We need to send power gate message to power off SDMA(in SDMA
> > > > > > > hw_fini()) afer dpm is disabled(in SMU hw_fini()). Allow that for APU.
> > > > > > 
> > > > > > This message is not right. In APUs there is no message provided by
> > > > > > FW to enable/disable DPM, it is done in BIOS. Rephrase to something
> > > > > > like after smu hw_fini is completed.
> > > > > 
> > > > > It is power on/off SDMA message. Not enable/disable DPM.
> > > > > 
> > > > Bad choice of word :) I didn't mean FW message, it was about this line
> > > > in "commit message" - "afer dpm is disabled".
> > > 
> > > Ok. I got it.
> > > 
> > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > > > > > > ---
> > > > > > >     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
> > > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > index 2d718c30c8eb..285a237f3605 100644
> > > > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > @@ -277,7 +277,7 @@ static int smu_dpm_set_power_gate(void *handle,
> > > > > > >     	struct smu_context *smu = handle;
> > > > > > >     	int ret = 0;
> > > > > > > 
> > > > > > > -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> > > > > > > +	if (!smu->pm_enabled || (!smu->is_apu &&
> > > > > > > +!smu->adev->pm.dpm_enabled)) {
> > > > > > 
> > > > > > 
> > > > > > This check was there before also, only the WARN is added. That means
> > > > > > it was skipping sending messages in APUs also and so far this was
> > > > > > working fine (until this gets noticed because of the warning).
> > > > > > 
> > > > > > Now this would try to send the message to APU without any check.
> > > > > > That doesn't look good. Ideal way should be to fix the sequence.
> > > > > > Otherwise, suggest to do something like below as the last step of
> > > > > > smu hw cleanup rather than sending the message blindly.
> > > > > > 
> > > > > > 	if (smu->is_apu)
> > > > > > 		smu->pm.dpm_enabled = smu_is_dpm_running(smu);
> > > > > 
> > > > > smu_is_dpm_running(smu) will cause errors in suspend.
> > > > > 
> > > > That is interesting. What is the error you get?
> > > 
> > > [drm:amdgpu_dpm_enable_uvd [amdgpu]] *ERROR* Dpm enable uvd failed, ret =
> > > -95 That means EOPNOTSUPP.
> > > 
> > > Actually, in resume process, but adev->in_suspend  is still true.
> > > For Renoir series APU, smu_is_dpm_running is hardcoded as following,
> > > 
> > > static bool renoir_is_dpm_running(struct smu_context *smu) {
> > > 	struct amdgpu_device *adev = smu->adev;
> > > 
> > > 	/*
> > > 	 * Until now, the pmfw hasn't exported the interface of SMU
> > > 	 * feature mask to APU SKU so just force on all the feature
> > > 	 * at early initial stage.
> > > 	 */
> > > 	if (adev->in_suspend)
> > > 		return false;
> > > 	else
> 
> Renoir suspend shouldn't be a special case. FW should keep running with
> features enabled after driver suspend. Could you try with a return true all
> the time for this?

That worked.

But we just send an IP power on/off message here.

Do we really need dpm running?

Regards,
Lang

> Thanks,
> Lijo
> 
> > > 		return true;
> > > 
> > > }
> > > 
> > > So we got such an error.
> > > 
> > > Regards,
> > > Lang
> > > 
> > > > Thanks,
> > > > Lijo
> > > > 
> > > > > Here we just  send some IP power on/off messages.
> > > > > Is it necessary to enable DPM to send such messages?
> > > > > 
> > > > > Regards,
> > > > > Lang
> > > > > 
> > > > > > Thanks,
> > > > > > Lijo
> > > > > > 
> > > > > > >     		dev_WARN(smu->adev->dev,
> > > > > > >     			 "SMU uninitialized but power %s requested for %u!\n",
> > > > > > >     			 gate ? "gate" : "ungate", block_type);
> > > > > > > 
