Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB0C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C316124C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C316124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E517D6EB4B;
	Tue, 18 May 2021 12:20:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A716EB4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 12:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkG8qk23rFZwUPHTJSux0dWFzFN+rw6MryovpVkGl6fIRl4oKgWAYMOZ8lOuiw++rNjasqtXshMtgzqvxgzw5LuswwSNHK7wpEElC55zQy6EuiWWknT7w/Moktoy7HoUwr5rhICuuPW4TnWRro3dA8DeXDEF1d2IF+gMMtMMQIjEsDDouxRGshqTG13LkjVFB25Z6/HsEA6EUb89bilrsBte4SIlxQu+SvquosROre9iavVDcMZeLnAHZl2/0FmwcHERB4mqcj0HbfxFkWfiGiqzyTXq+OpnwlYMIbaT11jwKcKMGX/3KbMqBsO9wPUaIAY9l3qQxoJaiDEox2aJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBvLDRG4CNJzTeGttA18eRGUCEM0FNExpf3eubSFX9g=;
 b=a6FPff7SIIWk8/xqFvS58DQ0ArVoHsYyOEMw3WKsHt/+qszKg3XaPk2gWy1Lpzt4VoQneRFV9BvFcuiuRRMfFXrCkRWO6ixmNG0gFQn2buZvTSgFeGoMeqGAzwM0mpirBromN6WX5ERPgXg7wEzJpcVxIMJ5hShQdQaB53+liDZJ/8gsVIZet+IwYVBEj37JM85yFIRoW/8/loBrP3O09eObZjp1BIgjfLuqHMDxl069GQihY50Xk3JUa5D3oVUSxwb9jG4zDFkJbITIIkLbwXgWDZo8nizUSX+XQJexIyIqIZ9BNyridDmxzpWXWmAl3/fNWzWillXfjlXSthL+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBvLDRG4CNJzTeGttA18eRGUCEM0FNExpf3eubSFX9g=;
 b=MOKvMiiyAty2hClgqV6gKNwN4FRsm5b9XLKWR9eo/N1Bo05OY3+IFyHZUDhksLZm2bE8lviiXlb42eKN1WjF8RnZqffhoP4TsFe949tHKyu6Cf94ZPIZtTKq+nUUlQAF49SBoGzknJk0qfAXxXIyRy61WEvhh1WBi8OjHiwd4ko=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 12:20:39 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 12:20:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix a resource leakage issue
Thread-Topic: [PATCH] drm/amdkfd: fix a resource leakage issue
Thread-Index: AQHXS90v6dYWYgxN/EKJJexIbKfOVarpKInQ
Date: Tue, 18 May 2021 12:20:38 +0000
Message-ID: <BN9PR12MB53689594C25D85782A327531FC2C9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210518115845.13010-1-Dennis.Li@amd.com>
In-Reply-To: <20210518115845.13010-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-18T12:20:36Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7605f22b-6eb4-48c7-9083-ed642117582d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec028c62-3a04-420e-7249-08d919f7590c
x-ms-traffictypediagnostic: BN9PR12MB5082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB508207F711CE9CABA6AD298DFC2C9@BN9PR12MB5082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0trhWyuB27Za49+S9WplANSNa6h0hPESPQSksMgPrfgEauSWW8ZaSu+MGc8b9hw6hVCedq6La4U/EQ6E/9Av+P3Cz65p1ximXNb+GQkX5X6RUHQHqxOdX6T8C1Jwmb8SIrHpA1vT/1R0OB0yDBTqHfO6DSin9XiybkPJ/QkZqvbFHIH0x6ftAaUHcNw0bJ8dt1K/8W5cDHmPEKhXv2lAjyqTDaJF3pBuXG8w4Z8dbA3NbKO7pB0jYazSEJcqDJA1/nOoH2O3o4E1s1lRX2FZf+a9RfVRuZJJyxru1jD1iOV5k2IQEc+uqJwKlbuRYbluZ7WneRKFdb0r9lQKid/i5ten/tfMz4xNkA89YdzKWjaD3P1rbsEt3uFP7Yw8Bf+HBEWyKJsJPJVQ8a/Kwyksw/Z5zwZzQEJsgqSiQ0giRrKElp7ImBNKtnlqHXZP01pq2dHXSt9TkQIpdxjzyazN4LXay+8vXX6lvf9bCRi5o+3v62iDKCGsh0v++R8hLqDGr2fWYImObIzfRzSEEextJ1VphvC5frs4d3W3y0tISc4csM8rT3CGWlquRkkqUExVxvOiYhzcZywZxUz0YFrX3Vq2t5gZ2S9+0dLDV+SnBXc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39850400004)(110136005)(52536014)(71200400001)(7696005)(6636002)(122000001)(26005)(478600001)(2906002)(33656002)(8936002)(38100700002)(76116006)(86362001)(55016002)(66446008)(66946007)(4326008)(316002)(66476007)(83380400001)(66556008)(186003)(64756008)(5660300002)(6506007)(8676002)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HZwXAy+SLAs7w0rtAqwsENsixYrEKvcDaqK0IX8T2QnHEYs3LPNWxR9egrtv?=
 =?us-ascii?Q?LXBGJDVBoT1PrJAqffaIsup696dsJPnT8b+seznAc1VHu8mpAULAyGFxbGmh?=
 =?us-ascii?Q?M6iyX3YjJlOORUYcB4DfBtl8CWLmk3Ueo9h/hU8GOBZi7+PJSqaYimuFifQ+?=
 =?us-ascii?Q?/w7+AbK5PSi897MSnsGz0hAXd6YGz+z1JarPRMrc9H6qQaMQkY47NdB1No4g?=
 =?us-ascii?Q?N3iUo5XuFmWjNajfbfrrPDHBwOWHEvlW3Oh+kLI6tZEHRcbhgqLL6GLMEEAc?=
 =?us-ascii?Q?GwHDLm9G8RKEJcwmgjSkepkafOaKz+m7Ni4PHZ/yR+MW7gvfCa6N8PCowa7D?=
 =?us-ascii?Q?lodFMxQHTMcPCMGlH3IxOahJDGPGnyAzcaro5r5933x0OE7ob+3itSbV5gSp?=
 =?us-ascii?Q?FnjpIlIiXX+4B2UkNLadVhaKq3ly0jh7h4Tx4znDFSXo40TSLwAR/QW2C/V8?=
 =?us-ascii?Q?dsiSjOMTM49P2xRBHIjOvyyB7Nwl7/Hw3UAxnzo7YVXzcVhC3Yi3Nmz+1FCI?=
 =?us-ascii?Q?FKBsGmnrHhz7OMk8J4DEsK8veFALbAnJIpyD6a6J8+McQsQpBW84XcRsmohZ?=
 =?us-ascii?Q?5DszZ886G3/M7uiMZ7RKyRkDA9cu8J9oz3J6dYGLhrC3fd5lC+kbKBJGyqjY?=
 =?us-ascii?Q?GXrC3aO8si1gZYmeot4CwIjInMeDU7D4NJ5KUJtt7z3plTDaD09q7TFnV8ME?=
 =?us-ascii?Q?ETYSNKvftW7IIaYD4iqGZIvKEVI8T7d4xmn7rQ/znyEe6YCLC3PLzXJ/ir23?=
 =?us-ascii?Q?wuQL/qhG1x3jzrnoYewG39+EAvBFljkHtq3Gtl3yVInhbYxeAhfQAc7uyx/9?=
 =?us-ascii?Q?pciKimnVKQlXDxYMh/AH/2b30R7j94hONyAq4PwE6Qo6aDK3ttusNxJDqZaK?=
 =?us-ascii?Q?c+L6m2syOMoWTmHQw4zJ3zvrnnasXD0TearGCdR4VelLDp6zrqoDvbYQN05d?=
 =?us-ascii?Q?3zMPhpNjfjkmQsWzghYtQ8XVG3ecXyM8LCgEUrOMYuXEmNFZISqssxFt3tY7?=
 =?us-ascii?Q?X/+ryQOJ5wQfg2piYTdcLQgBidLNE/F6qkD62akIDIrHvrPcgQq43So8kKZp?=
 =?us-ascii?Q?f3zXS3Y0AKwlK/YH5BbxVOWd0FHImBjH8XN8GYfPKLVwnrACEEKyyfsCkcU7?=
 =?us-ascii?Q?AW2zk/cqN6dgDoh2FrV+Y4hL2TAmHB0GnPVawAOTkIZKuf4+gP1ChNewj3bF?=
 =?us-ascii?Q?hk+2OP/Z4jlTtnt1b/TfL+t/smnJNkpK+ybesdXDtRzQIRdHLblWkbQXiwGf?=
 =?us-ascii?Q?2Ehm/dMzlHTaVICdqUeDCOlU4QHJQ27vS5LKiw5r5L1Kw8UW4cl64sGOWFuJ?=
 =?us-ascii?Q?tzL2GTJoHbrNTaKoPUm62WQY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec028c62-3a04-420e-7249-08d919f7590c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 12:20:38.9209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1riLlZB1lF83eAZ3+o5uZL1Sm88WPi/0eb1hiaZwytwbk36PgFd0Yh+hC3Et9lgtIpVQ3OuJXkytpX2VELftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Tuesday, May 18, 2021 19:59
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdkfd: fix a resource leakage issue

The function kfd_lookup_process_by_pasid will increase the reference count of kfd_process object, its caller should call kfd_unref_process to decrease the reference count. Otherwise resource leakage will happen.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3c9fe078334a..6cc6afb96a45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1100,4 +1100,6 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
 
 	/* user application will handle SIGBUS signal */
 	send_sig(SIGBUS, p->lead_thread, 0);
+
+	kfd_unref_process(p);
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
