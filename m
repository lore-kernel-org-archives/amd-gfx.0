Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682A1C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 07:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BED10F3E7;
	Sat, 29 Jan 2022 07:54:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0340610F5E9
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 07:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz8aNckwLAnyalFg5fkw1BjzcX4q5owr7pre2Dj4Ynzqek9ljV/AHwRtZDIf+xzvHtjdJvneFR4wq3LJW92jOp0YbxLoMsx6bWQxwR09diFoUErPU22R6ojUgtNfVXeqJcgsjgjeIGklZomvQpnlf/HySHFjiRfCnEH5Rp8V9xitr6UaOTJAo3t8nLofmUJimMYUoeySdQPkk09HcnecJPQafxD0PwazmeOY3xhbSuTCliF0uCKGIBiaUkVtH2nD4MWUI+rFmlRpptdj11lKcxWsnn1SmPPzNMTQgwcQE+01AqTyxwWeZUnSYyceafbBdjrFvBpt8MVvl8c6M8iDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp+FRHnBqDSEDN5HgpL9hsBSiiL0kr53NIppkwx5fbU=;
 b=lSlqSWoaNx7k1yOAlbKNBNxMl0muKf0oYhPNGJUOhZMvgmhFc+Yb7eld6CvOxJpwC2VQIpdesRCmRcHL1zMOE9FHD1abpLIzmmHkMq1fDl15wkO1CKZl6BPRJrrjO+PEK6JzlPMOHZfOJdvjlLy2RJVRSE5SVDXjQjsiIpRhq4Mg2LUbOoFZXzhpI430i0IqUjcoebLRPGX/PNx/Z46XO5j1A5a7UOE8f3dTitgYFjXIuWoCxUeHcT5h478Ny+k/s+EbRAMTh2OGmipAYPcbnkYO8SYMJN/xx1Ww0D252dNh9DsUTvY0XBKkMLCJxJvHTXkPbxaELp7/VP+VzuSzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp+FRHnBqDSEDN5HgpL9hsBSiiL0kr53NIppkwx5fbU=;
 b=RBmVEjH9MQb7g05ndevqIgrn6t2At4jm4m4uxwD4OPWudg0JD6kM3BDDof3siWQj+nX2K6vjLrw+L7ObFtayb7nJJ9IBNlWYEq9LN9CnAnVebf7R7VrZ8tLMc7Ug7g17tGO5p8mJGw5mO3qNzapWwxJ1lWoQhFAGZ33vtNAoikA=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BN6PR12MB1762.namprd12.prod.outlook.com (2603:10b6:404:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 07:53:56 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 07:53:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Topic: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Index: AQHYFMPQjicfT8Mn306Vd3/pvOIqQax5m7ug
Date: Sat, 29 Jan 2022 07:53:56 +0000
Message-ID: <DM5PR12MB17705785AF5E42503B03D2D4B0239@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-29T07:34:21Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=002abee1-2681-43a7-9862-ddec5a27caa5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-29T07:53:52Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 6309f3ae-bab9-4995-8555-a70fcf991267
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 403fceed-65f3-41f6-1f48-08d9e2fc805c
x-ms-traffictypediagnostic: BN6PR12MB1762:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1762F0B5320FCF074C80F066B0239@BN6PR12MB1762.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2J9vUGifybriOImeuHmg4MVPIFxpLKloeIxuH3gjSlILEw2jCVNJRv5TeuNNOZmHb+l9ybJY/cwsHJo8Gj+F3MfB9WLzH2gphOfQLl/UTE+fSV//zXDZz1hHxTkavVHNwBG3EY4KoQ9LtIt93L9zFuoioet8elPcnMUfSJkrPNADzCoFJz+7eWS0Ut4dZg04t5V95I4ho89oFqAAaxVzSh3VKKiPyQCzfk2JT2co1jphJebovJ3nrhGDIxPyrH1SSQSvcTrEZuyooritolxSwwVmLxRVbKv1s/ZAYMoHhUIQKu5SNSbiOBgRSHc229hCSKtULvnvIGaWdT4RBsLIPRlQRSgZqOdnzfbeX8QVZOxJ6RKiBqysfeYUZDTe3+U9sXnPHo8ZwQ2mb/Z5x0kBAzGHDwgi3JTf8VoufXMl0cyTxhYhIZxG3oUJrpr/0VfL6RjziY+k+wgwc+COvtSQZSAw0gYVVP7O1VBKGGyHSUSufOet/te+PEZCVJ3IWrHhEL2dzBBwyYPlqxm+3uP5/GNFesrs6KVEgsDrAg02hl2KosUMw5tjcopzvt5eIVOi+aDjaV6jO4AmQAeayNTE4222hbgF8lGOHNOsWU54zdZm/VwMuDPjZTM89GXIJlPPDcmy6UOM60xDDhMJZnLPdmQNtz1ZoUvoqp77M36a/RcXXC8nPE0JG5U/FeMBVUeOzfjg/2EyWL4rE/VLJ/WFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(38100700002)(53546011)(71200400001)(110136005)(508600001)(33656002)(9686003)(6506007)(55016003)(7696005)(54906003)(4326008)(83380400001)(8676002)(86362001)(8936002)(38070700005)(2906002)(186003)(26005)(52536014)(5660300002)(66446008)(66476007)(122000001)(66946007)(66556008)(76116006)(64756008)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6qD6SLBh8cq95g6N6SHNxEAIuszzXzCHsJbfViKWnUpIwMpSa4fPhzczSjKh?=
 =?us-ascii?Q?KTBSOub6EFtUCoyOLrS99HwKV3EyBOvW+ALSNSzPDJoUa+6EOmgskE5joX5E?=
 =?us-ascii?Q?vJjq70fMTaNsp+SKUXNn2N+uEp5+hZWmYhoo0B6/wf/g0enw91zVh1H9ifda?=
 =?us-ascii?Q?MUb66uUYkb0IQCllsTrZP4OEqRaOTvOk0sqrP79agHBfx1UGIqWMJU0GGO99?=
 =?us-ascii?Q?jd9mBlADsc97YzOZq2roA4DuvU/wlIjZV6z5sI2yBmRbfogSYJYWSObhq2N5?=
 =?us-ascii?Q?zdKlgKBiVW0zuUhDvpsIa5YPGG/YuF9XceE2ytdGq1oC5WEz79XZx7ASCPin?=
 =?us-ascii?Q?3e/fTAyptwLgvFJsKI3TDRs1sOVM/xHwrpj6tjg/3R0FyFL/UA3swMeUxiH1?=
 =?us-ascii?Q?ppprfvrX50MHUL+bUOIyLN/kHUOpDOgCEv/FmbLr8pu/Ws5Sks1VDCP4cJ5o?=
 =?us-ascii?Q?7OWPVaMLbolmDDK3p30mT2Em5Xe4Ge9M/C4DV9xr/kb149eUu8m6Zuttavx1?=
 =?us-ascii?Q?pRdJ/5iqk3DI5GB4gBKXFGChjJazBx4U/vUSMvV63jHXgbqois9vYviDMpNr?=
 =?us-ascii?Q?DGhnm1sEmYtK5pIEZOE3qd05FV5mP+OJvHvf2bEUOutGOsPs2Oz9MpYjm5eT?=
 =?us-ascii?Q?SXU6cldBV9wSba+3N7Zss54t5W+bDmO4B8ytLUoMWgM5N1x4wiLWHtxAKS9p?=
 =?us-ascii?Q?TSzgs0HLW9QWkY0Zl6P8JJGiUTWWNbSZgGbr4jQfKk0TzmprNV9ajqJboXyX?=
 =?us-ascii?Q?vDr+zrdheGsFsGcbad016aFr+gW95cZMrlAJnMXsz7g+fypc/ZCM99Qmc+TD?=
 =?us-ascii?Q?ijMvb+9YbfJgX9v12Df6oeIw6fgG+soQZJwfScQ1+EZEr+0rVVY3UXii3luJ?=
 =?us-ascii?Q?ucNmMg58n5F8OgYTYfYbRvUXwKV2c26mn42yZdLZ1/0aiV2Dpg9gdKgD4zfq?=
 =?us-ascii?Q?j7DMAi1uqfRlZxJjMtwzf9be5cn32kARUSWzfX4RJzcT9ZfKk7nP3BtuXzJa?=
 =?us-ascii?Q?OwUI3Y2j0UG+HaRjY+yVTpJn1JibUyKH2qKwSVqUEs9KYuM4VdpQZf5rSec7?=
 =?us-ascii?Q?GmnKq+JRBrVBT3dF0Hd+ujKOOWj8lZJDW812/xt8NKlT69VhNmtc4bn9JXwU?=
 =?us-ascii?Q?QT/y3lgbsGf09chdLVSqZ5fQkm5R7iGZyM+mzq4GTdeLCGJ9Xap5cpI74lUA?=
 =?us-ascii?Q?Abq8BSM8uYMI9l/U+mvJkLLpWgt6LehjFU7gS+Ifu8NMCaLSssuLbTI4q0e0?=
 =?us-ascii?Q?HnaXrx4GetP7OAUfPTT93fDjk3oqkex9se3JMKRaCqOZkqVUZpuOIvI/taRN?=
 =?us-ascii?Q?2b1rwPxEJhxuxUVL7ME8gSpF/cTYZz1zaR/LsBQHexb6N1JO236ZopzBDOwm?=
 =?us-ascii?Q?txJ5Lfz1UDNxAcWUIUyIFsTzFQIfWjF2qcOf1hAEA4qWWQ9vijg663CShql5?=
 =?us-ascii?Q?RXyAFgD6MOOnbZhadGlccXFRFdELtZj8QnZ3e0wzXp0RcmE2ATe39jWEYUDd?=
 =?us-ascii?Q?S6JER/AYNPCskSfO3cElR4/0nvos/r8z7jRAJs5JMrlsB8gCJn6vUa8OqU55?=
 =?us-ascii?Q?UhJmN/tx8zan4MZoAEA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403fceed-65f3-41f6-1f48-08d9e2fc805c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 07:53:56.1699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njDUGbpy/bZpr2QLNz/x7DRrgegKPwl0DpAc8J0uJZ03acnS8VKfOLyR8aYtZGpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1762
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

For quick workaround, I agree with the solution. But regarding the root cau=
se, the list is still messed up.
Can we make ras_list to be a global variable across all cards, and add list=
 empty check (or add a flag to indicate the register status of ras block) b=
efore list add to avoid redundant register?

Regards,
Tao

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Saturday, January 29, 2022 11:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
>=20
> 1. The infinite loop causing soft lock occurs on multiple amdgpu cards
>    supporting ras feature.
> 2. This a workaround patch. It is valid for multiple amdgpu cards of the
>    same type.
> 3. The root cause is that each GPU card device has a separate .ras_list
>    link header, but the instance and linked list node of each ras block
>    are unique. When each device is initialized, each ras instance will
>    repeatedly add link node to the device every time. In this way, only
>    the .ras_list of the last initialized device is completely correct.
>    the .ras_list->prev and .ras_list->next of the device initialzied
>    before can still point to the correct ras instance, but the prev
>    pointer and next pointer of the pointed ras instance both point to
>    the last initialized device's .ras_ list instead of the beginning
>    .ras_ list. When using list_for_each_entry_safe searches for
>    non-existent Ras nodes on devices other than the last device, the
>    last ras instance next pointer cannot always be equal to the
>    beginning .ras_list, so that the loop cannot be terminated, the
>    program enters a infinite loop.
>  BTW: Since the data and initialization process of each card are the same=
,
>       the link list between ras instances will not be destroyed every tim=
e
>       the device is initialized.
>  4. The soft locked logs are as follows:
> [  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           O=
E
> 5.13.0-27-generic #29~20.04.1-Ubuntu
> [  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU,
> BIOS T20200717143848 07/17/2020 [  262.165698] Workqueue: events
> amdgpu_ras_do_recovery [amdgpu] [  262.165980] RIP:
> 0010:amdgpu_ras_get_ras_block+0x86/0xd0 [amdgpu] [  262.166239] Code: 68
> d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 38 48 85 c0 74 32 44 89 fa 44 89 e=
6 4c 89
> ef e8 82 e4 9b dc 85 c0 74 3c 49 8b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8=
 28 48
> 39 d3 74 25 49 89 c6 49 8b 45 [  262.166243] RSP: 0018:ffffac908fa87d80
> EFLAGS: 00000202 [  262.166247] RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e=
20
> RCX: ffffffffc1394248 [  262.166249] RDX: ffff91e4aa356e20 RSI:
> 000000000000000e RDI: ffff91e4ab8c0000 [  262.166252] RBP:
> ffffac908fa87da8 R08: 0000000000000007 R09: 0000000000000001
> [  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12:
> 000000000000000e [  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc13943=
20
> R15: 0000000000000003 [  262.166258] FS:  0000000000000000(0000)
> GS:ffff92238fb40000(0000) knlGS:0000000000000000 [  262.166261] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [  262.166264] CR2:
> 00000001004865d0 CR3: 000000406d796000 CR4: 0000000000350ee0
> [  262.166267] Call Trace:
> [  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu]
> [  262.166529]  ? psi_task_switch+0xd2/0x250 [  262.166537]  ?
> __switch_to+0x11d/0x460 [  262.166542]  ? __switch_to_asm+0x36/0x70
> [  262.166549]  process_one_work+0x220/0x3c0 [  262.166556]
> worker_thread+0x4d/0x3f0 [  262.166560]  ? process_one_work+0x3c0/0x3c0
> [  262.166563]  kthread+0x12b/0x150 [  262.166568]  ?
> set_kthread_struct+0x40/0x40 [  262.166571]  ret_from_fork+0x22/0x30
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d4e07d0acb66..3d533ef0783d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -884,6 +884,7 @@ static int amdgpu_ras_block_match_default(struct
> amdgpu_ras_block_object *block_  static struct amdgpu_ras_block_object
> *amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
>  					enum amdgpu_ras_block block,
> uint32_t sub_block_index)  {
> +	int loop_cnt =3D 0;
>  	struct amdgpu_ras_block_object *obj, *tmp;
>=20
>  	if (block >=3D AMDGPU_RAS_BLOCK__LAST)
> @@ -900,6 +901,9 @@ static struct amdgpu_ras_block_object
> *amdgpu_ras_get_ras_block(struct amdgpu_de
>  			if (amdgpu_ras_block_match_default(obj, block) =3D=3D 0)
>  				return obj;
>  		}
> +
> +		if (++loop_cnt >=3D AMDGPU_RAS_BLOCK__LAST)
> +			break;
>  	}
>=20
>  	return NULL;
> --
> 2.25.1
