Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A09C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 06:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711B110EE52;
	Sat, 29 Jan 2022 06:09:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E69710EE4F
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 06:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KASwbtKNvPU2/QC2z3EfBx/1P7mizF6SbbhCdpwlWdIBnfeHtOmdDVCHIgJ/no6McXdDRqI9NvhJfA3ODN0+wwF6ASuAEZcMIfs35T5xbs65RVsIOpt3ArSl7BWDO5d4YSEdGblIolStjh2QrwbipAnIJYo25/F/OUd3wJ82drm/cAZiZeSs6ptB5JhKqgY3582H7Rt0Mf1+DV2nGYRGKvrDMZTC0Zk6a6cAlzK0+ZGD0jerqNPTr1zAf2rUYZ7RSrx2BPXuisGZKX81WfQ1hO2szEPDGC6yW95/dj6NuqEYrvm9FSJzRwUgTbNkGdEwtClNjp69d/ES4Mo9rSLAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ6v5yXa5zm2SqBtY90docpCVYkOtlOrxyY9yvhlBRs=;
 b=llx6XzTjl/gIxJxscLNkvsByESqhATlShK3IqASuZcQaR1o2HwbWOn3YQlwZ+YdMuoudN+hhsXHljT7ANRFKkT1vIP8WYynvSxrp/VwXNb4IKaYZMYjgXHLxCc/PAl5d5ydb6QVgW1nU3TVfUG4zqZUXVVLefVNGP1+khnacat20mwroCcXofK6B2fnIj/Ulog4/9TgZRCoKRzR1NyxInL7p6KOLv7emeY1otWDab22Tmkrx/E9uAmXZT9W5QDscgotDs4/VXY70gbkNK9fxw/lS1+ioWpZvx8gPHqHDgio2nfAT+S5I/Va6Hv+XkbJ1hwcL2RoIDcYqcju34kfoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ6v5yXa5zm2SqBtY90docpCVYkOtlOrxyY9yvhlBRs=;
 b=qHlS4RFrA71/pw0VyVQMInTRp2X7jml2RnPDu9QOK4EIy/jKF8AbX4PqL3mahDZn0kJljhrkHp6veN05/t1+DzmD2Yyds6qN4t51fsGIhWtffqNl7UxCLCv8i6QqraK3LfC4msAUTkm3T2LPaXqpXx3qujJqcne+GiFYEmo/42k=
Received: from BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 06:09:44 +0000
Received: from BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::2978:c36e:41ae:4f69]) by BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::2978:c36e:41ae:4f69%7]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 06:09:44 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Topic: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Index: AQHYFMPQTCoPE5GEckunzKeK8djeVax5YEcAgAAjluA=
Date: Sat, 29 Jan 2022 06:09:43 +0000
Message-ID: <BY5PR12MB421266C94D16B54E0D5FDF7FFC239@BY5PR12MB4212.namprd12.prod.outlook.com>
References: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
 <DM5PR12MB2469E1D230F79516248A86DCF1239@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469E1D230F79516248A86DCF1239@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-29T04:01:27Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d5453a3e-4706-4ab1-a616-6bd697cf7376;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff809d9-fb9c-4c52-605c-08d9e2edf1cb
x-ms-traffictypediagnostic: SJ0PR12MB5438:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB5438A8A877DF4A6569AEDB54FC239@SJ0PR12MB5438.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ofXwOTB95VlG7vx6jjPvrQq/HdYXZbMg2bXu/2VukKaN3b1vxlzUCwgi++Hrg/NHPENcwBrMnapBDLzvXWRph2wH5SlwgSF9mZQGBKx+SRK8BrvOJRTi2JsRiYSiqwNyRsoQEtTnmL0uFAO0BQXeH7B+5m8ic4bZOpI5fNE4Kr+YSnROo7BA9Udv1WGU1b7UTSl4inR0poleyGjfu7BdrTZAlNSgk8uXGwaakXK7LXSyIVGzbt5/2hx+xLPT6PyXVq9+2ioOdSZyPAyttE6IGbDGAyYPBTxFJ6BIIf7ch3ZNaXE71HiAAOw0EpnOiRzqq4aEq5j5fUElTse5dNiYNZCJueNCkOedY724C4hHOWI1yK2LkEADA+Gfd+1Z4/6KiqSRxeQyAVJ3MnKWvGbhda6YmesgqLgiQ99MLROMx4Bxl5HPoh757tIzPk7v4TxiZ+q7ibIdHo+vHzh7QlbUT2BCdkIYkmiTlDxbUKe/bTSNatbjjlLjMqtDe71wveoFtwLZNKOuYj6NqHOCDtEelcKrm4aynV3rXZtkbtfmlBCq6HEeEWq6rDmtZqVfjLnQkSsCca9wNlnnzjQeFi5RrhAvJY4pKmKpeLJizROguwUlzSUof6U80Dob7fE5eHXiHHrhXY3uFX2kepYIuXE136MKQ+bMTGhLJIHaW66q7peTpn29qGqgJLL1EIodB0uv33s1ACYAA/9wkhUkLvcYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(76116006)(64756008)(66556008)(66946007)(66476007)(66446008)(122000001)(52536014)(5660300002)(53546011)(316002)(508600001)(86362001)(2906002)(8936002)(9686003)(6506007)(7696005)(110136005)(8676002)(55016003)(33656002)(54906003)(4326008)(71200400001)(186003)(26005)(38070700005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OMkai3LL/OgQjdD9cENnF8oWRjvD/Ye3605broHuSIi9L7kiCY2mjYufmf8G?=
 =?us-ascii?Q?nH8Y0OjUK/B2wrUN0q2v5qaUVZuAIwN0q50fnjg3cb/g87Zg+IUt+nJgT2JU?=
 =?us-ascii?Q?7mbSrA1TKhr7NXJ7I/CdeijTmjKtMFfwDTBhwnWtLBW4TefJyS1qTgA3bZMF?=
 =?us-ascii?Q?FrUPFkXAYoxnNbTsjPO0LI0sCqxJoDNcRTdsQB+NqukRe6X/4I2hvc4mX7x2?=
 =?us-ascii?Q?820IrxU0D/Ks+J3X6tltFpw4J+4vk3pmEaywoUiRFmZo0k8aAsYxIwYOVTND?=
 =?us-ascii?Q?zQNNj6UzBzWLFeVlcY0OovWBMEKNeN67YYF+lBVFsf9rYcNLyHtNhOv/vrqi?=
 =?us-ascii?Q?YfYUPALUT953nCp4QkaN8Y5dZ065+Nk+e94C0Y5CEZTIbRFhuAYOuBuFpTBg?=
 =?us-ascii?Q?J1uHoQK54cLQzDx2Tvih3niJnN3LG1ksUH3dseK6lckkOsL4aMH46xJAAmK1?=
 =?us-ascii?Q?ZW5iWVQ/In72kC/uomPi+ZA7ld34xW3NhwG+umOXAQ5sr3J1kts79iH72t1M?=
 =?us-ascii?Q?j8Zzls5JvQyz5BFhykUjYdWXyV/X4HXsZLaFP4CTcQIJtP2WNAxoXPX4tZxl?=
 =?us-ascii?Q?cs/7aj5aDyJWBr5W6208823xmvhTRlAwhB+ycQCry7eJRXRU819nQjsTtVRS?=
 =?us-ascii?Q?2cCO0Pyw9IoUOU/Z0gS9+TcvlRAAnQq6AA9nzUbZlMMp3gzcmYUIe79EAByS?=
 =?us-ascii?Q?CEZV6j0o8XsGtIO+qsaJ5WCchCbKW/qyCULfRPE8rTtWs+kRgtGMKHZgrGjb?=
 =?us-ascii?Q?6XYE3Wu+HK1oXz5Pr6lE9FY0hea6+z1PmbZExFHNnxSaCsYtcacI7ii2pE6x?=
 =?us-ascii?Q?3pHaFWeZK3A2TmDj9fUdMGljxaczxIjfYTcujKTb43OqThlUxkCP+5lBb0lB?=
 =?us-ascii?Q?bRZVfgQJRrRTn6GIXj1Eec9pSHUG8ALxyjkBqQBf7R3dhLNRSqcjgvZo/bBO?=
 =?us-ascii?Q?aIsPVxQDh+0uMTbcVhajlKyupcuEbnSfJNkrhbCsYVo2jRDOO95NbTt29VyB?=
 =?us-ascii?Q?mHiQyKBNE2fdzuKFMKmLOhIbwBDqkJrJvYkDLzz+flbVWaExUAKXXZXG4BQ2?=
 =?us-ascii?Q?y8aZSJ+F7anHPQXPZ3RX2yx1nc3byuI9tKBr+sYZDYuN8tZOFuNzeiqw48/a?=
 =?us-ascii?Q?XtAi7sd2n/taRexCHekpBuZPqdgDF3gnR7TJLsvlM/uKAT3oXGu7tjJhTz9p?=
 =?us-ascii?Q?W3s+3QTTmVCTVTu4TBk0U9Imy+0FB30Ks5wZHjqYGn3+1ywqFiK4pkShzEgL?=
 =?us-ascii?Q?+xkz5KExjaQXPRpTGnhmmp7opyw/8brSmCCKVWAJJ7sg/fQpXrHGN5ln/iOs?=
 =?us-ascii?Q?fU50g3vEwI5yi9gMotYjMz6zmP0fhT8OB8Q8PQK0A5fu+wodUC39w5hfH4GP?=
 =?us-ascii?Q?aNaRfM3OwbfjJue5cUFFj4tfJCScAKfyIg25XaWNQCkeunxtFV78sV30fwVf?=
 =?us-ascii?Q?4Iwj+EGGzMhf69WhT3PWyIrCwjO+JDwWPdTL27IprlLMErIrHy0/a9C33UBj?=
 =?us-ascii?Q?iVeCgBLBENeCYKarAEPn10t7PY4AQ8/kfx9KF7PgiY6RnUgOD0wNBm8pYt+9?=
 =?us-ascii?Q?ggZoh9t8jkWYVre0Wz+Nx4pbh85umNyTsW0xWCKqS8lOZ9pXOvMwsGc9fwjw?=
 =?us-ascii?Q?LXN+Muh46EpLnQRw6ODcKDw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff809d9-fb9c-4c52-605c-08d9e2edf1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 06:09:43.9369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKfdRbN9GgMGqA05KJO5M/1f7loaItUNta6lXtp4kJMIS+2hX5FmewqSOjHUwKfeJ8/PeQOQA+zMt8/tR3JD4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OK

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Saturday, January 29, 2022 12:02 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop

[Public]

Please add a Fixes tag, as it should fix a regression from former patch.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipechai
Sent: Saturday, January 29, 2022 11:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop

1. The infinite loop causing soft lock occurs on multiple amdgpu cards
   supporting ras feature.
2. This a workaround patch. It is valid for multiple amdgpu cards of the
   same type.
3. The root cause is that each GPU card device has a separate .ras_list
   link header, but the instance and linked list node of each ras block
   are unique. When each device is initialized, each ras instance will
   repeatedly add link node to the device every time. In this way, only
   the .ras_list of the last initialized device is completely correct.
   the .ras_list->prev and .ras_list->next of the device initialzied
   before can still point to the correct ras instance, but the prev
   pointer and next pointer of the pointed ras instance both point to
   the last initialized device's .ras_ list instead of the beginning
   .ras_ list. When using list_for_each_entry_safe searches for
   non-existent Ras nodes on devices other than the last device, the
   last ras instance next pointer cannot always be equal to the
   beginning .ras_list, so that the loop cannot be terminated, the
   program enters a infinite loop.
 BTW: Since the data and initialization process of each card are the same,
      the link list between ras instances will not be destroyed every time
      the device is initialized.
 4. The soft locked logs are as follows:
[  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           OE =
    5.13.0-27-generic #29~20.04.1-Ubuntu
[  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIOS =
T20200717143848 07/17/2020 [  262.165698] Workqueue: events amdgpu_ras_do_r=
ecovery [amdgpu] [  262.165980] RIP: 0010:amdgpu_ras_get_ras_block+0x86/0xd=
0 [amdgpu] [  262.166239] Code: 68 d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 3=
8 48 85 c0 74 32 44 89 fa 44 89 e6 4c 89 ef e8 82 e4 9b dc 85 c0 74 3c 49 8=
b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8 28 48 39 d3 74 25 49 89 c6 49 8b 45=
 [  262.166243] RSP: 0018:ffffac908fa87d80 EFLAGS: 00000202 [  262.166247] =
RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e20 RCX: ffffffffc1394248 [  262.16=
6249] RDX: ffff91e4aa356e20 RSI: 000000000000000e RDI: ffff91e4ab8c0000 [  =
262.166252] RBP: ffffac908fa87da8 R08: 0000000000000007 R09: 00000000000000=
01 [  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12: 00000000=
0000000e [  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc1394320 R15: 00=
00000000000003 [  262.166258] FS:  0000000000000000(0000) GS:ffff92238fb400=
00(0000) knlGS:0000000000000000 [  262.166261] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033 [  262.166264] CR2: 00000001004865d0 CR3: 000000406d7=
96000 CR4: 0000000000350ee0 [  262.166267] Call Trace:
[  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu] [  262.166529] =
 ? psi_task_switch+0xd2/0x250 [  262.166537]  ? __switch_to+0x11d/0x460 [  =
262.166542]  ? __switch_to_asm+0x36/0x70 [  262.166549]  process_one_work+0=
x220/0x3c0 [  262.166556]  worker_thread+0x4d/0x3f0 [  262.166560]  ? proce=
ss_one_work+0x3c0/0x3c0 [  262.166563]  kthread+0x12b/0x150 [  262.166568] =
 ? set_kthread_struct+0x40/0x40 [  262.166571]  ret_from_fork+0x22/0x30

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d4e07d0acb66..3d533ef0783d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -884,6 +884,7 @@ static int amdgpu_ras_block_match_default(struct amdgpu=
_ras_block_object *block_  static struct amdgpu_ras_block_object *amdgpu_ra=
s_get_ras_block(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block, uint32_t sub_block_index)  {
+	int loop_cnt =3D 0;
 	struct amdgpu_ras_block_object *obj, *tmp;
=20
 	if (block >=3D AMDGPU_RAS_BLOCK__LAST)
@@ -900,6 +901,9 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_r=
as_block(struct amdgpu_de
 			if (amdgpu_ras_block_match_default(obj, block) =3D=3D 0)
 				return obj;
 		}
+
+		if (++loop_cnt >=3D AMDGPU_RAS_BLOCK__LAST)
+			break;
 	}
=20
 	return NULL;
--
2.25.1
