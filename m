Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE762C7EE2F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 22:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F67C10E3DA;
	Tue,  6 Jun 2023 22:03:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9545410E3DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686088986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pb/BGxnfLhuAzVHhKGiRsyO/lDFJH+M1qeA6k554HB8=;
 b=ck0JP/7LComRSDKUqzASO35Yf21XIc4ZgJIoWUbRK+XyxIKxqO9LY8CW3l2EMzipMd7dLw
 t1oTSXSZrdSeYs06Q1QtLY8ueggz6FVy06E1qSwXm3KVzyM+4ZBUKh9fyqfVrt4cqTLN4o
 0g+HQx6eJDZ4K1Zq3e6fziVH/2ZJLus=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-6KLy1A0lPMaZgGFnYJTQ7Q-1; Tue, 06 Jun 2023 18:03:02 -0400
X-MC-Unique: 6KLy1A0lPMaZgGFnYJTQ7Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75ec7dedd93so122921185a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jun 2023 15:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686088982; x=1688680982;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVKUdzpCpVRlbxarpaUoo1QmcbnwUVepFks5Eg0Cjvk=;
 b=Rxi9nOiJMDxDlK1HcU7b700DSzO2riMom0zYZolgUrRH/TW6Ldmhfkm1Ne1kVJlxH5
 NUYqltWD2SqYDP19s3XH5jIgvPkShAA//GuYBOIg7oFQAv0IWj+LmbARY5myWHRcntTH
 fb7nf+u9HnIeNluogMBABok7nD9cM/YnkCrYOy9yXuUm4J6yHPEEZy8cwLqdkFaHdsHi
 xoKI4IB23iJB8wVnqSEX+lpBE9IuqkyipRQCf6hLjwFoP0MaJac9sWeDVrdQYmTuNrcM
 koycePRtcwBgiOSjFCp2YW/p4ubGFDdMO9OIqgmnHGbCYe2tIxC1IthFqyQDkQiUzDQ7
 Emcw==
X-Gm-Message-State: AC+VfDz61wfuu/0/Cu42gb/TbRPk8biG03+feh9uXvgAgasTA8yHCZbV
 nPDOR+hxa7fqPyCP1dyEWdCMVEEW/mdLWTtzm5sQMdBRaTvmC4zY01zbPIX9ywIU7Tjub4GXNHy
 7q96anDrKqncCHtPTNst43Typpw==
X-Received: by 2002:a37:aca:0:b0:75d:59e3:6aaf with SMTP id
 193-20020a370aca000000b0075d59e36aafmr1493780qkk.12.1686088981788; 
 Tue, 06 Jun 2023 15:03:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ764SGHWFkieA6gJEGBjk8hjnspoTeAuihudVSU8jkMkSEimoG9Fb7Z0bPMpmJUqw5bRWFmJg==
X-Received: by 2002:a37:aca:0:b0:75d:59e3:6aaf with SMTP id
 193-20020a370aca000000b0075d59e36aafmr1493748qkk.12.1686088981444; 
 Tue, 06 Jun 2023 15:03:01 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a05620a144800b0075b27186d9asm5191713qkl.106.2023.06.06.15.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 15:03:00 -0700 (PDT)
Message-ID: <6bdd1e1182e74fa1eddb823a2f8b813ec8028073.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Clear MSG_RDY flag before sending new message
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Date: Tue, 06 Jun 2023 18:02:59 -0400
In-Reply-To: <20230531040027.3457841-1-Wayne.Lin@amd.com>
References: <20230531040027.3457841-1-Wayne.Lin@amd.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: jani.nikula@intel.com, imre.deak@intel.com, stable@vger.kernel.org,
 jerry.zuo@amd.com, harry.wentland@amd.com, ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

My apologies for taking so long to reply to this. I'll be honest - the last
MST fiasco seriously burned me out big time, and I had to take a big step b=
ack
from working on MST for a while. Comments below

On Wed, 2023-05-31 at 12:00 +0800, Wayne Lin wrote:
> [Why]
> The sequence for collecting down_reply from source perspective should
> be:
>=20
> Request_n->repeat (get partial reply of Request_n->clear message ready
> flag to ack DPRX that the message is received) till all partial
> replies for Request_n are received->new Request_n+1.
>=20
> Now there is chance that drm_dp_mst_hpd_irq() will fire new down
> request in the tx queue when the down reply is incomplete. Source is
> restricted to generate interveleaved message transactions so we should
> avoid it.
>=20
> Also, while assembling partial reply packets, reading out DPCD DOWN_REP
> Sideband MSG buffer + clearing DOWN_REP_MSG_RDY flag should be
> wrapped up as a complete operation for reading out a reply packet.
> Kicking off a new request before clearing DOWN_REP_MSG_RDY flag might
> be risky. e.g. If the reply of the new request has overwritten the
> DPRX DOWN_REP Sideband MSG buffer before source writing one to clear
> DOWN_REP_MSG_RDY flag, source then unintentionally flushes the reply
> for the new request. Should handle the up request in the same way.
>=20
> [How]
> Separete drm_dp_mst_hpd_irq() into 2 steps. After acking the MST IRQ
> event, driver calls drm_dp_mst_hpd_irq_send_new_request() and might
> trigger drm_dp_mst_kick_tx() only when there is no on going message
> transaction.
>=20
> Changes since v1:
> * Reworked on review comments received
> -> Adjust the fix to let driver explicitly kick off new down request
> when mst irq event is handled and acked
> -> Adjust the commit message
>=20
> Changes since v2:
> * Adjust the commit message
> * Adjust the naming of the divided 2 functions and add a new input
>   parameter "ack".
> * Adjust code flow as per review comments.
>=20
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++-------
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 39 +++++++++++++++++--
>  drivers/gpu/drm/i915/display/intel_dp.c       |  7 ++--
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       | 12 ++++--
>  include/drm/display/drm_dp_mst_helper.h       |  7 +++-
>  5 files changed, 70 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d5cec03eaa8d..597c3368bcfb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3236,6 +3236,7 @@ static void dm_handle_mst_sideband_msg(struct amdgp=
u_dm_connector *aconnector)
>  {
>  =09u8 esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] =3D { 0 };
>  =09u8 dret;
> +=09u8 ack;
>  =09bool new_irq_handled =3D false;
>  =09int dpcd_addr;
>  =09int dpcd_bytes_to_read;
> @@ -3265,34 +3266,36 @@ static void dm_handle_mst_sideband_msg(struct amd=
gpu_dm_connector *aconnector)
>  =09=09process_count < max_process_count) {
>  =09=09u8 retry;
>  =09=09dret =3D 0;
> +=09=09ack =3D 0;
> =20
>  =09=09process_count++;
> =20
>  =09=09DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
>  =09=09/* handle HPD short pulse irq */
>  =09=09if (aconnector->mst_mgr.mst_state)
> -=09=09=09drm_dp_mst_hpd_irq(
> -=09=09=09=09&aconnector->mst_mgr,
> -=09=09=09=09esi,
> -=09=09=09=09&new_irq_handled);
> +=09=09=09drm_dp_mst_hpd_irq_handle_event(&aconnector->mst_mgr,
> +=09=09=09=09=09=09=09esi,
> +=09=09=09=09=09=09=09&ack,
> +=09=09=09=09=09=09=09&new_irq_handled);
> =20
>  =09=09if (new_irq_handled) {
>  =09=09=09/* ACK at DPCD to notify down stream */
> -=09=09=09const int ack_dpcd_bytes_to_write =3D
> -=09=09=09=09dpcd_bytes_to_read - 1;
> -
>  =09=09=09for (retry =3D 0; retry < 3; retry++) {
> -=09=09=09=09u8 wret;
> -
> -=09=09=09=09wret =3D drm_dp_dpcd_write(
> -=09=09=09=09=09&aconnector->dm_dp_aux.aux,
> -=09=09=09=09=09dpcd_addr + 1,
> -=09=09=09=09=09&esi[1],
> -=09=09=09=09=09ack_dpcd_bytes_to_write);
> -=09=09=09=09if (wret =3D=3D ack_dpcd_bytes_to_write)
> +=09=09=09=09ssize_t wret;
> +
> +=09=09=09=09wret =3D drm_dp_dpcd_writeb(&aconnector->dm_dp_aux.aux,
> +=09=09=09=09=09=09=09  dpcd_addr + 1,
> +=09=09=09=09=09=09=09  ack);
> +=09=09=09=09if (wret =3D=3D 1)
>  =09=09=09=09=09break;
>  =09=09=09}
> =20
> +=09=09=09if (retry =3D=3D 3) {
> +=09=09=09=09DRM_ERROR("Failed to ack MST event.\n");
> +=09=09=09=09return;
> +=09=09=09}
> +
> +=09=09=09drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
>  =09=09=09/* check if there is new irq to be handled */
>  =09=09=09dret =3D drm_dp_dpcd_read(
>  =09=09=09=09&aconnector->dm_dp_aux.aux,
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 38dab76ae69e..13165e764709 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4053,9 +4053,10 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_=
mst_topology_mgr *mgr)
>  }
> =20
>  /**
> - * drm_dp_mst_hpd_irq() - MST hotplug IRQ notify
> + * drm_dp_mst_hpd_irq_handle_event() - MST hotplug IRQ handle MST event
>   * @mgr: manager to notify irq for.
>   * @esi: 4 bytes from SINK_COUNT_ESI
> + * @ack: flags of events to ack
>   * @handled: whether the hpd interrupt was consumed or not
>   *
>   * This should be called from the driver when it detects a short IRQ,
> @@ -4063,7 +4064,8 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_m=
st_topology_mgr *mgr)
>   * topology manager will process the sideband messages received as a res=
ult
>   * of this.

We've gotta update the documentation here to reflect the changes being made=
.
Otherwise I think this looks good. Mind sending out a new version and I wil=
l
confirm this works on nouveau's side before giving an RB

(That might take a day or two, I accidentally discovered nouveau's MST supp=
ort
regressed a bit while I was away :( )

>   */
> -int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, boo=
l *handled)
> +int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr,=
 const u8 *esi,
> +=09=09=09=09    u8 *ack, bool *handled)
>  {
>  =09int ret =3D 0;
>  =09int sc;
> @@ -4078,18 +4080,47 @@ int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology=
_mgr *mgr, u8 *esi, bool *handl
>  =09if (esi[1] & DP_DOWN_REP_MSG_RDY) {
>  =09=09ret =3D drm_dp_mst_handle_down_rep(mgr);
>  =09=09*handled =3D true;
> +=09=09*ack |=3D DP_DOWN_REP_MSG_RDY;
>  =09}
> =20
>  =09if (esi[1] & DP_UP_REQ_MSG_RDY) {
>  =09=09ret |=3D drm_dp_mst_handle_up_req(mgr);
>  =09=09*handled =3D true;
> +=09=09*ack |=3D DP_UP_REQ_MSG_RDY;
>  =09}
> =20
> -=09drm_dp_mst_kick_tx(mgr);
>  =09return ret;
>  }
> -EXPORT_SYMBOL(drm_dp_mst_hpd_irq);
> +EXPORT_SYMBOL(drm_dp_mst_hpd_irq_handle_event);
> +
> +/**
> + * drm_dp_mst_hpd_irq_send_new_request() - MST hotplug IRQ kick off new =
request
> + * @mgr: manager to notify irq for.
> + *
> + * This should be called from the driver when mst irq event is handled
> + * and acked. Note that new down request should only be sent when
> + * previous message transaction is completed. Source is not supposed to =
generate
> + * interleaved message transactions.
> + */
> +void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr =
*mgr)
> +{
> +=09struct drm_dp_sideband_msg_tx *txmsg;
> +=09bool kick =3D true;
> =20
> +=09mutex_lock(&mgr->qlock);
> +=09txmsg =3D list_first_entry_or_null(&mgr->tx_msg_downq,
> +=09=09=09=09=09 struct drm_dp_sideband_msg_tx, next);
> +=09/* If last transaction is not completed yet*/
> +=09if (!txmsg ||
> +=09    txmsg->state =3D=3D DRM_DP_SIDEBAND_TX_START_SEND ||
> +=09    txmsg->state =3D=3D DRM_DP_SIDEBAND_TX_SENT)
> +=09=09kick =3D false;
> +=09mutex_unlock(&mgr->qlock);
> +
> +=09if (kick)
> +=09=09drm_dp_mst_kick_tx(mgr);
> +}
> +EXPORT_SYMBOL(drm_dp_mst_hpd_irq_send_new_request);
>  /**
>   * drm_dp_mst_detect_port() - get connection status for an MST port
>   * @connector: DRM connector for this port
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 4bec8cd7979f..f24602887015 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4062,9 +4062,7 @@ intel_dp_mst_hpd_irq(struct intel_dp *intel_dp, u8 =
*esi, u8 *ack)
>  {
>  =09bool handled =3D false;
> =20
> -=09drm_dp_mst_hpd_irq(&intel_dp->mst_mgr, esi, &handled);
> -=09if (handled)
> -=09=09ack[1] |=3D esi[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
> +=09drm_dp_mst_hpd_irq_handle_event(&intel_dp->mst_mgr, esi, &ack[1], &ha=
ndled);
> =20
>  =09if (esi[1] & DP_CP_IRQ) {
>  =09=09intel_hdcp_handle_cp_irq(intel_dp->attached_connector);
> @@ -4139,6 +4137,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp=
)
> =20
>  =09=09if (!intel_dp_ack_sink_irq_esi(intel_dp, ack))
>  =09=09=09drm_dbg_kms(&i915->drm, "Failed to ack ESI\n");
> +
> +=09=09if (ack[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY))
> +=09=09=09drm_dp_mst_hpd_irq_send_new_request(&intel_dp->mst_mgr);
>  =09}
> =20
>  =09return link_ok;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 9b6824f6b9e4..b2d9978e88a8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1357,6 +1357,7 @@ nv50_mstm_service(struct nouveau_drm *drm,
>  =09bool handled =3D true, ret =3D true;
>  =09int rc;
>  =09u8 esi[8] =3D {};
> +=09u8 ack;
> =20
>  =09while (handled) {
>  =09=09rc =3D drm_dp_dpcd_read(aux, DP_SINK_COUNT_ESI, esi, 8);
> @@ -1365,16 +1366,19 @@ nv50_mstm_service(struct nouveau_drm *drm,
>  =09=09=09break;
>  =09=09}
> =20
> -=09=09drm_dp_mst_hpd_irq(&mstm->mgr, esi, &handled);
> +=09=09ack =3D 0;
> +=09=09drm_dp_mst_hpd_irq_handle_event(&mstm->mgr, esi, &ack, &handled);
>  =09=09if (!handled)
>  =09=09=09break;
> =20
> -=09=09rc =3D drm_dp_dpcd_write(aux, DP_SINK_COUNT_ESI + 1, &esi[1],
> -=09=09=09=09       3);
> -=09=09if (rc !=3D 3) {
> +=09=09rc =3D drm_dp_dpcd_writeb(aux, DP_SINK_COUNT_ESI + 1, ack);
> +
> +=09=09if (rc !=3D 1) {
>  =09=09=09ret =3D false;
>  =09=09=09break;
>  =09=09}
> +
> +=09=09drm_dp_mst_hpd_irq_send_new_request(&mstm->mgr);
>  =09}
> =20
>  =09if (!ret)
> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/displa=
y/drm_dp_mst_helper.h
> index 32c764fb9cb5..40e855c8407c 100644
> --- a/include/drm/display/drm_dp_mst_helper.h
> +++ b/include/drm/display/drm_dp_mst_helper.h
> @@ -815,8 +815,11 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_m=
st_topology_mgr *mgr);
>  bool drm_dp_read_mst_cap(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIV=
ER_CAP_SIZE]);
>  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr,=
 bool mst_state);
> =20
> -int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, boo=
l *handled);
> -
> +int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr,
> +=09=09=09=09    const u8 *esi,
> +=09=09=09=09    u8 *ack,
> +=09=09=09=09    bool *handled);
> +void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr =
*mgr);
> =20
>  int
>  drm_dp_mst_detect_port(struct drm_connector *connector,

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

