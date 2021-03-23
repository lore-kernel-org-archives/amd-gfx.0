Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E6C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 01:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E94F61993
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 01:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E94F61993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8C789DA2;
	Tue, 23 Mar 2021 01:42:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7821489DA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 01:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0laKuqOH+GsQ69YbLQuFqqMNdyfhhz+RekgtXks/SaIlWElAj+D1wr3DRYo+N3B1VCNct5M1dsp8+EKruw7ZWpflS1gIUDsT0adt/A//cwunil9MtNrbdLXzJzdECYXvtHbHQ44y2xCpxb0b97vfWV9BklvM41Kk2RMtsdGR5dZFBV+NDXefApW4L3Dozs3GiMYzQrRTnMzABjrvm47hw/yezVxoDuCpQ79zofzZLGdcOfR6nziLhfY/R977Mw4aLiUnYa5dtm3lWgoQBzMsm7P8+txPHQ+AvsikVPXPIvLgamHK0xnTRc/Vava9JRz//0WGDaGrGUBCWZnNRH7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiIjj34UfxNBHFdFfXoIu36JQYyXkZRqf0/TFOI+2wI=;
 b=Ka3K6x1F7xw7xPQTNBydNaFm2sCYu9d7eaFWZPjmbIQXIZNuoIgWfUCe1yflsoS/mbSguI5hDK6JSJxKWXtkHXi05i4XhJVM4n3xuYCc26ZDYRpWg5AXbs7r/GW5UY3udPwgl5yASQVwctyUmlb7PE3fYj0s+pKJ4bFokc4R63V37iSf4T26y+2vQ7sgnCkEmk5K8pJw9IVLvemRF/WJjgXiJtnQi/pnpF+DQuDGsnergrEzfufvJ34lfgK/huxeNBKhgMa68Nv3Hacu1nWsKJgX2X4pmb3Mc1W29wyzMtvNRj5s8YXNDP3khrplGZ/RzVJxTP32oPU4tNU5njZTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiIjj34UfxNBHFdFfXoIu36JQYyXkZRqf0/TFOI+2wI=;
 b=QPhK8tdT3KtDcAwxsCOSt5FuX4rSeXwh2gb8sTGdjWZQQwMqHQUFdZKGk5DhdeWbzRu1SChdUNKZb/APeOpaTsZBV6WOwQ/M4tRhPdaTAauSkoAKeTLDZOs+T4cbAxCmambZ6JIIdaIhS/iLcF1Q7BmtMyUS9WRAElPxFQLdqno=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Tue, 23 Mar 2021 01:42:36 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 01:42:36 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/dispaly: fix deadlock issue in amdgpu reset
Thread-Topic: [PATCH] drm/amd/dispaly: fix deadlock issue in amdgpu reset
Thread-Index: AQHXHvMPkUMdQTpP1E6HOvniBqKcUKqQGoeAgACwIZA=
Date: Tue, 23 Mar 2021 01:42:36 +0000
Message-ID: <DM6PR12MB425041FD84A4F69186FAB8B8FB649@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210322081138.3484804-1-Lang.Yu@amd.com>
 <3f417799-f923-7709-ddd3-823ec89126f9@amd.com>
In-Reply-To: <3f417799-f923-7709-ddd3-823ec89126f9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-23T01:41:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=57902c74-d349-4d7a-8226-0c90f0910b7d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0fd41a7-4efe-49f9-1a63-08d8ed9cefe0
x-ms-traffictypediagnostic: DM6PR12MB3738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB373882E7F43F3766FD6EF736FB649@DM6PR12MB3738.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VDW+3SxZj9GvXgGWsaCrfrFhwsU1XDTbpaYA0fqB+y9rosmHNZys4zCM/xIx0jX+B5hm0Kl0AI3rz3LThkVU0O0dx/h3XSD7sZVjK3FLxNCHI3naipMPmIDAA+MybVYaqqRfUwCBoidJQ86ip22asMKaIYEIkrmLnGiDyjP+aLrktut9d5YvUYItFJcHlJM7fhkEb6TeuSK5dS89Q2We+Xde84vdgTZiaIjaRScOyWPL+X3XuvbBgMuYA4IqmSmPXUpwQM8Oq/xNm8q22of00i5rEKtoLOVksSfA4pU9yoPucVtaxm0iNUJYwVcdSgVK6XaLgQfIP/XXERUhFStPRTepJ9AFu1eFxGJUle/XDKtVuL7Jl1lqVSPsQEAjI60En2dGwv0pPkJt0Fms6GMlOaPecOw+yABNkTZoqHPoXpyOFsYFRohL+CGgc5HoFwTiD2qKPVyR5LwWaZfEaO9nBqi0z4KcE/ghquavlhqvBOJ15xzEnw6vY7b7EbvLSp69FGuNhhHwmH9ZA/jMgv5uPOghl7kM7G+2HKKzJU8XLIda4Qush1Qk+fvcJAK0e4BvBcgOExpDDBwHpXPIOBQys9rLC2i3l/6WA3H+wtFzeQXjUkHP0p3QSvo/v2518CXbe3wmVkXLD1EQWr8KH8U55Tn0XsQDgasOKOAPEKU0VAI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(478600001)(66446008)(64756008)(66946007)(2906002)(83380400001)(53546011)(4326008)(66476007)(6506007)(71200400001)(316002)(33656002)(86362001)(110136005)(76116006)(66556008)(54906003)(9686003)(186003)(26005)(52536014)(8676002)(55016002)(5660300002)(7696005)(38100700001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ekJ1cDZ0a3U2TW50elJIdThKK1FQMWM3YkxnWjl6cHpvQ01EaHFvOUR1TVQv?=
 =?utf-8?B?RGZyOFJRQ1JrY3NuMmZzRWZWaWllVGZFbkZvWnNSUFV1Z05xVTk4VHNUSXlk?=
 =?utf-8?B?dzd6N3dqVktOd1RYcERWbStWRHlDdE10c1VianQ3OHlJOEtsbHdQYUpjUWZv?=
 =?utf-8?B?ZnZaeTQvKzVsdmlJUjBqNWJIWlpYcjhodW5mOEErTkVhb3lNUjdaUFNoSFA2?=
 =?utf-8?B?NFBZZUZraXY5UU9LKzNqSGVlRSt4VnVZb1pFcDNpSGxLd05OeSs4Tk1ELzdC?=
 =?utf-8?B?dHY5TThjcFFSSE5GRVh3N3FzZXM1RFhjOFpsa1pRU01GUSs0eklhVk5LQkgz?=
 =?utf-8?B?SW56S3l0UGVFckxkQjdnSVNZTW1VczVtQjYzQXNmL1FEcWw0Y1NBMDc2OW43?=
 =?utf-8?B?cVlHVURkWWQvc1p0cEJqZkRFNVJkbUFKazJIb1ZzZDRwRWxXWVRLWVpUYnF3?=
 =?utf-8?B?d09pRWxLSUxDR3VsUGhudldYWW0yTjlYSGJDV0kxNHA3QTNJeWZkcmZ2MUl3?=
 =?utf-8?B?dnNMOU01NmpEUjhmZlZYWElib24xcTdvbWQ4cThUaEFDbUZmM2hHdW9zZi91?=
 =?utf-8?B?TDdzaEFaWGtZa1ZmU0JnV0NlKzY3RGhJVCttRG5RWmdic0FMelNheEdUTUtC?=
 =?utf-8?B?ODJFOEJybk1IdEtsLzNJQTlnSGdvakwvUFhWQW1lWWFtQXdDeDFoZ2JxY0gr?=
 =?utf-8?B?eHZ2N1huWTA2U2lyUEpZeEZtMFA3VnFQaGhTdGR1cXlWZXFFSFF6VWVzV2hG?=
 =?utf-8?B?SjY3ZDRaNyttTWpYSTlycG4yUjN3ZHVWNGdOU3BtWEJNYVhrUWVrcU40Mmts?=
 =?utf-8?B?ZWVyVDVlN1N0WEpDUkN1QTZ6OTN4MUQ1VDl1L2l2V2t6VDU4UTIvak11VFMv?=
 =?utf-8?B?Y28vT0J3QzVaejE1ZU1qMzNRcWMzREtRVXViT1B5ODd5WnQ1MTRFOGYydDRz?=
 =?utf-8?B?VHBMQ0xYUUxyOS9uMGN4MjU2alVYdUVIMkFXYnJzRmNBQm5ublRLZS9JVDdN?=
 =?utf-8?B?R3JpODVka3d4N0lXMXlsanJTbk9pYUNNYndpRHJ5RDNkMWh3WllXcjc0NGxS?=
 =?utf-8?B?UUR0WTg4UDZFTlhER0Z6emg5OUd1Nkt2MmdiQU1XNlo1SzBPK2hNclpOYU9x?=
 =?utf-8?B?VjZGL2xIK2o3cnRRbFl3OTREN0ZpYzE5UEZEZ1VqUzIvaDlpbXVtQzhMK0tG?=
 =?utf-8?B?akZnWmExV3drNnp5M2pvNDA4UFV0SVV5NEYwNFkzRnFvYTBBYlJGZVdIVHZj?=
 =?utf-8?B?Q0xWVHNwcTVlbmVHa0pSZ2lCQTBiVWZhMTBqVnpKZzMyTXpEM1Y0TkZ4blFM?=
 =?utf-8?B?dDVkOGlKMWJsRFk4TVhQYStWWGZ3YVB4ZURrNFpUQndGU1lLcVlFNzNCamVn?=
 =?utf-8?B?YXI3Y2NsZUJzbEdJbmhNL0lYbE8zQ1ZmOG1aQTZzenN5RzZWamRzdTVNVXVI?=
 =?utf-8?B?RCtSVWJGZEZtdmJYOUVZcC93SDh2NEFpUU90UXRxdmpwVWEyakVKQml3S1h3?=
 =?utf-8?B?OVhKRldibUZUR1dZMTBLQTA5MGxhbnA1WGNaTmVBUjdrRUNKWHhtcCtGL0hu?=
 =?utf-8?B?eWEvSThSSExjNERlRzROMW5raWErU3pkcHN4cHlRYWhSWDNiektBV3lkblRY?=
 =?utf-8?B?U05SK1FtMExUdmd6VDJhNGFDcnhqTHBHVml1QURqQzNnWUJhM3FtcURRcUVY?=
 =?utf-8?B?UEl6ZnVZRHpMSlpOTmNDZENjZFdhRi9iT0JGV1c1UTJEcUdqZWR6d3NqOU53?=
 =?utf-8?Q?CP08ARy8USfYTDx+OIXXAAgg0LgVZ2ItLWVaBiW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fd41a7-4efe-49f9-1a63-08d8ed9cefe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 01:42:36.6325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iO2qvIjF5wJv0o+Y42P88dqK6rBdn8JpBJZk5TJVrCBZiL2J7b5U1ozRbzTqLO7rzZKra/7xsFpn7JxmIddfOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
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
 Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
Sent: Monday, March 22, 2021 11:01 PM
To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amd/dispaly: fix deadlock issue in amdgpu reset



On 2021-03-22 4:11 a.m., Lang Yu wrote:
> In amdggpu reset, while dm.dc_lock is held by dm_suspend, 
> handle_hpd_rx_irq tries to acquire it. Deadlock occurred!
> 
> Deadlock log:
> 
> [  104.528304] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
> 
> [  104.640084] ======================================================
> [  104.640092] WARNING: possible circular locking dependency detected
> [  104.640099] 5.11.0-custom #1 Tainted: G        W   E
> [  104.640107] ------------------------------------------------------
> [  104.640114] cat/1158 is trying to acquire lock:
> [  104.640120] ffff88810a09ce00 
> ((work_completion)(&lh->work)){+.+.}-{0:0}, at: __flush_work+0x2e3/0x450 [  104.640144]
>                 but task is already holding lock:
> [  104.640151] ffff88810a09cc70 (&adev->dm.dc_lock){+.+.}-{3:3}, at: 
> dm_suspend+0xb2/0x1d0 [amdgpu] [  104.640581]
>                 which lock already depends on the new lock.
> 
> [  104.640590]
>                 the existing dependency chain (in reverse order) is:
> [  104.640598]
>                 -> #2 (&adev->dm.dc_lock){+.+.}-{3:3}:
> [  104.640611]        lock_acquire+0xca/0x390
> [  104.640623]        __mutex_lock+0x9b/0x930
> [  104.640633]        mutex_lock_nested+0x1b/0x20
> [  104.640640]        handle_hpd_rx_irq+0x9b/0x1c0 [amdgpu]
> [  104.640959]        dm_irq_work_func+0x4e/0x60 [amdgpu]
> [  104.641264]        process_one_work+0x2a7/0x5b0
> [  104.641275]        worker_thread+0x4a/0x3d0
> [  104.641283]        kthread+0x125/0x160
> [  104.641290]        ret_from_fork+0x22/0x30
> [  104.641300]
>                 -> #1 (&aconnector->hpd_lock){+.+.}-{3:3}:
> [  104.641312]        lock_acquire+0xca/0x390
> [  104.641321]        __mutex_lock+0x9b/0x930
> [  104.641328]        mutex_lock_nested+0x1b/0x20
> [  104.641336]        handle_hpd_rx_irq+0x67/0x1c0 [amdgpu]
> [  104.641635]        dm_irq_work_func+0x4e/0x60 [amdgpu]
> [  104.641931]        process_one_work+0x2a7/0x5b0
> [  104.641940]        worker_thread+0x4a/0x3d0
> [  104.641948]        kthread+0x125/0x160
> [  104.641954]        ret_from_fork+0x22/0x30
> [  104.641963]
>                 -> #0 ((work_completion)(&lh->work)){+.+.}-{0:0}:
> [  104.641975]        check_prev_add+0x94/0xbf0
> [  104.641983]        __lock_acquire+0x130d/0x1ce0
> [  104.641992]        lock_acquire+0xca/0x390
> [  104.642000]        __flush_work+0x303/0x450
> [  104.642008]        flush_work+0x10/0x20
> [  104.642016]        amdgpu_dm_irq_suspend+0x93/0x100 [amdgpu]
> [  104.642312]        dm_suspend+0x181/0x1d0 [amdgpu]
> [  104.642605]        amdgpu_device_ip_suspend_phase1+0x8a/0x100 [amdgpu]
> [  104.642835]        amdgpu_device_ip_suspend+0x21/0x70 [amdgpu]
> [  104.643066]        amdgpu_device_pre_asic_reset+0x1bd/0x1d2 [amdgpu]
> [  104.643403]        amdgpu_device_gpu_recover.cold+0x5df/0xa9d [amdgpu]
> [  104.643715]        gpu_recover_get+0x2e/0x60 [amdgpu]
> [  104.643951]        simple_attr_read+0x6d/0x110
> [  104.643960]        debugfs_attr_read+0x49/0x70
> [  104.643970]        full_proxy_read+0x5f/0x90
> [  104.643979]        vfs_read+0xa3/0x190
> [  104.643986]        ksys_read+0x70/0xf0
> [  104.643992]        __x64_sys_read+0x1a/0x20
> [  104.643999]        do_syscall_64+0x38/0x90
> [  104.644007]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  104.644017]
>                 other info that might help us debug this:
> 
> [  104.644026] Chain exists of:
>                   (work_completion)(&lh->work) --> 
> &aconnector->hpd_lock --> &adev->dm.dc_lock
> 
> [  104.644043]  Possible unsafe locking scenario:
> 
> [  104.644049]        CPU0                    CPU1
> [  104.644055]        ----                    ----
> [  104.644060]   lock(&adev->dm.dc_lock);
> [  104.644066]                                lock(&aconnector->hpd_lock);
> [  104.644075]                                lock(&adev->dm.dc_lock);
> [  104.644083]   lock((work_completion)(&lh->work));
> [  104.644090]
>                  *** DEADLOCK ***
> 
> [  104.644096] 3 locks held by cat/1158:
> [  104.644103]  #0: ffff88810d0e4eb8 (&attr->mutex){+.+.}-{3:3}, at: 
> simple_attr_read+0x4e/0x110 [  104.644119]  #1: ffff88810a0a1600 
> (&adev->reset_sem){++++}-{3:3}, at: amdgpu_device_lock_adev+0x42/0x94 
> [amdgpu] [  104.644489]  #2: ffff88810a09cc70 
> (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb2/0x1d0 [amdgpu]
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e176ea84d75b..8727488df769 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2657,13 +2657,15 @@ static void handle_hpd_rx_irq(void *param)
>   		}
>   	}
>   
> -	mutex_lock(&adev->dm.dc_lock);
> +	if (!amdgpu_in_reset(adev))
> +		mutex_lock(&adev->dm.dc_lock);
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>   	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
>   #else
>   	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
>   #endif
> -	mutex_unlock(&adev->dm.dc_lock);
> +	if (!amdgpu_in_reset(adev))
> +		mutex_unlock(&adev->dm.dc_lock);

Why is it ok to stop locking if in GPU reset ?

Andrey

If stopping locking in GPU reset, GPU reset works, though it's not safe.
If locking in GPU reset, deadlock occurred, GPU reset never works.
Display guys should give a perfect fix. It has been blocked for a long time, 
it's time to take some actions.  

Regards,
Lang
>   
>   out:
>   	if (result && !is_mst_root_connector) {
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
