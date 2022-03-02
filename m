Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C818C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 22:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C511310E715;
	Wed,  2 Mar 2022 22:53:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4157B10E5B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 22:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7WOh2H1gUakkL6wYcsgds9mXrL10iaeGFYcLCQGD+XNKE5is0ldELNPEJd9OVm5A2fC6pXhxqbOsJLB/r/bmP/aRxZK0FmQ1ZiDQzn03ylH8mhSK7/XZUpYgCUQJeqPTBUweCnMuHE6R249f70A1ie2Lp/l4G6KM1zRUM20PgU5edxgtm5i7WhMjBUBCLkQaCFGbdepZtm5W13OymdCMiFO3mq5gpjMXVQc2Y3kVzIVbMpc5x39vmMEx66DCu+R6BBZr9gMRhQB7eTgQvrxnw1aHLhDG7fhWhtMvTlcaOEQnLbBg8OXs6qNQWuUMAAMgvvu6j7ojRR7ZYZcFqXauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhnXXEhXclnfT72ArJDLjj3eTFD14sn6q+a8phvpRMY=;
 b=aOtAOa+5cd6QuGHzoxnILOM+13lbtcCn62DFXXkXTTk04V4vvbtBjRHLgFMRQnhM/RuY9u91w+Q8KxZmP4HAyy9+Dn0pOFHt7e+/i+wb26KfFwGDgdN3dTonelVhTeb/FMAxq2kwAyJqc7wt3h3EngM2/0yos6XCH0S2GLS5BvEV6X/xCF6Fxy7YsMgpzM5U5CfyyAZtefQ7FlQqQCzCytcrwtXLIzIQTCjnulzr3WrjPHjpUdrA75elCaipittGWioibINKHEYetJCNigpzJ6fPTnb9qHywJg+W+OO7fRHyg8sa4m2YMMFCL8pNvbh87ceVh+NcaJVtxAofSHvWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhnXXEhXclnfT72ArJDLjj3eTFD14sn6q+a8phvpRMY=;
 b=r/uX6cYeO2BkfL3Uf6jKzeA6/yfOMH6lPuHYnirpDSvuouj9NDHMgzfCGAEOhgIarMbGCziPWVrq126ApE1CN8ZSY9BBiZUgPGzmDOLs8WVpgmLMDv+QTl+JGv9YmFMBsTdULxJe4o0GzXjuPGrz7etLX/rhokK2AXkIWtIsbN4=
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Wed, 2 Mar
 2022 22:53:16 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::1c1:a8d2:800f:cb50]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::1c1:a8d2:800f:cb50%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 22:53:15 +0000
From: "Keely, Sean" <Sean.Keely@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Improve concurrency of event handling
Thread-Topic: [PATCH 1/1] drm/amdkfd: Improve concurrency of event handling
Thread-Index: AQHYLnEHwiB//XYauUiKbHAJ3Ex0Mayss41A
Date: Wed, 2 Mar 2022 22:53:15 +0000
Message-ID: <DM6PR12MB33554F21F36F0BB50B90B75E94039@DM6PR12MB3355.namprd12.prod.outlook.com>
References: <20220302200614.2439019-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220302200614.2439019-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=03fdebea-0901-4dce-8b41-5ed21eaf78a9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-02T22:52:39Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15fec924-2ea0-41e5-806b-08d9fc9f7012
x-ms-traffictypediagnostic: LV2PR12MB5773:EE_
x-microsoft-antispam-prvs: <LV2PR12MB577300196ABDB74D08AF092494039@LV2PR12MB5773.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zC2RPFEDaodjCtizTDUk71gT4IaIIvkZW9vEXjArfS/UedMZ4f6WW+R0EP8taMgUqibv34jZ0bZWmQr/VeiZ68UTfVPYq+Dqau7gWdesKOGvADXhsmOXd+SwnlAHc8akv4B5enWS8+Cu2C3BZVcqIdIF1xl3/FYSWPEfBAVya1/av4R7kGEaVHQkTEtwO82NUuTIaZ/UcwJI6jLJ3plWOnpM34ciz2Qc8aFownOXgonsUjAdDYjl/ewGCnbiZZfFmzfP/t5wJKaGaax6fmMtQQKLcdVcO/4vkFMVKudLrazyXK3V6LVgIjF0m1AUJ1YUob8EJJ3e3eUZNopx4IIHpOesiGJwJcl4EMALySBjQJ7avX5SDmkvvrqwTU/22snhA5SRVZjUyFUol8o2H3eWSi5YUKoD7Wn5cm0YizUE3hGwh41BzY7YRfuUZHgiRpZgA5S67z/VFux+/1HzGYY60wzTCd27FBdspbbI0VadiLV7U1im5PbZO8ylEZUVto2Ly/shQ+VoiMkBg5g9jgKvDEeId9TuEUn38y+/lbDma0SGyeJVaKpbepZsratTKQ2HOwPbAGTPaUKYodnkczPZS9meZCaic6exV8Lqvc/Nh4fP62BGr7fLyu9e0ZTg+cjOLhg+aOY+6JEEOVKPK32P+6VlST7uZ2uIN6QBNtVYux7xUngIk4eDC34n3t+XXGbJzntZdEJsjpT4zioUHBJLLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(55016003)(508600001)(8936002)(7696005)(52536014)(64756008)(66446008)(66476007)(66556008)(53546011)(76116006)(66946007)(8676002)(6506007)(5660300002)(186003)(122000001)(26005)(38100700002)(86362001)(33656002)(9686003)(83380400001)(38070700005)(316002)(2906002)(30864003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KWjK2rMS8sPpZOZZFuAq9j2oEDuU5/3VWhW1CFFi29j4fNYisB9XL/D2ECsx?=
 =?us-ascii?Q?8K3CPFz6IT0Nba0h/jJGLyXZptT0N0nHHp1IxP+eVGbmyTsw3BRllZ55iOLe?=
 =?us-ascii?Q?PVbAV5PFMkayeHHoX2iO8caC6wI3gIdx36xeByD8XM7Z7fro1OXVtKtc9vTb?=
 =?us-ascii?Q?qumHdHubRG2YDvbhl9ZIBkKPeDcVourqSZlLfqtYvwtbSCVlUQdssjozfmlF?=
 =?us-ascii?Q?6GWgRnqOq/Y2Hn58Wy+2fyvF5+imbT49LGsSlGqSDot2hcnQnwwJowltOP0L?=
 =?us-ascii?Q?R3eF2kgXfGuviKBAeNGhWQrmu0h63Kv33OX3a2ry/9tUOcS2SubRuLKVOSU/?=
 =?us-ascii?Q?1mBTj6yEMV4D1TJw30eMw40PTjyPML/jy/dNepDfwWDm6awmAiPu3wAq+h14?=
 =?us-ascii?Q?D59v1ZfEmbeUITagRWyyEbEi0qsmc9DdlUP4LXlTnGZSXS/nGEhhiwfnS5gl?=
 =?us-ascii?Q?LAP066K0h+YtNNtcaul1wUvHKEMTeR2KdMJ/5QaXk7bPvAsXw7QB/uTZA+Mv?=
 =?us-ascii?Q?/UZiPf1FyQBJkWh87trYdkShQMyxnedQ9AKeiWbaj/JRxQTl8LdWQ62qaVkd?=
 =?us-ascii?Q?CMN95ihBMA2M45NzytQnQpQGLPwY+hxWvnAnjHqDOTGRYHe2f+tA8DRoNUA7?=
 =?us-ascii?Q?iSjqD613WNkRt2L5XX2S3n8PJzPjWZTQHEGZz/aFZAcgdPr/IJivFsdBd1+9?=
 =?us-ascii?Q?faJ+CQPkMM/lts0o3x9djd27MINHZmphI+J62pP1FzUp0CnmW6tSzBoIhDT/?=
 =?us-ascii?Q?XqHizxnr/SD4q8zUNBebayLpCjTfHnswysaT2YL+Mo8nGlucP1goqEQtnGoC?=
 =?us-ascii?Q?lDMv4el6T60p2uEqEFCXuj9xdpH6+FwpcSMyp5rxV4aH/XDMEXDr2KZ7hT60?=
 =?us-ascii?Q?X9Te9C1kb7d260+w0cGsrwaLQ8ewuJfP3sSguw498Rw8t7W4278IPJc1ZHC0?=
 =?us-ascii?Q?BqOg1cupmNW5oT+T/gHbim4knXnxnamtyd0ncTj8m8oWBnP01W24euHq2tqw?=
 =?us-ascii?Q?CijrxblLMNVWF7Cy9fYgHvzeawmZMn4K29lpAdF2bsBR8ULR4mfx5DhibjfM?=
 =?us-ascii?Q?rOz2c+DZEKJHsdhp3Xyu4olRv8lZzip51v0/hjTkKH7yx3bUNp2x79KqqQN9?=
 =?us-ascii?Q?95lWbhD4usv78KzB8EYU5RzUTC/9bpHWd3q37qIgw8pgTVU01uCooy3Ef0py?=
 =?us-ascii?Q?bNUJfvy+kbaisR6aGOCCqLfG4zBBftTWDDlsczj2OXrhnwRfUV5XDa3BNhcB?=
 =?us-ascii?Q?crXhduxymWQiZ/XSRodFTkP50IdwUzqYsB5BCEwd4HI9rfCEOU5dnm/teMeO?=
 =?us-ascii?Q?dLgQz4ZjTSYPFHPlNOBbRll5BhO8LI4CoFeGmjfXAa0YaCCBg60KF8HTKwk8?=
 =?us-ascii?Q?2S29eYcsy+/M++JZQ0mEq3JdN6bHm/klOyhWWD+QGkox9MymtaA3ox3hZNwI?=
 =?us-ascii?Q?msnO8ZeWDnqPJcsplmzflKE8k8+rByh3H+mNcW886HTsY/gwQy41TWhcjEkO?=
 =?us-ascii?Q?lrKnfxI/Aq/0NMDg3wjwQ+1+rceATL3dexM2bQ+hC0C3IyLNynmyMz5odQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fec924-2ea0-41e5-806b-08d9fc9f7012
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 22:53:15.8958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ft5KwR429r7b3j0o+DiK5EwdBSr/t7uHYbwxF2rNTId3xiNB7NIm5NohMFqXyJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
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

[AMD Official Use Only]

LGTM.

Reviewed-by: Sean Keely <Sean.Keely@amd.com>

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, March 02, 2022 2:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Keely, Sean <Sean.Keely@amd.com>
Subject: [PATCH 1/1] drm/amdkfd: Improve concurrency of event handling

Use rcu_read_lock to read p->event_idr concurrently with other readers
and writers. Use p->event_mutex only for creating and destroying events
and in kfd_wait_on_events.

Protect the contents of the kfd_event structure with a per-event
spinlock that can be taken inside the rcu_read_lock critical section.

This eliminates contention of p->event_mutex in set_event, which tends
to be on the critical path for dispatch latency even when busy waiting
is used. It also eliminates lock contention in event interrupt handlers.
Since the p->event_mutex is now used much less, the impact of requiring
it in kfd_wait_on_events should also be much smaller.

This should improve event handling latency for processes using multiple
GPUs concurrently.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 119 +++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_events.h |   1 +
 2 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index deecccebe5b6..1726306715b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -128,8 +128,8 @@ static int allocate_event_notification_slot(struct kfd_=
process *p,
 }

 /*
- * Assumes that p->event_mutex is held and of course that p is not going
- * away (current or locked).
+ * Assumes that p->event_mutex or rcu_readlock is held and of course that =
p is
+ * not going away.
  */
 static struct kfd_event *lookup_event_by_id(struct kfd_process *p, uint32_=
t id)
 {
@@ -251,15 +251,18 @@ static void destroy_event(struct kfd_process *p, stru=
ct kfd_event *ev)
        struct kfd_event_waiter *waiter;

        /* Wake up pending waiters. They will return failure */
+       spin_lock(&ev->lock);
        list_for_each_entry(waiter, &ev->wq.head, wait.entry)
-               waiter->event =3D NULL;
+               WRITE_ONCE(waiter->event, NULL);
        wake_up_all(&ev->wq);
+       spin_unlock(&ev->lock);

        if (ev->type =3D=3D KFD_EVENT_TYPE_SIGNAL ||
            ev->type =3D=3D KFD_EVENT_TYPE_DEBUG)
                p->signal_event_count--;

        idr_remove(&p->event_idr, ev->event_id);
+       synchronize_rcu();
        kfree(ev);
 }

@@ -392,6 +395,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_pr=
ocess *p,
        ev->auto_reset =3D auto_reset;
        ev->signaled =3D false;

+       spin_lock_init(&ev->lock);
        init_waitqueue_head(&ev->wq);

        *event_page_offset =3D 0;
@@ -466,6 +470,7 @@ int kfd_criu_restore_event(struct file *devkfd,
        ev->auto_reset =3D ev_priv->auto_reset;
        ev->signaled =3D ev_priv->signaled;

+       spin_lock_init(&ev->lock);
        init_waitqueue_head(&ev->wq);

        mutex_lock(&p->event_mutex);
@@ -609,13 +614,13 @@ static void set_event(struct kfd_event *ev)

        /* Auto reset if the list is non-empty and we're waking
         * someone. waitqueue_active is safe here because we're
-        * protected by the p->event_mutex, which is also held when
+        * protected by the ev->lock, which is also held when
         * updating the wait queues in kfd_wait_on_events.
         */
        ev->signaled =3D !ev->auto_reset || !waitqueue_active(&ev->wq);

        list_for_each_entry(waiter, &ev->wq.head, wait.entry)
-               waiter->activated =3D true;
+               WRITE_ONCE(waiter->activated, true);

        wake_up_all(&ev->wq);
 }
@@ -626,16 +631,18 @@ int kfd_set_event(struct kfd_process *p, uint32_t eve=
nt_id)
        int ret =3D 0;
        struct kfd_event *ev;

-       mutex_lock(&p->event_mutex);
+       rcu_read_lock();

        ev =3D lookup_event_by_id(p, event_id);
+       spin_lock(&ev->lock);

        if (ev && event_can_be_cpu_signaled(ev))
                set_event(ev);
        else
                ret =3D -EINVAL;

-       mutex_unlock(&p->event_mutex);
+       spin_unlock(&ev->lock);
+       rcu_read_unlock();
        return ret;
 }

@@ -650,23 +657,25 @@ int kfd_reset_event(struct kfd_process *p, uint32_t e=
vent_id)
        int ret =3D 0;
        struct kfd_event *ev;

-       mutex_lock(&p->event_mutex);
+       rcu_read_lock();

        ev =3D lookup_event_by_id(p, event_id);
+       spin_lock(&ev->lock);

        if (ev && event_can_be_cpu_signaled(ev))
                reset_event(ev);
        else
                ret =3D -EINVAL;

-       mutex_unlock(&p->event_mutex);
+       spin_unlock(&ev->lock);
+       rcu_read_unlock();
        return ret;

 }

 static void acknowledge_signal(struct kfd_process *p, struct kfd_event *ev=
)
 {
-       page_slots(p->signal_page)[ev->event_id] =3D UNSIGNALED_EVENT_SLOT;
+       WRITE_ONCE(page_slots(p->signal_page)[ev->event_id], UNSIGNALED_EVE=
NT_SLOT);
 }

 static void set_event_from_interrupt(struct kfd_process *p,
@@ -674,7 +683,9 @@ static void set_event_from_interrupt(struct kfd_process=
 *p,
 {
        if (ev && event_can_be_gpu_signaled(ev)) {
                acknowledge_signal(p, ev);
+               spin_lock(&ev->lock);
                set_event(ev);
+               spin_unlock(&ev->lock);
        }
 }

@@ -693,7 +704,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t par=
tial_id,
        if (!p)
                return; /* Presumably process exited. */

-       mutex_lock(&p->event_mutex);
+       rcu_read_lock();

        if (valid_id_bits)
                ev =3D lookup_signaled_event_by_partial_id(p, partial_id,
@@ -721,7 +732,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t par=
tial_id,
                                if (id >=3D KFD_SIGNAL_EVENT_LIMIT)
                                        break;

-                               if (slots[id] !=3D UNSIGNALED_EVENT_SLOT)
+                               if (READ_ONCE(slots[id]) !=3D UNSIGNALED_EV=
ENT_SLOT)
                                        set_event_from_interrupt(p, ev);
                        }
                } else {
@@ -730,14 +741,14 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t p=
artial_id,
                         * only signaled events from the IDR.
                         */
                        for (id =3D 0; id < KFD_SIGNAL_EVENT_LIMIT; id++)
-                               if (slots[id] !=3D UNSIGNALED_EVENT_SLOT) {
+                               if (READ_ONCE(slots[id]) !=3D UNSIGNALED_EV=
ENT_SLOT) {
                                        ev =3D lookup_event_by_id(p, id);
                                        set_event_from_interrupt(p, ev);
                                }
                }
        }

-       mutex_unlock(&p->event_mutex);
+       rcu_read_unlock();
        kfd_unref_process(p);
 }

@@ -767,9 +778,11 @@ static int init_event_waiter_get_status(struct kfd_pro=
cess *p,
        if (!ev)
                return -EINVAL;

+       spin_lock(&ev->lock);
        waiter->event =3D ev;
        waiter->activated =3D ev->signaled;
        ev->signaled =3D ev->signaled && !ev->auto_reset;
+       spin_unlock(&ev->lock);

        return 0;
 }
@@ -781,8 +794,11 @@ static void init_event_waiter_add_to_waitlist(struct k=
fd_event_waiter *waiter)
        /* Only add to the wait list if we actually need to
         * wait on this event.
         */
-       if (!waiter->activated)
+       if (!waiter->activated) {
+               spin_lock(&ev->lock);
                add_wait_queue(&ev->wq, &waiter->wait);
+               spin_unlock(&ev->lock);
+       }
 }

 /* test_event_condition - Test condition of events being waited for
@@ -802,10 +818,10 @@ static uint32_t test_event_condition(bool all, uint32=
_t num_events,
        uint32_t activated_count =3D 0;

        for (i =3D 0; i < num_events; i++) {
-               if (!event_waiters[i].event)
+               if (!READ_ONCE(event_waiters[i].event))
                        return KFD_IOC_WAIT_RESULT_FAIL;

-               if (event_waiters[i].activated) {
+               if (READ_ONCE(event_waiters[i].activated)) {
                        if (!all)
                                return KFD_IOC_WAIT_RESULT_COMPLETE;

@@ -834,6 +850,8 @@ static int copy_signaled_event_data(uint32_t num_events=
,
        for (i =3D 0; i < num_events; i++) {
                waiter =3D &event_waiters[i];
                event =3D waiter->event;
+               if (!event)
+                       return -EINVAL; /* event was destroyed */
                if (waiter->activated && event->type =3D=3D KFD_EVENT_TYPE_=
MEMORY) {
                        dst =3D &data[i].memory_exception_data;
                        src =3D &event->memory_exception_data;
@@ -844,11 +862,8 @@ static int copy_signaled_event_data(uint32_t num_event=
s,
        }

        return 0;
-
 }

-
-
 static long user_timeout_to_jiffies(uint32_t user_timeout_ms)
 {
        if (user_timeout_ms =3D=3D KFD_EVENT_TIMEOUT_IMMEDIATE)
@@ -872,9 +887,12 @@ static void free_waiters(uint32_t num_events, struct k=
fd_event_waiter *waiters)
        uint32_t i;

        for (i =3D 0; i < num_events; i++)
-               if (waiters[i].event)
+               if (waiters[i].event) {
+                       spin_lock(&waiters[i].event->lock);
                        remove_wait_queue(&waiters[i].event->wq,
                                          &waiters[i].wait);
+                       spin_unlock(&waiters[i].event->lock);
+               }

        kfree(waiters);
 }
@@ -898,6 +916,9 @@ int kfd_wait_on_events(struct kfd_process *p,
                goto out;
        }

+       /* Use p->event_mutex here to protect against concurrent creation a=
nd
+        * destruction of events while we initialize event_waiters.
+        */
        mutex_lock(&p->event_mutex);

        for (i =3D 0; i < num_events; i++) {
@@ -976,14 +997,19 @@ int kfd_wait_on_events(struct kfd_process *p,
        }
        __set_current_state(TASK_RUNNING);

+       mutex_lock(&p->event_mutex);
        /* copy_signaled_event_data may sleep. So this has to happen
         * after the task state is set back to RUNNING.
+        *
+        * The event may also have been destroyed after signaling. So
+        * copy_signaled_event_data also must confirm that the event
+        * still exists. Therefore this must be under the p->event_mutex
+        * which is also held when events are destroyed.
         */
        if (!ret && *wait_result =3D=3D KFD_IOC_WAIT_RESULT_COMPLETE)
                ret =3D copy_signaled_event_data(num_events,
                                               event_waiters, events);

-       mutex_lock(&p->event_mutex);
 out_unlock:
        free_waiters(num_events, event_waiters);
        mutex_unlock(&p->event_mutex);
@@ -1042,8 +1068,7 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_a=
rea_struct *vma)
 }

 /*
- * Assumes that p->event_mutex is held and of course
- * that p is not going away (current or locked).
+ * Assumes that p is not going away.
  */
 static void lookup_events_by_type_and_signal(struct kfd_process *p,
                int type, void *event_data)
@@ -1055,6 +1080,8 @@ static void lookup_events_by_type_and_signal(struct k=
fd_process *p,

        ev_data =3D (struct kfd_hsa_memory_exception_data *) event_data;

+       rcu_read_lock();
+
        id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
        idr_for_each_entry_continue(&p->event_idr, ev, id)
                if (ev->type =3D=3D type) {
@@ -1062,9 +1089,11 @@ static void lookup_events_by_type_and_signal(struct =
kfd_process *p,
                        dev_dbg(kfd_device,
                                        "Event found: id %X type %d",
                                        ev->event_id, ev->type);
+                       spin_lock(&ev->lock);
                        set_event(ev);
                        if (ev->type =3D=3D KFD_EVENT_TYPE_MEMORY && ev_dat=
a)
                                ev->memory_exception_data =3D *ev_data;
+                       spin_unlock(&ev->lock);
                }

        if (type =3D=3D KFD_EVENT_TYPE_MEMORY) {
@@ -1087,6 +1116,8 @@ static void lookup_events_by_type_and_signal(struct k=
fd_process *p,
                                p->lead_thread->pid, p->pasid);
                }
        }
+
+       rcu_read_unlock();
 }

 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -1162,16 +1193,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u3=
2 pasid,

        if (KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 1, 0) &&
            KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 2, 2) &&
-           KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 3, 0)) {
-               mutex_lock(&p->event_mutex);
-
-               /* Lookup events by type and signal them */
+           KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 3, 0))
                lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_MEMORY,
                                &memory_exception_data);

-               mutex_unlock(&p->event_mutex);
-       }
-
        kfd_unref_process(p);
 }
 #endif /* KFD_SUPPORT_IOMMU_V2 */
@@ -1188,12 +1213,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
        if (!p)
                return; /* Presumably process exited. */

-       mutex_lock(&p->event_mutex);
-
-       /* Lookup events by type and signal them */
        lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_HW_EXCEPTION, NU=
LL);
-
-       mutex_unlock(&p->event_mutex);
        kfd_unref_process(p);
 }

@@ -1229,16 +1249,19 @@ void kfd_signal_vm_fault_event(struct kfd_dev *dev,=
 u32 pasid,
                        info->prot_write ? 1 : 0;
                memory_exception_data.failure.imprecise =3D 0;
        }
-       mutex_lock(&p->event_mutex);
+
+       rcu_read_lock();

        id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
        idr_for_each_entry_continue(&p->event_idr, ev, id)
                if (ev->type =3D=3D KFD_EVENT_TYPE_MEMORY) {
+                       spin_lock(&ev->lock);
                        ev->memory_exception_data =3D memory_exception_data=
;
                        set_event(ev);
+                       spin_unlock(&ev->lock);
                }

-       mutex_unlock(&p->event_mutex);
+       rcu_read_unlock();
        kfd_unref_process(p);
 }

@@ -1272,22 +1295,28 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
                        continue;
                }

-               mutex_lock(&p->event_mutex);
+               rcu_read_lock();
+
                id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
                idr_for_each_entry_continue(&p->event_idr, ev, id) {
                        if (ev->type =3D=3D KFD_EVENT_TYPE_HW_EXCEPTION) {
+                               spin_lock(&ev->lock);
                                ev->hw_exception_data =3D hw_exception_data=
;
                                ev->hw_exception_data.gpu_id =3D user_gpu_i=
d;
                                set_event(ev);
+                               spin_unlock(&ev->lock);
                        }
                        if (ev->type =3D=3D KFD_EVENT_TYPE_MEMORY &&
                            reset_cause =3D=3D KFD_HW_EXCEPTION_ECC) {
+                               spin_lock(&ev->lock);
                                ev->memory_exception_data =3D memory_except=
ion_data;
                                ev->memory_exception_data.gpu_id =3D user_g=
pu_id;
                                set_event(ev);
+                               spin_unlock(&ev->lock);
                        }
                }
-               mutex_unlock(&p->event_mutex);
+
+               rcu_read_unlock();
        }
        srcu_read_unlock(&kfd_processes_srcu, idx);
 }
@@ -1320,19 +1349,25 @@ void kfd_signal_poison_consumed_event(struct kfd_de=
v *dev, u32 pasid)
        memory_exception_data.gpu_id =3D user_gpu_id;
        memory_exception_data.failure.imprecise =3D true;

-       mutex_lock(&p->event_mutex);
+       rcu_read_lock();
+
        idr_for_each_entry_continue(&p->event_idr, ev, id) {
                if (ev->type =3D=3D KFD_EVENT_TYPE_HW_EXCEPTION) {
+                       spin_lock(&ev->lock);
                        ev->hw_exception_data =3D hw_exception_data;
                        set_event(ev);
+                       spin_unlock(&ev->lock);
                }

                if (ev->type =3D=3D KFD_EVENT_TYPE_MEMORY) {
+                       spin_lock(&ev->lock);
                        ev->memory_exception_data =3D memory_exception_data=
;
                        set_event(ev);
+                       spin_unlock(&ev->lock);
                }
        }
-       mutex_unlock(&p->event_mutex);
+
+       rcu_read_unlock();

        /* user application will handle SIGBUS signal */
        send_sig(SIGBUS, p->lead_thread, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.h
index 1238af11916e..55d376f56021 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -59,6 +59,7 @@ struct kfd_event {

        int type;

+       spinlock_t lock;
        wait_queue_head_t wq; /* List of event waiters. */

        /* Only for signal events. */
--
2.32.0

