Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0CCC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 22:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDDAD0AF4;
	Tue,  9 Aug 2022 22:00:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D211918BC8E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 22:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBIAn2mB+eSVIDWqxnwPhclqoO1XEXw476Z67HNwofbR9uPojIGtjxRT35KC/ZHX+6/zVXOb0Tvit2AieHSRFqK03JJU3V6As0AT6VITAVou0O9PUQ/X59ybyBG97PVXzCRi+KLU8ekGJaZeoUd25yEK3sgYM51rf+j8Ip3iVoCD+mQpA48m0ztObd9V828JaBdVwYNLUSHrCMV2SI/6zsQCr5Rf/+82ca1mNFvGhRTkPjrkDzAvs9A+AWH2fKZNO9Q9uE/YVb09J+59MXjQKj44D/Z5+ZRrDcGeA6X+ExLg7HVKpu45vQE4suD+FCICnoqP7Grobttj+34Tuihb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mERaDrhuLTvt9u3THcP2BvMuCVHIullciljisz/028Y=;
 b=Ez/Rb84YWkymvCTPrMOY9n4JcRuqjRjZ72tPCPgAE1SP1bhW3MvNx4AeqrrisKK4qN8jcSRW50rdw2lqQDJE5utRtCHPuByOgGSWKfpmXEItonGTh/6iJWCBiIbm7olzDII7RY/eMOxG/WTYx0J5Dlp9TUpdQHa/ZvwjNNnEEyM8Cg7LOHlAsB9jHzH0aK/2dQ3vN3bADMZD6VFfxB4kB92LzTCq0DCftXlkdB4Gcwj7r5V2H1pQ0+dI8rTYkjUu/Gv/FwuWrzmMS7vf/DlvIHqIYkjCkOQjzveZhk+7IFZHRbpzmpaHeqnyNpsvDLMJnbxHPLBIb6M4wzNSD+59Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mERaDrhuLTvt9u3THcP2BvMuCVHIullciljisz/028Y=;
 b=cv/kJZS3FHR2fBPxdlIF3Dp+usD0BhzieXplrj8bUAh9gee+jkWg08uWqW9g6mB35y0ncZGbMO4cNVbbCWJNAMkeZWDifzERrZiJ8ifVFcA/+9YXijUvfqYTqvGNc4l172I61IUr13QU7u+EYGKKlh3Ku7tV3zyLbDzNMm/fG80=
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 BYAPR12MB2630.namprd12.prod.outlook.com (2603:10b6:a03:67::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Tue, 9 Aug 2022 22:00:45 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::dca0:2dfb:b170:c475]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::dca0:2dfb:b170:c475%3]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 22:00:45 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Handle restart of kfd_ioctl_wait_events
Thread-Topic: [PATCH] drm/amdkfd: Handle restart of kfd_ioctl_wait_events
Thread-Index: AQHYqFG3JRHVNphatU+zIleUQg/Zmq2nJZ+Q
Date: Tue, 9 Aug 2022 22:00:45 +0000
Message-ID: <DM6PR12MB260213EEBCA25D011C0BEEABE3629@DM6PR12MB2602.namprd12.prod.outlook.com>
References: <20220804222901.134048-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220804222901.134048-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-09T22:00:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fe350ef4-20e6-4fde-a269-9f081bf95fa9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d98e342-eb48-40ef-2e8c-08da7a529c29
x-ms-traffictypediagnostic: BYAPR12MB2630:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hAg8xqNQyDBwpqGCQeHfOskCe/ohTVgoHW7jLn6+0guCIvkm7Oehp1iPkjPskI6BUnDHwQqTYLn2oHEWyHjyizD0hFlFn8vTptUUd5OFQZU6Ymk0XRl9nd8ZniBNRLzOr9fePhmpXnXNdHAkl80PkyEocaJQVhtIZc8Yi7WtwDWFBi7Ccw4x9JmkSu2ydckWGa+H713LKbao6hlwe8UWZqjndBmp611kw6t09XkOKSMwybTHhA6pgCMh1bSh/p91BEBNv/arHuyGZaJMyPTtAqV524fgp+30Sx/iS4w2mVfzL+oG3uk4CO3mLMr04oGp3EqilBbbqChWFXZxV5DL5yI8qp+xBlQiEtov/Scb6YUYXAYFv2zZy7KSTwKUkkonQl4+Gl3UV8Sz7/rMub69aGwhUmu0xsXqG7ukiucEQurJMspuvID6mGEJqY2UqoKIkVB7TI4TnKLKV6pfPPsMw+o1INBC8NEKf30+rE20vmFGWKNH0iG25xOSydoZBq6K0oza06EuHIacJBXO2WJX9oChzMdA8fZOjOJOwCAbJmPnlrk7mzoPfgMabSAGXE0H1KbjPRXw11ufaTXk0d7sbqAXVzNdwwLzEMsCp/QVFDR6K3+qBGaG+0bOqnu4zTn+GhAfVhzgeFcni0fiC5NUIW0zy4ZLxXOJjEuZTdvEB6xmg29Ga25yP9Z0/+PpRRLCQPxiQe4rhxO1VNWojgohtJDJh1OYZDPY6JVMxPEy8bhjUCcm9Pct0y+5Ue9dwbZlkSc5x0vYR6Mb/2IxSWhmAPXIkXURC5Z1xo3ZhnHf/gjHIxqoEwJpu/PsuSl9p6tt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(4326008)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(5660300002)(478600001)(110136005)(316002)(76116006)(2906002)(8936002)(52536014)(7696005)(41300700001)(53546011)(38070700005)(55016003)(33656002)(9686003)(26005)(6506007)(83380400001)(86362001)(38100700002)(122000001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lfjhh7ahZWDR8A01r3vJrLNoJuUuoM6ctSQg6cKF+C52j9dRmE5lLsnbpCKt?=
 =?us-ascii?Q?q7x9cgS7BwBmMII7S96d9HegN9Dd/EyM2QO5U8CB4XsSmivy3AvAjHuAmBxE?=
 =?us-ascii?Q?9Soh/+hehMmOuBwUJ/iw/6x0qZ1Gr6bW5N4vjeVcS97N6dSmSeReDids0UxM?=
 =?us-ascii?Q?frUVu9Q/01fko8Azy6xCsXSP0I9YsFWGG9LEEvFxcx4mh/5SvTBuAJ273820?=
 =?us-ascii?Q?1Z07WESDJPAQsX1nNwDgTPLMqMKm2XHViqAaJSDhLLM/9/o5G4YZ8O+oe++1?=
 =?us-ascii?Q?9u8JW5nueUaH/pmSlTrC8R6yP8CRKzbUL4QsNFqSPhOS5RdqJj57HL75A3t0?=
 =?us-ascii?Q?9mgkJeXgzB4wEwmJSPg17WSM23JkQTk6m4nCC14micEFFjhc/d+Jn1OCuZo/?=
 =?us-ascii?Q?bkLxKjrP2zP/Fs1PX5dFX9DTRJvfMMxShJzhZPxW5bMoQTj+iC4cZJng9OS/?=
 =?us-ascii?Q?uMkUIIt/TEM/EZ5MlaR9nKN1u3Hw0v+zpj+ogcdygPZ5sAnWrvKiNJGFscUs?=
 =?us-ascii?Q?iRp5MTQUqZGqJwS8RcbP2h/Ybhk0amasAsPLrpjuYHaR+oRHPCkWKOovMsqf?=
 =?us-ascii?Q?NV3rmw4xZIhutK8mZm9vQHC2seNDu9KQxN4GuE0dzm8L9JHSGpT6WZP/BTBJ?=
 =?us-ascii?Q?YEAqt8MdlXRCFfK1btdV0rksoiTM1QTvP13pNTQSKFb2zHf68Ufc3H5jyEsu?=
 =?us-ascii?Q?sueaIROftZVW2tofU9LVs8MnjlkU2KHO+/qrlCE2WmTtYiu4G/Ut+Unbv8c5?=
 =?us-ascii?Q?6CThfybC4aDmbIqMswxvhMyhRcr3oboXM1HtD7Yy9AHs0C5dKB823wuenteo?=
 =?us-ascii?Q?9AgLrwPZ+O5XPiEAv8MAoBK6J7ZitFvDFouwlZR/YX9NBBdk7itoh6sJKLkv?=
 =?us-ascii?Q?zjXeBqnLBUdIUJA8SCAvi5i+WomplwW0TnTcfZqfaXY66JNUluJQSC4W8/82?=
 =?us-ascii?Q?/Pox4QFIZkjS98pKdfRzLQPc7twJSexaUMBvyUOz7soNY6vMTdh9ec24x0kC?=
 =?us-ascii?Q?ScZcLl5gOXKUaP0UzCUb+DrD/T4UVICmWVdPMzwe40Kkk3O3lPG943I1B1t0?=
 =?us-ascii?Q?1rB7ToILd/5+uCmmXK+qL8ZpPnvJYHSsRb+xnO2rmGQbF8tOUKX5fMtz9hAE?=
 =?us-ascii?Q?2JUhzu8NF5sy7qsCtQVRlV6f5kUE+YDviRqXwNpZSV/2//Qokhqtv+dnB95N?=
 =?us-ascii?Q?abGN5xD6WpbvTikoF2VamGyfPD1gH8eccIaOB+mO5gk02LPt00W2kN2dnk2u?=
 =?us-ascii?Q?Bi4XZ9SvkSihVJe6ymLRB1XK4OTUnlxukdYU/G4/eZ6uFa8iR8wjd+PZjIRo?=
 =?us-ascii?Q?z7QbnVaLaaahdOf2lQG9Vu6Q+EoTGQiTrS3aQXh2VwIEYyBzg6LyHo2Xq/MI?=
 =?us-ascii?Q?1ekMrIXs4B4lgSkIq+Eg5W72x8a3MGXiyr1NwxLRcwuE6P4B2R5BAKkMCi0c?=
 =?us-ascii?Q?EX2Uc/0Mkpr2zD4jX731K9ljwxRCgdDoajkHnlkOAMpriEYqBsT1M38C5TnO?=
 =?us-ascii?Q?EU4MNwz18dwNztU9FAZ5ZPOWZjaJz+pNoe3JzY8nALAUWoMDFZX5CIbFTh2o?=
 =?us-ascii?Q?3vvbgH8mS5KPE6UE26c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d98e342-eb48-40ef-2e8c-08da7a529c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 22:00:45.1885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mksKN/7HPX9I6VqDOlnLFL4wngsLWc+b62ajajqDJOkJKEzN9scEC81bCQ3NlMYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2630
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
Cc: "Curtis, Nicholas" <Nicholas.Curtis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is:

Reviewed-and-Tested-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>=20
Sent: Thursday, August 4, 2022 5:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>; Curtis, Nicholas <Nicholas.Curt=
is@amd.com>
Subject: [PATCH] drm/amdkfd: Handle restart of kfd_ioctl_wait_events

When kfd_ioctl_wait_events needs to restart due to a signal, we need to upd=
ate the timeout to account for the time already elapsed. We also need to un=
do auto_reset of events that have signaled already, so that the restarted i=
octl will be able to count those signals again.

This fixes infinite hangs when kfd_ioctl_wait_events is interrupted by a si=
gnal.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-  drivers/gpu/drm/amd/amdk=
fd/kfd_events.c  | 24 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 907f4711abce..664e8b5d82c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -881,7 +881,7 @@ static int kfd_ioctl_wait_events(struct file *filp, str=
uct kfd_process *p,
 	err =3D kfd_wait_on_events(p, args->num_events,
 			(void __user *)args->events_ptr,
 			(args->wait_for_all !=3D 0),
-			args->timeout, &args->wait_result);
+			&args->timeout, &args->wait_result);
=20
 	return err;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 3942a56c28bb..83e3ce9f6049 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -894,7 +894,8 @@ static long user_timeout_to_jiffies(uint32_t user_timeo=
ut_ms)
 	return msecs_to_jiffies(user_timeout_ms) + 1;  }
=20
-static void free_waiters(uint32_t num_events, struct kfd_event_waiter *wai=
ters)
+static void free_waiters(uint32_t num_events, struct kfd_event_waiter *wai=
ters,
+			 bool undo_auto_reset)
 {
 	uint32_t i;
=20
@@ -903,6 +904,9 @@ static void free_waiters(uint32_t num_events, struct kf=
d_event_waiter *waiters)
 			spin_lock(&waiters[i].event->lock);
 			remove_wait_queue(&waiters[i].event->wq,
 					  &waiters[i].wait);
+			if (undo_auto_reset && waiters[i].activated &&
+			    waiters[i].event && waiters[i].event->auto_reset)
+				set_event(waiters[i].event);
 			spin_unlock(&waiters[i].event->lock);
 		}
=20
@@ -911,7 +915,7 @@ static void free_waiters(uint32_t num_events, struct kf=
d_event_waiter *waiters)
=20
 int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t num_events, void __user *data,
-		       bool all, uint32_t user_timeout_ms,
+		       bool all, uint32_t *user_timeout_ms,
 		       uint32_t *wait_result)
 {
 	struct kfd_event_data __user *events =3D @@ -920,7 +924,7 @@ int kfd_wait=
_on_events(struct kfd_process *p,
 	int ret =3D 0;
=20
 	struct kfd_event_waiter *event_waiters =3D NULL;
-	long timeout =3D user_timeout_to_jiffies(user_timeout_ms);
+	long timeout =3D user_timeout_to_jiffies(*user_timeout_ms);
=20
 	event_waiters =3D alloc_event_waiters(num_events);
 	if (!event_waiters) {
@@ -970,15 +974,11 @@ int kfd_wait_on_events(struct kfd_process *p,
 		}
=20
 		if (signal_pending(current)) {
-			/*
-			 * This is wrong when a nonzero, non-infinite timeout
-			 * is specified. We need to use
-			 * ERESTARTSYS_RESTARTBLOCK, but struct restart_block
-			 * contains a union with data for each user and it's
-			 * in generic kernel code that I don't want to
-			 * touch yet.
-			 */
 			ret =3D -ERESTARTSYS;
+			if (*user_timeout_ms !=3D KFD_EVENT_TIMEOUT_IMMEDIATE &&
+			    *user_timeout_ms !=3D KFD_EVENT_TIMEOUT_INFINITE)
+				*user_timeout_ms =3D jiffies_to_msecs(
+					max(0l, timeout-1));
 			break;
 		}
=20
@@ -1019,7 +1019,7 @@ int kfd_wait_on_events(struct kfd_process *p,
 					       event_waiters, events);
=20
 out_unlock:
-	free_waiters(num_events, event_waiters);
+	free_waiters(num_events, event_waiters, ret =3D=3D -ERESTARTSYS);
 	mutex_unlock(&p->event_mutex);
 out:
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index d03a3b9c9c5d..bf610e3b683b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1317,7 +1317,7 @@ void kfd_event_free_process(struct kfd_process *p);  =
int kfd_event_mmap(struct kfd_process *process, struct vm_area_struct *vma)=
;  int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t num_events, void __user *data,
-		       bool all, uint32_t user_timeout_ms,
+		       bool all, uint32_t *user_timeout_ms,
 		       uint32_t *wait_result);
 void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 				uint32_t valid_id_bits);
--
2.32.0
