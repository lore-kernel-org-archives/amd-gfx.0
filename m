From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: reserve GDS resources statically
Date: Thu, 13 Sep 2018 18:57:15 +0000
Message-ID: <BN6PR12MB180977B44E93B5357C5145B3F71A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180912203358.2172-1-maraeo@gmail.com>
 <904d7dbb-eeec-03a0-92c8-5c5170a7b43c@gmail.com>
 <CAAxE2A44Brp==LORVMuKkU7o+O4wGiBEx7T8yYyMZd_b2uh6Tw@mail.gmail.com>
 <7db280c8-e013-6865-aef7-7c1d5640b875@amd.com>,
 <CAAxE2A64kojhUe+drdccAkSE4kTZP94OyMmG+xqH9wdDYgKATg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1886138055=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A64kojhUe+drdccAkSE4kTZP94OyMmG+xqH9wdDYgKATg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1886138055==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180977B44E93B5357C5145B3F71A0BN6PR12MB1809namp_"

--_000_BN6PR12MB180977B44E93B5357C5145B3F71A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Why don't we just fix up the current GDS code so it works the same as vram =
and then we can add a new CS or context flag to ignore the current static a=
llocation for gfx.  We can ignore data persistence if it's too much trouble=
.  Assume you always have to init the memory before you use it.  That's alr=
eady the case.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Marek Ol=
=9A=E1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, September 13, 2018 2:20:28 PM
To: Koenig, Christian
Cc: amd-gfx mailing list
Subject: Re: [PATCH] drm/amdgpu: reserve GDS resources statically

GDS is a temporary memory. Its purpose depends on the job, but most of
the time, the idea is:
- beginning of IB
- initialize GDS variables
- dispatch compute that works with GDS variables
- when done, copy GDS variables to memory
- repeat ...
- end of IB

GDS is like a pool of global shader GPRs.

GDS is too small for persistent data.

Marek

On Thu, Sep 13, 2018 at 1:26 PM, Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org> wrote:
> Are you sure of that? I mean it is rather pointless to have a Global Data
> Share when it can't be used to share anything?
>
> On the other hand I'm not opposed to get rid of all that stuff if we real=
ly
> don't need it.
>
> Christian.
>
> Am 13.09.2018 um 17:27 schrieb Marek Ol=9A=E1k:
>>
>> That's OK. We don't need IBs to get the same VMID.
>>
>> Marek
>>
>> On Thu, Sep 13, 2018 at 4:40 AM, Christian K=F6nig
>> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> As discussed internally that doesn't work because threads don't necessa=
ry
>>> get the same VMID assigned.
>>>
>>> Christian.
>>>
>>> Am 12.09.2018 um 22:33 schrieb Marek Ol=9A=E1k:
>>>>
>>>> From: Marek Ol=9A=E1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>>>>
>>>> I've chosen to do it like this because it's easy and allows an arbitra=
ry
>>>> number of processes.
>>>>
>>>> Signed-off-by: Marek Ol=9A=E1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  10 --
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  20 ----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h     |  19 +--
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  24 +---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c     |   6 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h     |   7 --
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  14 +--
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  21 ----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   6 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  61 ----------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   8 --
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  34 +-----
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       | 125
>>>> +++++---------------
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 123 +++++------------=
--
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 124 ++++++-----------=
--
>>>>    include/uapi/drm/amdgpu_drm.h               |  15 +--
>>>>    19 files changed, 109 insertions(+), 519 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>>> index b80243d3972e..7264a4930b88 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>>> @@ -71,23 +71,20 @@ int amdgpu_bo_list_create(struct amdgpu_device
>>>> *adev,
>>>> struct drm_file *filp,
>>>>                                  / sizeof(struct amdgpu_bo_list_entry)=
)
>>>>                  return -EINVAL;
>>>>          size =3D sizeof(struct amdgpu_bo_list);
>>>>          size +=3D num_entries * sizeof(struct amdgpu_bo_list_entry);
>>>>          list =3D kvmalloc(size, GFP_KERNEL);
>>>>          if (!list)
>>>>                  return -ENOMEM;
>>>>          kref_init(&list->refcount);
>>>> -       list->gds_obj =3D adev->gds.gds_gfx_bo;
>>>> -       list->gws_obj =3D adev->gds.gws_gfx_bo;
>>>> -       list->oa_obj =3D adev->gds.oa_gfx_bo;
>>>>          array =3D amdgpu_bo_list_array_entry(list, 0);
>>>>          memset(array, 0, num_entries * sizeof(struct
>>>> amdgpu_bo_list_entry));
>>>>          for (i =3D 0; i < num_entries; ++i) {
>>>>                  struct amdgpu_bo_list_entry *entry;
>>>>                  struct drm_gem_object *gobj;
>>>>                  struct amdgpu_bo *bo;
>>>>                  struct mm_struct *usermm;
>>>>    @@ -111,27 +108,20 @@ int amdgpu_bo_list_create(struct amdgpu_devic=
e
>>>> *adev, struct drm_file *filp,
>>>>                  } else {
>>>>                          entry =3D &array[last_entry++];
>>>>                  }
>>>>                  entry->robj =3D bo;
>>>>                  entry->priority =3D min(info[i].bo_priority,
>>>>                                        AMDGPU_BO_LIST_MAX_PRIORITY);
>>>>                  entry->tv.bo =3D &entry->robj->tbo;
>>>>                  entry->tv.shared =3D !entry->robj->prime_shared_count=
;
>>>>    -             if (entry->robj->preferred_domains =3D=3D
>>>> AMDGPU_GEM_DOMAIN_GDS)
>>>> -                       list->gds_obj =3D entry->robj;
>>>> -               if (entry->robj->preferred_domains =3D=3D
>>>> AMDGPU_GEM_DOMAIN_GWS)
>>>> -                       list->gws_obj =3D entry->robj;
>>>> -               if (entry->robj->preferred_domains =3D=3D
>>>> AMDGPU_GEM_DOMAIN_OA)
>>>> -                       list->oa_obj =3D entry->robj;
>>>> -
>>>>                  total_size +=3D amdgpu_bo_size(entry->robj);
>>>>                  trace_amdgpu_bo_list_set(list, entry->robj);
>>>>          }
>>>>          list->first_userptr =3D first_userptr;
>>>>          list->num_entries =3D num_entries;
>>>>          trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>>>>          *result =3D list;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>>> index 61b089768e1c..30f12a60aa28 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>>> @@ -36,23 +36,20 @@ struct amdgpu_bo_list_entry {
>>>>          struct ttm_validate_buffer      tv;
>>>>          struct amdgpu_bo_va             *bo_va;
>>>>          uint32_t                        priority;
>>>>          struct page                     **user_pages;
>>>>          int                             user_invalidated;
>>>>    };
>>>>      struct amdgpu_bo_list {
>>>>          struct rcu_head rhead;
>>>>          struct kref refcount;
>>>> -       struct amdgpu_bo *gds_obj;
>>>> -       struct amdgpu_bo *gws_obj;
>>>> -       struct amdgpu_bo *oa_obj;
>>>>          unsigned first_userptr;
>>>>          unsigned num_entries;
>>>>    };
>>>>      int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
>>>>                         struct amdgpu_bo_list **result);
>>>>    void amdgpu_bo_list_get_list(struct amdgpu_bo_list *list,
>>>>                               struct list_head *validated);
>>>>    void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
>>>>    int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in
>>>> *in,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index 1081fd00b059..88b58facf29e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -565,23 +565,20 @@ static int amdgpu_cs_list_validate(struct
>>>> amdgpu_cs_parser *p,
>>>>          return 0;
>>>>    }
>>>>      static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>>>                                  union drm_amdgpu_cs *cs)
>>>>    {
>>>>          struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
>>>>          struct amdgpu_vm *vm =3D &fpriv->vm;
>>>>          struct amdgpu_bo_list_entry *e;
>>>>          struct list_head duplicates;
>>>> -       struct amdgpu_bo *gds;
>>>> -       struct amdgpu_bo *gws;
>>>> -       struct amdgpu_bo *oa;
>>>>          unsigned tries =3D 10;
>>>>          int r;
>>>>          INIT_LIST_HEAD(&p->validated);
>>>>          /* p->bo_list could already be assigned if
>>>> AMDGPU_CHUNK_ID_BO_HANDLES is present */
>>>>          if (cs->in.bo_list_handle) {
>>>>                  if (p->bo_list)
>>>>                          return -EINVAL;
>>>>    @@ -705,40 +702,23 @@ static int amdgpu_cs_parser_bos(struct
>>>> amdgpu_cs_parser *p,
>>>>          r =3D amdgpu_cs_list_validate(p, &p->validated);
>>>>          if (r) {
>>>>                  DRM_ERROR("amdgpu_cs_list_validate(validated)
>>>> failed.\n");
>>>>                  goto error_validate;
>>>>          }
>>>>          amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>>>>                                       p->bytes_moved_vis);
>>>>    -     gds =3D p->bo_list->gds_obj;
>>>> -       gws =3D p->bo_list->gws_obj;
>>>> -       oa =3D p->bo_list->oa_obj;
>>>> -
>>>>          amdgpu_bo_list_for_each_entry(e, p->bo_list)
>>>>                  e->bo_va =3D amdgpu_vm_bo_find(vm, e->robj);
>>>>    -     if (gds) {
>>>> -               p->job->gds_base =3D amdgpu_bo_gpu_offset(gds);
>>>> -               p->job->gds_size =3D amdgpu_bo_size(gds);
>>>> -       }
>>>> -       if (gws) {
>>>> -               p->job->gws_base =3D amdgpu_bo_gpu_offset(gws);
>>>> -               p->job->gws_size =3D amdgpu_bo_size(gws);
>>>> -       }
>>>> -       if (oa) {
>>>> -               p->job->oa_base =3D amdgpu_bo_gpu_offset(oa);
>>>> -               p->job->oa_size =3D amdgpu_bo_size(oa);
>>>> -       }
>>>> -
>>>>          if (!r && p->uf_entry.robj) {
>>>>                  struct amdgpu_bo *uf =3D p->uf_entry.robj;
>>>>                  r =3D amdgpu_ttm_alloc_gart(&uf->tbo);
>>>>                  p->job->uf_addr +=3D amdgpu_bo_gpu_offset(uf);
>>>>          }
>>>>      error_validate:
>>>>          if (r)
>>>>                  ttm_eu_backoff_reservation(&p->ticket, &p->validated)=
;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>>>> index e73728d90388..69ba25c2e921 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
>>>> @@ -17,48 +17,33 @@
>>>>     * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>>> DAMAGES
>>>> OR
>>>>     * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>> OTHERWISE,
>>>>     * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE U=
SE
>>>> OR
>>>>     * OTHER DEALINGS IN THE SOFTWARE.
>>>>     *
>>>>     */
>>>>      #ifndef __AMDGPU_GDS_H__
>>>>    #define __AMDGPU_GDS_H__
>>>>    -/* Because TTM request that alloacted buffer should be PAGE_SIZE
>>>> aligned,
>>>> - * we should report GDS/GWS/OA size as PAGE_SIZE aligned
>>>> - * */
>>>> -#define AMDGPU_GDS_SHIFT       2
>>>> -#define AMDGPU_GWS_SHIFT       PAGE_SHIFT
>>>> -#define AMDGPU_OA_SHIFT                PAGE_SHIFT
>>>> -
>>>>    struct amdgpu_ring;
>>>>    struct amdgpu_bo;
>>>>      struct amdgpu_gds_asic_info {
>>>>          uint32_t        total_size;
>>>> -       uint32_t        gfx_partition_size;
>>>> -       uint32_t        cs_partition_size;
>>>> +       uint32_t        gfx_size_per_vmid;
>>>> +       uint32_t        kfd_size_per_vmid;
>>>>    };
>>>>      struct amdgpu_gds {
>>>>          struct amdgpu_gds_asic_info     mem;
>>>>          struct amdgpu_gds_asic_info     gws;
>>>>          struct amdgpu_gds_asic_info     oa;
>>>> -       /* At present, GDS, GWS and OA resources for gfx (graphics)
>>>> -        * is always pre-allocated and available for graphics operatio=
n.
>>>> -        * Such resource is shared between all gfx clients.
>>>> -        * TODO: move this operation to user space
>>>> -        * */
>>>> -       struct amdgpu_bo*               gds_gfx_bo;
>>>> -       struct amdgpu_bo*               gws_gfx_bo;
>>>> -       struct amdgpu_bo*               oa_gfx_bo;
>>>>    };
>>>>      struct amdgpu_gds_reg_offset {
>>>>          uint32_t        mem_base;
>>>>          uint32_t        mem_size;
>>>>          uint32_t        gws;
>>>>          uint32_t        oa;
>>>>    };
>>>>      #endif /* __AMDGPU_GDS_H__ */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> index d30a0838851b..c87ad4b4d0b6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> @@ -223,43 +223,25 @@ int amdgpu_gem_create_ioctl(struct drm_device
>>>> *dev,
>>>> void *data,
>>>>          if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>                        AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>>>>                        AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>>>>                        AMDGPU_GEM_CREATE_VRAM_CLEARED |
>>>>                        AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>>>>                        AMDGPU_GEM_CREATE_EXPLICIT_SYNC))
>>>>                  return -EINVAL;
>>>>          /* reject invalid gem domains */
>>>> -       if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>>>> +       if (args->in.domains & ~(AMDGPU_GEM_DOMAIN_CPU |
>>>> +                                AMDGPU_GEM_DOMAIN_GTT |
>>>> +                                AMDGPU_GEM_DOMAIN_VRAM))
>>>>                  return -EINVAL;
>>>>    -     /* create a gem object to contain this object in */
>>>> -       if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>>>> -           AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
>>>> -               if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>>>> -                       /* if gds bo is created from user space, it mu=
st
>>>> be
>>>> -                        * passed to bo list
>>>> -                        */
>>>> -                       DRM_ERROR("GDS bo cannot be per-vm-bo\n");
>>>> -                       return -EINVAL;
>>>> -               }
>>>> -               flags |=3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>>>> -               if (args->in.domains =3D=3D AMDGPU_GEM_DOMAIN_GDS)
>>>> -                       size =3D size << AMDGPU_GDS_SHIFT;
>>>> -               else if (args->in.domains =3D=3D AMDGPU_GEM_DOMAIN_GWS=
)
>>>> -                       size =3D size << AMDGPU_GWS_SHIFT;
>>>> -               else if (args->in.domains =3D=3D AMDGPU_GEM_DOMAIN_OA)
>>>> -                       size =3D size << AMDGPU_OA_SHIFT;
>>>> -               else
>>>> -                       return -EINVAL;
>>>> -       }
>>>>          size =3D roundup(size, PAGE_SIZE);
>>>>          if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>>>>                  r =3D amdgpu_bo_reserve(vm->root.base.bo, false);
>>>>                  if (r)
>>>>                          return r;
>>>>                  resv =3D vm->root.base.bo->tbo.resv;
>>>>          }
>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> index 3a072a7a39f0..c2e6a1a11d7f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> @@ -516,26 +516,20 @@ void amdgpu_vmid_free_reserved(struct
>>>> amdgpu_device
>>>> *adev,
>>>>     * Reset saved GDW, GWS and OA to force switch on next flush.
>>>>     */
>>>>    void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
>>>>                         unsigned vmid)
>>>>    {
>>>>          struct amdgpu_vmid_mgr *id_mgr =3D
>>>> &adev->vm_manager.id_mgr[vmhub];
>>>>          struct amdgpu_vmid *id =3D &id_mgr->ids[vmid];
>>>>          mutex_lock(&id_mgr->lock);
>>>>          id->owner =3D 0;
>>>> -       id->gds_base =3D 0;
>>>> -       id->gds_size =3D 0;
>>>> -       id->gws_base =3D 0;
>>>> -       id->gws_size =3D 0;
>>>> -       id->oa_base =3D 0;
>>>> -       id->oa_size =3D 0;
>>>>          mutex_unlock(&id_mgr->lock);
>>>>    }
>>>>      /**
>>>>     * amdgpu_vmid_reset_all - reset VMID to zero
>>>>     *
>>>>     * @adev: amdgpu device structure
>>>>     *
>>>>     * Reset VMID to force flush on next use
>>>>     */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>>>> index 7625419f0fc2..06078e665532 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>>>> @@ -44,27 +44,20 @@ struct amdgpu_vmid {
>>>>          struct amdgpu_sync      active;
>>>>          struct dma_fence        *last_flush;
>>>>          uint64_t                owner;
>>>>          uint64_t                pd_gpu_addr;
>>>>          /* last flushed PD/PT update */
>>>>          struct dma_fence        *flushed_updates;
>>>>          uint32_t                current_gpu_reset_count;
>>>>    -     uint32_t                gds_base;
>>>> -       uint32_t                gds_size;
>>>> -       uint32_t                gws_base;
>>>> -       uint32_t                gws_size;
>>>> -       uint32_t                oa_base;
>>>> -       uint32_t                oa_size;
>>>> -
>>>>          unsigned                pasid;
>>>>          struct dma_fence        *pasid_mapping;
>>>>    };
>>>>      struct amdgpu_vmid_mgr {
>>>>          struct mutex            lock;
>>>>          unsigned                num_ids;
>>>>          struct list_head        ids_lru;
>>>>          struct amdgpu_vmid      ids[AMDGPU_NUM_VMID];
>>>>          atomic_t                reserved_vmid_num;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> index 57cfe78a262b..3db553f6ad01 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> @@ -42,23 +42,20 @@ struct amdgpu_job {
>>>>          struct amdgpu_sync      sched_sync;
>>>>          struct amdgpu_ib        *ibs;
>>>>          struct dma_fence        *fence; /* the hw fence */
>>>>          uint32_t                preamble_status;
>>>>          uint32_t                num_ibs;
>>>>          void                    *owner;
>>>>          bool                    vm_needs_flush;
>>>>          uint64_t                vm_pd_addr;
>>>>          unsigned                vmid;
>>>>          unsigned                pasid;
>>>> -       uint32_t                gds_base, gds_size;
>>>> -       uint32_t                gws_base, gws_size;
>>>> -       uint32_t                oa_base, oa_size;
>>>>          uint32_t                vram_lost_counter;
>>>>          /* user fence handling */
>>>>          uint64_t                uf_addr;
>>>>          uint64_t                uf_sequence;
>>>>      };
>>>>      int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs=
,
>>>>                       struct amdgpu_job **job, struct amdgpu_vm *vm);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index 29ac3873eeb0..209954290954 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -517,27 +517,27 @@ static int amdgpu_info_ioctl(struct drm_device
>>>> *dev,
>>>> void *data, struct drm_file
>>>>          case AMDGPU_INFO_VIS_VRAM_USAGE:
>>>>                  ui64 =3D
>>>> amdgpu_vram_mgr_vis_usage(&adev->mman.bdev.man[TTM_PL_VRAM]);
>>>>                  return copy_to_user(out, &ui64, min(size, 8u)) ?
>>>> -EFAULT :
>>>> 0;
>>>>          case AMDGPU_INFO_GTT_USAGE:
>>>>                  ui64 =3D
>>>> amdgpu_gtt_mgr_usage(&adev->mman.bdev.man[TTM_PL_TT]);
>>>>                  return copy_to_user(out, &ui64, min(size, 8u)) ?
>>>> -EFAULT :
>>>> 0;
>>>>          case AMDGPU_INFO_GDS_CONFIG: {
>>>>                  struct drm_amdgpu_info_gds gds_info;
>>>>                  memset(&gds_info, 0, sizeof(gds_info));
>>>> -               gds_info.gds_gfx_partition_size =3D
>>>> adev->gds.mem.gfx_partition_size >> AMDGPU_GDS_SHIFT;
>>>> -               gds_info.compute_partition_size =3D
>>>> adev->gds.mem.cs_partition_size >> AMDGPU_GDS_SHIFT;
>>>> -               gds_info.gds_total_size =3D adev->gds.mem.total_size >=
>
>>>> AMDGPU_GDS_SHIFT;
>>>> -               gds_info.gws_per_gfx_partition =3D
>>>> adev->gds.gws.gfx_partition_size >> AMDGPU_GWS_SHIFT;
>>>> -               gds_info.gws_per_compute_partition =3D
>>>> adev->gds.gws.cs_partition_size >> AMDGPU_GWS_SHIFT;
>>>> -               gds_info.oa_per_gfx_partition =3D
>>>> adev->gds.oa.gfx_partition_size >> AMDGPU_OA_SHIFT;
>>>> -               gds_info.oa_per_compute_partition =3D
>>>> adev->gds.oa.cs_partition_size >> AMDGPU_OA_SHIFT;
>>>> +               gds_info.gds_gfx_partition_size =3D
>>>> adev->gds.mem.gfx_size_per_vmid;
>>>> +               gds_info.compute_partition_size =3D
>>>> adev->gds.mem.kfd_size_per_vmid;
>>>> +               gds_info.gds_total_size =3D adev->gds.mem.total_size;
>>>> +               gds_info.gws_per_gfx_partition =3D
>>>> adev->gds.gws.gfx_size_per_vmid;
>>>> +               gds_info.gws_per_compute_partition =3D
>>>> adev->gds.gws.kfd_size_per_vmid;
>>>> +               gds_info.oa_per_gfx_partition =3D
>>>> adev->gds.oa.gfx_size_per_vmid;
>>>> +               gds_info.oa_per_compute_partition =3D
>>>> adev->gds.oa.kfd_size_per_vmid;
>>>>                  return copy_to_user(out, &gds_info,
>>>>                                      min((size_t)size,
>>>> sizeof(gds_info))) ?
>>>> -EFAULT : 0;
>>>>          }
>>>>          case AMDGPU_INFO_VRAM_GTT: {
>>>>                  struct drm_amdgpu_info_vram_gtt vram_gtt;
>>>>                  vram_gtt.vram_size =3D adev->gmc.real_vram_size -
>>>>                          atomic64_read(&adev->vram_pin_size);
>>>>                  vram_gtt.vram_cpu_accessible_size =3D
>>>> adev->gmc.visible_vram_size -
>>>>                          atomic64_read(&adev->visible_pin_size);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index de990bdcdd6c..76770a8c29a5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -178,41 +178,20 @@ void amdgpu_bo_placement_from_domain(struct
>>>> amdgpu_bo *abo, u32 domain)
>>>>                  places[c].lpfn =3D 0;
>>>>                  places[c].flags =3D TTM_PL_FLAG_SYSTEM;
>>>>                  if (flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
>>>>                          places[c].flags |=3D TTM_PL_FLAG_WC |
>>>>                                  TTM_PL_FLAG_UNCACHED;
>>>>                  else
>>>>                          places[c].flags |=3D TTM_PL_FLAG_CACHED;
>>>>                  c++;
>>>>          }
>>>>    -     if (domain & AMDGPU_GEM_DOMAIN_GDS) {
>>>> -               places[c].fpfn =3D 0;
>>>> -               places[c].lpfn =3D 0;
>>>> -               places[c].flags =3D TTM_PL_FLAG_UNCACHED |
>>>> AMDGPU_PL_FLAG_GDS;
>>>> -               c++;
>>>> -       }
>>>> -
>>>> -       if (domain & AMDGPU_GEM_DOMAIN_GWS) {
>>>> -               places[c].fpfn =3D 0;
>>>> -               places[c].lpfn =3D 0;
>>>> -               places[c].flags =3D TTM_PL_FLAG_UNCACHED |
>>>> AMDGPU_PL_FLAG_GWS;
>>>> -               c++;
>>>> -       }
>>>> -
>>>> -       if (domain & AMDGPU_GEM_DOMAIN_OA) {
>>>> -               places[c].fpfn =3D 0;
>>>> -               places[c].lpfn =3D 0;
>>>> -               places[c].flags =3D TTM_PL_FLAG_UNCACHED |
>>>> AMDGPU_PL_FLAG_OA;
>>>> -               c++;
>>>> -       }
>>>> -
>>>>          if (!c) {
>>>>                  places[c].fpfn =3D 0;
>>>>                  places[c].lpfn =3D 0;
>>>>                  places[c].flags =3D TTM_PL_MASK_CACHING |
>>>> TTM_PL_FLAG_SYSTEM;
>>>>                  c++;
>>>>          }
>>>>          BUG_ON(c >=3D AMDGPU_BO_MAX_PLACEMENTS);
>>>>          placement->num_placement =3D c;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> index 907fdf46d895..e089964cbcb7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> @@ -120,26 +120,20 @@ static inline struct amdgpu_bo
>>>> *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>>>>     */
>>>>    static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
>>>>    {
>>>>          switch (mem_type) {
>>>>          case TTM_PL_VRAM:
>>>>                  return AMDGPU_GEM_DOMAIN_VRAM;
>>>>          case TTM_PL_TT:
>>>>                  return AMDGPU_GEM_DOMAIN_GTT;
>>>>          case TTM_PL_SYSTEM:
>>>>                  return AMDGPU_GEM_DOMAIN_CPU;
>>>> -       case AMDGPU_PL_GDS:
>>>> -               return AMDGPU_GEM_DOMAIN_GDS;
>>>> -       case AMDGPU_PL_GWS:
>>>> -               return AMDGPU_GEM_DOMAIN_GWS;
>>>> -       case AMDGPU_PL_OA:
>>>> -               return AMDGPU_GEM_DOMAIN_OA;
>>>>          default:
>>>>                  break;
>>>>          }
>>>>          return 0;
>>>>    }
>>>>      /**
>>>>     * amdgpu_bo_reserve - reserve bo
>>>>     * @bo:               bo structure
>>>>     * @no_intr:  don't return -ERESTARTSYS on pending signal
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index 9cc239968e40..f6ea9604e611 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -130,24 +130,20 @@ struct amdgpu_ring_funcs {
>>>>          /* command emit functions */
>>>>          void (*emit_ib)(struct amdgpu_ring *ring,
>>>>                          struct amdgpu_ib *ib,
>>>>                          unsigned vmid, bool ctx_switch);
>>>>          void (*emit_fence)(struct amdgpu_ring *ring, uint64_t addr,
>>>>                             uint64_t seq, unsigned flags);
>>>>          void (*emit_pipeline_sync)(struct amdgpu_ring *ring);
>>>>          void (*emit_vm_flush)(struct amdgpu_ring *ring, unsigned vmid=
,
>>>>                                uint64_t pd_addr);
>>>>          void (*emit_hdp_flush)(struct amdgpu_ring *ring);
>>>> -       void (*emit_gds_switch)(struct amdgpu_ring *ring, uint32_t vmi=
d,
>>>> -                               uint32_t gds_base, uint32_t gds_size,
>>>> -                               uint32_t gws_base, uint32_t gws_size,
>>>> -                               uint32_t oa_base, uint32_t oa_size);
>>>>          /* testing functions */
>>>>          int (*test_ring)(struct amdgpu_ring *ring);
>>>>          int (*test_ib)(struct amdgpu_ring *ring, long timeout);
>>>>          /* insert NOP packets */
>>>>          void (*insert_nop)(struct amdgpu_ring *ring, uint32_t count);
>>>>          void (*insert_start)(struct amdgpu_ring *ring);
>>>>          void (*insert_end)(struct amdgpu_ring *ring);
>>>>          /* pad the indirect buffer to the necessary number of dw */
>>>>          void (*pad_ib)(struct amdgpu_ring *ring, struct amdgpu_ib *ib=
);
>>>>          unsigned (*init_cond_exec)(struct amdgpu_ring *ring);
>>>> @@ -226,21 +222,20 @@ struct amdgpu_ring {
>>>>    #define amdgpu_ring_patch_cs_in_place(r, p, ib)
>>>> ((r)->funcs->patch_cs_in_place((p), (ib)))
>>>>    #define amdgpu_ring_test_ring(r) (r)->funcs->test_ring((r))
>>>>    #define amdgpu_ring_test_ib(r, t) (r)->funcs->test_ib((r), (t))
>>>>    #define amdgpu_ring_get_rptr(r) (r)->funcs->get_rptr((r))
>>>>    #define amdgpu_ring_get_wptr(r) (r)->funcs->get_wptr((r))
>>>>    #define amdgpu_ring_set_wptr(r) (r)->funcs->set_wptr((r))
>>>>    #define amdgpu_ring_emit_ib(r, ib, vmid, c) (r)->funcs->emit_ib((r)=
,
>>>> (ib), (vmid), (c))
>>>>    #define amdgpu_ring_emit_pipeline_sync(r)
>>>> (r)->funcs->emit_pipeline_sync((r))
>>>>    #define amdgpu_ring_emit_vm_flush(r, vmid, addr)
>>>> (r)->funcs->emit_vm_flush((r), (vmid), (addr))
>>>>    #define amdgpu_ring_emit_fence(r, addr, seq, flags)
>>>> (r)->funcs->emit_fence((r), (addr), (seq), (flags))
>>>> -#define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as)
>>>> (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab),
>>>> (as))
>>>>    #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r=
))
>>>>    #define amdgpu_ring_emit_switch_buffer(r)
>>>> (r)->funcs->emit_switch_buffer((r))
>>>>    #define amdgpu_ring_emit_cntxcntl(r, d)
>>>> (r)->funcs->emit_cntxcntl((r),
>>>> (d))
>>>>    #define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
>>>>    #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r),
>>>> (d),
>>>> (v))
>>>>    #define amdgpu_ring_emit_reg_wait(r, d, v, m)
>>>> (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>>>>    #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m)
>>>> (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
>>>>    #define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
>>>>    #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
>>>>    #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r=
))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 8a158ee922f7..2cc62b0e7ea8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -195,30 +195,20 @@ static int amdgpu_init_mem_type(struct
>>>> ttm_bo_device
>>>> *bdev, uint32_t type,
>>>>                  break;
>>>>          case TTM_PL_VRAM:
>>>>                  /* "On-card" video ram */
>>>>                  man->func =3D &amdgpu_vram_mgr_func;
>>>>                  man->gpu_offset =3D adev->gmc.vram_start;
>>>>                  man->flags =3D TTM_MEMTYPE_FLAG_FIXED |
>>>>                               TTM_MEMTYPE_FLAG_MAPPABLE;
>>>>                  man->available_caching =3D TTM_PL_FLAG_UNCACHED |
>>>> TTM_PL_FLAG_WC;
>>>>                  man->default_caching =3D TTM_PL_FLAG_WC;
>>>>                  break;
>>>> -       case AMDGPU_PL_GDS:
>>>> -       case AMDGPU_PL_GWS:
>>>> -       case AMDGPU_PL_OA:
>>>> -               /* On-chip GDS memory*/
>>>> -               man->func =3D &ttm_bo_manager_func;
>>>> -               man->gpu_offset =3D 0;
>>>> -               man->flags =3D TTM_MEMTYPE_FLAG_FIXED |
>>>> TTM_MEMTYPE_FLAG_CMA;
>>>> -               man->available_caching =3D TTM_PL_FLAG_UNCACHED;
>>>> -               man->default_caching =3D TTM_PL_FLAG_UNCACHED;
>>>> -               break;
>>>>          default:
>>>>                  DRM_ERROR("Unsupported memory type %u\n",
>>>> (unsigned)type);
>>>>                  return -EINVAL;
>>>>          }
>>>>          return 0;
>>>>    }
>>>>      /**
>>>>     * amdgpu_evict_flags - Compute placement flags
>>>>     *
>>>> @@ -1039,25 +1029,20 @@ static int amdgpu_ttm_backend_bind(struct ttm_=
tt
>>>> *ttm,
>>>>                  if (r) {
>>>>                          DRM_ERROR("failed to pin userptr\n");
>>>>                          return r;
>>>>                  }
>>>>          }
>>>>          if (!ttm->num_pages) {
>>>>                  WARN(1, "nothing to bind %lu pages for mreg %p back
>>>> %p!\n",
>>>>                       ttm->num_pages, bo_mem, ttm);
>>>>          }
>>>>    -     if (bo_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
>>>> -           bo_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
>>>> -           bo_mem->mem_type =3D=3D AMDGPU_PL_OA)
>>>> -               return -EINVAL;
>>>> -
>>>>          if (!amdgpu_gtt_mgr_has_gart_addr(bo_mem)) {
>>>>                  gtt->offset =3D AMDGPU_BO_INVALID_OFFSET;
>>>>                  return 0;
>>>>          }
>>>>          /* compute PTE flags relevant to this BO memory */
>>>>          flags =3D amdgpu_ttm_tt_pte_flags(adev, ttm, bo_mem);
>>>>          /* bind pages into GART page tables */
>>>>          gtt->offset =3D ((u64)bo_mem->start << PAGE_SHIFT) -
>>>> adev->gmc.gart_start;
>>>> @@ -1818,60 +1803,20 @@ int amdgpu_ttm_init(struct amdgpu_device *adev=
)
>>>>          /* Initialize GTT memory pool */
>>>>          r =3D ttm_bo_init_mm(&adev->mman.bdev, TTM_PL_TT, gtt_size >>
>>>> PAGE_SHIFT);
>>>>          if (r) {
>>>>                  DRM_ERROR("Failed initializing GTT heap.\n");
>>>>                  return r;
>>>>          }
>>>>          DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
>>>>                   (unsigned)(gtt_size / (1024 * 1024)));
>>>>    -     /* Initialize various on-chip memory pools */
>>>> -       adev->gds.mem.total_size =3D adev->gds.mem.total_size <<
>>>> AMDGPU_GDS_SHIFT;
>>>> -       adev->gds.mem.gfx_partition_size =3D
>>>> adev->gds.mem.gfx_partition_size << AMDGPU_GDS_SHIFT;
>>>> -       adev->gds.mem.cs_partition_size =3D
>>>> adev->gds.mem.cs_partition_size
>>>> << AMDGPU_GDS_SHIFT;
>>>> -       adev->gds.gws.total_size =3D adev->gds.gws.total_size <<
>>>> AMDGPU_GWS_SHIFT;
>>>> -       adev->gds.gws.gfx_partition_size =3D
>>>> adev->gds.gws.gfx_partition_size << AMDGPU_GWS_SHIFT;
>>>> -       adev->gds.gws.cs_partition_size =3D
>>>> adev->gds.gws.cs_partition_size
>>>> << AMDGPU_GWS_SHIFT;
>>>> -       adev->gds.oa.total_size =3D adev->gds.oa.total_size <<
>>>> AMDGPU_OA_SHIFT;
>>>> -       adev->gds.oa.gfx_partition_size =3D
>>>> adev->gds.oa.gfx_partition_size
>>>> << AMDGPU_OA_SHIFT;
>>>> -       adev->gds.oa.cs_partition_size =3D adev->gds.oa.cs_partition_s=
ize
>>>> <<
>>>> AMDGPU_OA_SHIFT;
>>>> -       /* GDS Memory */
>>>> -       if (adev->gds.mem.total_size) {
>>>> -               r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_GDS,
>>>> -                                  adev->gds.mem.total_size >>
>>>> PAGE_SHIFT);
>>>> -               if (r) {
>>>> -                       DRM_ERROR("Failed initializing GDS heap.\n");
>>>> -                       return r;
>>>> -               }
>>>> -       }
>>>> -
>>>> -       /* GWS */
>>>> -       if (adev->gds.gws.total_size) {
>>>> -               r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_GWS,
>>>> -                                  adev->gds.gws.total_size >>
>>>> PAGE_SHIFT);
>>>> -               if (r) {
>>>> -                       DRM_ERROR("Failed initializing gws heap.\n");
>>>> -                       return r;
>>>> -               }
>>>> -       }
>>>> -
>>>> -       /* OA */
>>>> -       if (adev->gds.oa.total_size) {
>>>> -               r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_OA,
>>>> -                                  adev->gds.oa.total_size >>
>>>> PAGE_SHIFT);
>>>> -               if (r) {
>>>> -                       DRM_ERROR("Failed initializing oa heap.\n");
>>>> -                       return r;
>>>> -               }
>>>> -       }
>>>> -
>>>>          /* Register debugfs entries for amdgpu_ttm */
>>>>          r =3D amdgpu_ttm_debugfs_init(adev);
>>>>          if (r) {
>>>>                  DRM_ERROR("Failed to init debugfs\n");
>>>>                  return r;
>>>>          }
>>>>          return 0;
>>>>    }
>>>>      /**
>>>> @@ -1892,26 +1837,20 @@ void amdgpu_ttm_fini(struct amdgpu_device *ade=
v)
>>>>                  return;
>>>>          amdgpu_ttm_debugfs_fini(adev);
>>>>          amdgpu_ttm_fw_reserve_vram_fini(adev);
>>>>          if (adev->mman.aper_base_kaddr)
>>>>                  iounmap(adev->mman.aper_base_kaddr);
>>>>          adev->mman.aper_base_kaddr =3D NULL;
>>>>          ttm_bo_clean_mm(&adev->mman.bdev, TTM_PL_VRAM);
>>>>          ttm_bo_clean_mm(&adev->mman.bdev, TTM_PL_TT);
>>>> -       if (adev->gds.mem.total_size)
>>>> -               ttm_bo_clean_mm(&adev->mman.bdev, AMDGPU_PL_GDS);
>>>> -       if (adev->gds.gws.total_size)
>>>> -               ttm_bo_clean_mm(&adev->mman.bdev, AMDGPU_PL_GWS);
>>>> -       if (adev->gds.oa.total_size)
>>>> -               ttm_bo_clean_mm(&adev->mman.bdev, AMDGPU_PL_OA);
>>>>          ttm_bo_device_release(&adev->mman.bdev);
>>>>          amdgpu_ttm_global_fini(adev);
>>>>          adev->mman.initialized =3D false;
>>>>          DRM_INFO("amdgpu: ttm finalized\n");
>>>>    }
>>>>      /**
>>>>     * amdgpu_ttm_set_buffer_funcs_status - enable/disable use of buffe=
r
>>>> functions
>>>>     *
>>>>     * @adev: amdgpu_device pointer
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index fe8f276e9811..04557a382b19 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -20,28 +20,20 @@
>>>>     * OTHER DEALINGS IN THE SOFTWARE.
>>>>     *
>>>>     */
>>>>      #ifndef __AMDGPU_TTM_H__
>>>>    #define __AMDGPU_TTM_H__
>>>>      #include "amdgpu.h"
>>>>    #include <drm/gpu_scheduler.h>
>>>>    -#define AMDGPU_PL_GDS                (TTM_PL_PRIV + 0)
>>>> -#define AMDGPU_PL_GWS          (TTM_PL_PRIV + 1)
>>>> -#define AMDGPU_PL_OA           (TTM_PL_PRIV + 2)
>>>> -
>>>> -#define AMDGPU_PL_FLAG_GDS             (TTM_PL_FLAG_PRIV << 0)
>>>> -#define AMDGPU_PL_FLAG_GWS             (TTM_PL_FLAG_PRIV << 1)
>>>> -#define AMDGPU_PL_FLAG_OA              (TTM_PL_FLAG_PRIV << 2)
>>>> -
>>>>    #define AMDGPU_GTT_MAX_TRANSFER_SIZE  512
>>>>    #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS       2
>>>>      struct amdgpu_mman {
>>>>          struct ttm_bo_global_ref        bo_global_ref;
>>>>          struct drm_global_reference     mem_global_ref;
>>>>          struct ttm_bo_device            bdev;
>>>>          bool                            mem_global_referenced;
>>>>          bool                            initialized;
>>>>          void __iomem                    *aper_base_kaddr;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index be1659fedf94..c66f1c6f0ba8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -803,86 +803,69 @@ void amdgpu_vm_check_compute_bug(struct
>>>> amdgpu_device *adev)
>>>>     * Returns:
>>>>     * True if sync is needed.
>>>>     */
>>>>    bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>>>                                    struct amdgpu_job *job)
>>>>    {
>>>>          struct amdgpu_device *adev =3D ring->adev;
>>>>          unsigned vmhub =3D ring->funcs->vmhub;
>>>>          struct amdgpu_vmid_mgr *id_mgr =3D
>>>> &adev->vm_manager.id_mgr[vmhub];
>>>>          struct amdgpu_vmid *id;
>>>> -       bool gds_switch_needed;
>>>>          bool vm_flush_needed =3D job->vm_needs_flush ||
>>>> ring->has_compute_vm_bug;
>>>>          if (job->vmid =3D=3D 0)
>>>>                  return false;
>>>>          id =3D &id_mgr->ids[job->vmid];
>>>> -       gds_switch_needed =3D ring->funcs->emit_gds_switch && (
>>>> -               id->gds_base !=3D job->gds_base ||
>>>> -               id->gds_size !=3D job->gds_size ||
>>>> -               id->gws_base !=3D job->gws_base ||
>>>> -               id->gws_size !=3D job->gws_size ||
>>>> -               id->oa_base !=3D job->oa_base ||
>>>> -               id->oa_size !=3D job->oa_size);
>>>>          if (amdgpu_vmid_had_gpu_reset(adev, id))
>>>>                  return true;
>>>>    -     return vm_flush_needed || gds_switch_needed;
>>>> +       return vm_flush_needed;
>>>>    }
>>>>      /**
>>>>     * amdgpu_vm_flush - hardware flush the vm
>>>>     *
>>>>     * @ring: ring to use for flush
>>>>     * @job:  related job
>>>>     * @need_pipe_sync: is pipe sync needed
>>>>     *
>>>>     * Emit a VM flush when it is necessary.
>>>>     *
>>>>     * Returns:
>>>>     * 0 on success, errno otherwise.
>>>>     */
>>>>    int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *jo=
b,
>>>> bool need_pipe_sync)
>>>>    {
>>>>          struct amdgpu_device *adev =3D ring->adev;
>>>>          unsigned vmhub =3D ring->funcs->vmhub;
>>>>          struct amdgpu_vmid_mgr *id_mgr =3D
>>>> &adev->vm_manager.id_mgr[vmhub];
>>>>          struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
>>>> -       bool gds_switch_needed =3D ring->funcs->emit_gds_switch && (
>>>> -               id->gds_base !=3D job->gds_base ||
>>>> -               id->gds_size !=3D job->gds_size ||
>>>> -               id->gws_base !=3D job->gws_base ||
>>>> -               id->gws_size !=3D job->gws_size ||
>>>> -               id->oa_base !=3D job->oa_base ||
>>>> -               id->oa_size !=3D job->oa_size);
>>>>          bool vm_flush_needed =3D job->vm_needs_flush;
>>>>          bool pasid_mapping_needed =3D id->pasid !=3D job->pasid ||
>>>>                  !id->pasid_mapping ||
>>>>                  !dma_fence_is_signaled(id->pasid_mapping);
>>>>          struct dma_fence *fence =3D NULL;
>>>>          unsigned patch_offset =3D 0;
>>>>          int r;
>>>>          if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>>>> -               gds_switch_needed =3D true;
>>>>                  vm_flush_needed =3D true;
>>>>                  pasid_mapping_needed =3D true;
>>>>          }
>>>>    -     gds_switch_needed &=3D !!ring->funcs->emit_gds_switch;
>>>>          vm_flush_needed &=3D !!ring->funcs->emit_vm_flush  &&
>>>>                          job->vm_pd_addr !=3D AMDGPU_BO_INVALID_OFFSET=
;
>>>>          pasid_mapping_needed &=3D adev->gmc.gmc_funcs->emit_pasid_map=
ping
>>>> &&
>>>>                  ring->funcs->emit_wreg;
>>>>    -     if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync=
)
>>>> +       if (!vm_flush_needed && !need_pipe_sync)
>>>>                  return 0;
>>>>          if (ring->funcs->init_cond_exec)
>>>>                  patch_offset =3D amdgpu_ring_init_cond_exec(ring);
>>>>          if (need_pipe_sync)
>>>>                  amdgpu_ring_emit_pipeline_sync(ring);
>>>>          if (vm_flush_needed) {
>>>>                  trace_amdgpu_vm_flush(ring, job->vmid,
>>>> job->vm_pd_addr);
>>>> @@ -907,33 +890,20 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring,
>>>> struct
>>>> amdgpu_job *job, bool need_
>>>>                  mutex_unlock(&id_mgr->lock);
>>>>          }
>>>>          if (pasid_mapping_needed) {
>>>>                  id->pasid =3D job->pasid;
>>>>                  dma_fence_put(id->pasid_mapping);
>>>>                  id->pasid_mapping =3D dma_fence_get(fence);
>>>>          }
>>>>          dma_fence_put(fence);
>>>>    -     if (ring->funcs->emit_gds_switch && gds_switch_needed) {
>>>> -               id->gds_base =3D job->gds_base;
>>>> -               id->gds_size =3D job->gds_size;
>>>> -               id->gws_base =3D job->gws_base;
>>>> -               id->gws_size =3D job->gws_size;
>>>> -               id->oa_base =3D job->oa_base;
>>>> -               id->oa_size =3D job->oa_size;
>>>> -               amdgpu_ring_emit_gds_switch(ring, job->vmid,
>>>> job->gds_base,
>>>> -                                           job->gds_size,
>>>> job->gws_base,
>>>> -                                           job->gws_size, job->oa_bas=
e,
>>>> -                                           job->oa_size);
>>>> -       }
>>>> -
>>>>          if (ring->funcs->patch_cond_exec)
>>>>                  amdgpu_ring_patch_cond_exec(ring, patch_offset);
>>>>          /* the double SWITCH_BUFFER here *cannot* be skipped by
>>>> COND_EXEC
>>>> */
>>>>          if (ring->funcs->emit_switch_buffer) {
>>>>                  amdgpu_ring_emit_switch_buffer(ring);
>>>>                  amdgpu_ring_emit_switch_buffer(ring);
>>>>          }
>>>>          return 0;
>>>>    }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> index a15d9c0f233b..f5228e169c3a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> @@ -1890,21 +1890,21 @@ static void gfx_v7_0_config_init(struct
>>>> amdgpu_device *adev)
>>>>     *
>>>>     * @adev: amdgpu_device pointer
>>>>     *
>>>>     * Configures the 3D engine and tiling configuration
>>>>     * registers so that the 3D engine is usable.
>>>>     */
>>>>    static void gfx_v7_0_gpu_init(struct amdgpu_device *adev)
>>>>    {
>>>>          u32 sh_mem_cfg, sh_static_mem_cfg, sh_mem_base;
>>>>          u32 tmp;
>>>> -       int i;
>>>> +       int i, vmid;
>>>>          WREG32(mmGRBM_CNTL, (0xff << GRBM_CNTL__READ_TIMEOUT__SHIFT))=
;
>>>>          WREG32(mmGB_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>>>>          WREG32(mmHDP_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>>>>          WREG32(mmDMIF_ADDR_CALC, adev->gfx.config.gb_addr_config);
>>>>          gfx_v7_0_tiling_mode_table_init(adev);
>>>>          gfx_v7_0_setup_rb(adev);
>>>> @@ -2014,20 +2014,42 @@ static void gfx_v7_0_gpu_init(struct
>>>> amdgpu_device
>>>> *adev)
>>>>          tmp =3D RREG32(mmSPI_ARB_PRIORITY);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS0, =
2);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS1, =
2);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS2, =
2);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS3, =
2);
>>>>          WREG32(mmSPI_ARB_PRIORITY, tmp);
>>>>          mutex_unlock(&adev->grbm_idx_mutex);
>>>>    +     for (vmid =3D 0; vmid < AMDGPU_NUM_VMID; vmid++) {
>>>> +               unsigned gds_size, gws_size, oa_size;
>>>> +
>>>> +               if (vmid <
>>>> adev->vm_manager.id_mgr[AMDGPU_GFXHUB].num_ids)
>>>> {
>>>> +                       gds_size =3D adev->gds.mem.gfx_size_per_vmid;
>>>> +                       gws_size =3D adev->gds.gws.gfx_size_per_vmid;
>>>> +                       oa_size =3D adev->gds.oa.gfx_size_per_vmid;
>>>> +               } else {
>>>> +                       gds_size =3D adev->gds.mem.kfd_size_per_vmid;
>>>> +                       gws_size =3D adev->gds.gws.kfd_size_per_vmid;
>>>> +                       oa_size =3D adev->gds.oa.kfd_size_per_vmid;
>>>> +               }
>>>> +
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].mem_base, vmid *
>>>> gds_size);
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].mem_size, gds_size)=
;
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].gws,
>>>> +                      (vmid * gws_size) |
>>>> +                      (gws_size << GDS_GWS_VMID0__SIZE__SHIFT));
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].oa,
>>>> +                      ((1 << oa_size) - 1) << (vmid * oa_size));
>>>> +       }
>>>> +
>>>>          udelay(50);
>>>>    }
>>>>      /*
>>>>     * GPU scratch registers helpers function.
>>>>     */
>>>>    /**
>>>>     * gfx_v7_0_scratch_init - setup driver info for CP scratch regs
>>>>     *
>>>>     * @adev: amdgpu_device pointer
>>>> @@ -4157,68 +4179,20 @@ static uint64_t
>>>> gfx_v7_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>>>>          uint64_t clock;
>>>>          mutex_lock(&adev->gfx.gpu_clock_mutex);
>>>>          WREG32(mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
>>>>          clock =3D (uint64_t)RREG32(mmRLC_GPU_CLOCK_COUNT_LSB) |
>>>>                  ((uint64_t)RREG32(mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL=
);
>>>>          mutex_unlock(&adev->gfx.gpu_clock_mutex);
>>>>          return clock;
>>>>    }
>>>>    -static void gfx_v7_0_ring_emit_gds_switch(struct amdgpu_ring *ring=
,
>>>> -                                         uint32_t vmid,
>>>> -                                         uint32_t gds_base, uint32_t
>>>> gds_size,
>>>> -                                         uint32_t gws_base, uint32_t
>>>> gws_size,
>>>> -                                         uint32_t oa_base, uint32_t
>>>> oa_size)
>>>> -{
>>>> -       gds_base =3D gds_base >> AMDGPU_GDS_SHIFT;
>>>> -       gds_size =3D gds_size >> AMDGPU_GDS_SHIFT;
>>>> -
>>>> -       gws_base =3D gws_base >> AMDGPU_GWS_SHIFT;
>>>> -       gws_size =3D gws_size >> AMDGPU_GWS_SHIFT;
>>>> -
>>>> -       oa_base =3D oa_base >> AMDGPU_OA_SHIFT;
>>>> -       oa_size =3D oa_size >> AMDGPU_OA_SHIFT;
>>>> -
>>>> -       /* GDS Base */
>>>> -       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>>>> -       amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
>>>> -                               WRITE_DATA_DST_SEL(0)));
>>>> -       amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].mem_base);
>>>> -       amdgpu_ring_write(ring, 0);
>>>> -       amdgpu_ring_write(ring, gds_base);
>>>> -
>>>> -       /* GDS Size */
>>>> -       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>>>> -       amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
>>>> -                               WRITE_DATA_DST_SEL(0)));
>>>> -       amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].mem_size);
>>>> -       amdgpu_ring_write(ring, 0);
>>>> -       amdgpu_ring_write(ring, gds_size);
>>>> -
>>>> -       /* GWS */
>>>> -       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>>>> -       amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
>>>> -                               WRITE_DATA_DST_SEL(0)));
>>>> -       amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].gws);
>>>> -       amdgpu_ring_write(ring, 0);
>>>> -       amdgpu_ring_write(ring, gws_size << GDS_GWS_VMID0__SIZE__SHIFT=
 |
>>>> gws_base);
>>>> -
>>>> -       /* OA */
>>>> -       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>>>> -       amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
>>>> -                               WRITE_DATA_DST_SEL(0)));
>>>> -       amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].oa);
>>>> -       amdgpu_ring_write(ring, 0);
>>>> -       amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 <<
>>>> oa_base));
>>>> -}
>>>> -
>>>>    static void gfx_v7_0_ring_soft_recovery(struct amdgpu_ring *ring,
>>>> unsigned vmid)
>>>>    {
>>>>          struct amdgpu_device *adev =3D ring->adev;
>>>>          uint32_t value =3D 0;
>>>>          value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
>>>>          value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
>>>>          value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
>>>>          value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
>>>>          WREG32(mmSQ_CMD, value);
>>>> @@ -4584,55 +4558,32 @@ static int gfx_v7_0_sw_init(void *handle)
>>>>
>>>> ring_id,
>>>>                                                                  i, k,
>>>> j);
>>>>                                  if (r)
>>>>                                          return r;
>>>>                                  ring_id++;
>>>>                          }
>>>>                  }
>>>>          }
>>>>    -     /* reserve GDS, GWS and OA resource for gfx */
>>>> -       r =3D amdgpu_bo_create_kernel(adev,
>>>> adev->gds.mem.gfx_partition_size,
>>>> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GDS,
>>>> -                                   &adev->gds.gds_gfx_bo, NULL, NULL)=
;
>>>> -       if (r)
>>>> -               return r;
>>>> -
>>>> -       r =3D amdgpu_bo_create_kernel(adev,
>>>> adev->gds.gws.gfx_partition_size,
>>>> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GWS,
>>>> -                                   &adev->gds.gws_gfx_bo, NULL, NULL)=
;
>>>> -       if (r)
>>>> -               return r;
>>>> -
>>>> -       r =3D amdgpu_bo_create_kernel(adev,
>>>> adev->gds.oa.gfx_partition_size,
>>>> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_OA,
>>>> -                                   &adev->gds.oa_gfx_bo, NULL, NULL);
>>>> -       if (r)
>>>> -               return r;
>>>> -
>>>>          adev->gfx.ce_ram_size =3D 0x8000;
>>>>          gfx_v7_0_gpu_early_init(adev);
>>>>          return r;
>>>>    }
>>>>      static int gfx_v7_0_sw_fini(void *handle)
>>>>    {
>>>>          int i;
>>>>          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
>>>>    -     amdgpu_bo_free_kernel(&adev->gds.oa_gfx_bo, NULL, NULL);
>>>> -       amdgpu_bo_free_kernel(&adev->gds.gws_gfx_bo, NULL, NULL);
>>>> -       amdgpu_bo_free_kernel(&adev->gds.gds_gfx_bo, NULL, NULL);
>>>> -
>>>>          for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>>>>                  amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>>>>          for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>>>>                  amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>>>>          gfx_v7_0_cp_compute_fini(adev);
>>>>          gfx_v7_0_rlc_fini(adev);
>>>>          gfx_v7_0_mec_fini(adev);
>>>>          amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>>>>                                  &adev->gfx.rlc.clear_state_gpu_addr,
>>>> @@ -5073,64 +5024,60 @@ static const struct amd_ip_funcs
>>>> gfx_v7_0_ip_funcs
>>>> =3D {
>>>>      static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx =3D=
 {
>>>>          .type =3D AMDGPU_RING_TYPE_GFX,
>>>>          .align_mask =3D 0xff,
>>>>          .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>>>>          .support_64bit_ptrs =3D false,
>>>>          .get_rptr =3D gfx_v7_0_ring_get_rptr,
>>>>          .get_wptr =3D gfx_v7_0_ring_get_wptr_gfx,
>>>>          .set_wptr =3D gfx_v7_0_ring_set_wptr_gfx,
>>>>          .emit_frame_size =3D
>>>> -               20 + /* gfx_v7_0_ring_emit_gds_switch */
>>>>                  7 + /* gfx_v7_0_ring_emit_hdp_flush */
>>>>                  5 + /* hdp invalidate */
>>>>                  12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for
>>>> user
>>>> fence, vm fence */
>>>>                  7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
>>>>                  CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /*
>>>> gfx_v7_0_ring_emit_vm_flush */
>>>>                  3 + 4, /* gfx_v7_ring_emit_cntxcntl including vgt
>>>> flush*/
>>>>          .emit_ib_size =3D 4, /* gfx_v7_0_ring_emit_ib_gfx */
>>>>          .emit_ib =3D gfx_v7_0_ring_emit_ib_gfx,
>>>>          .emit_fence =3D gfx_v7_0_ring_emit_fence_gfx,
>>>>          .emit_pipeline_sync =3D gfx_v7_0_ring_emit_pipeline_sync,
>>>>          .emit_vm_flush =3D gfx_v7_0_ring_emit_vm_flush,
>>>> -       .emit_gds_switch =3D gfx_v7_0_ring_emit_gds_switch,
>>>>          .emit_hdp_flush =3D gfx_v7_0_ring_emit_hdp_flush,
>>>>          .test_ring =3D gfx_v7_0_ring_test_ring,
>>>>          .test_ib =3D gfx_v7_0_ring_test_ib,
>>>>          .insert_nop =3D amdgpu_ring_insert_nop,
>>>>          .pad_ib =3D amdgpu_ring_generic_pad_ib,
>>>>          .emit_cntxcntl =3D gfx_v7_ring_emit_cntxcntl,
>>>>          .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
>>>>          .soft_recovery =3D gfx_v7_0_ring_soft_recovery,
>>>>    };
>>>>      static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute=
 =3D
>>>> {
>>>>          .type =3D AMDGPU_RING_TYPE_COMPUTE,
>>>>          .align_mask =3D 0xff,
>>>>          .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>>>>          .support_64bit_ptrs =3D false,
>>>>          .get_rptr =3D gfx_v7_0_ring_get_rptr,
>>>>          .get_wptr =3D gfx_v7_0_ring_get_wptr_compute,
>>>>          .set_wptr =3D gfx_v7_0_ring_set_wptr_compute,
>>>>          .emit_frame_size =3D
>>>> -               20 + /* gfx_v7_0_ring_emit_gds_switch */
>>>>                  7 + /* gfx_v7_0_ring_emit_hdp_flush */
>>>>                  5 + /* hdp invalidate */
>>>>                  7 + /* gfx_v7_0_ring_emit_pipeline_sync */
>>>>                  CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
>>>> gfx_v7_0_ring_emit_vm_flush */
>>>>                  7 + 7 + 7, /* gfx_v7_0_ring_emit_fence_compute x3 for
>>>> user
>>>> fence, vm fence */
>>>>          .emit_ib_size =3D 4, /* gfx_v7_0_ring_emit_ib_compute */
>>>>          .emit_ib =3D gfx_v7_0_ring_emit_ib_compute,
>>>>          .emit_fence =3D gfx_v7_0_ring_emit_fence_compute,
>>>>          .emit_pipeline_sync =3D gfx_v7_0_ring_emit_pipeline_sync,
>>>>          .emit_vm_flush =3D gfx_v7_0_ring_emit_vm_flush,
>>>> -       .emit_gds_switch =3D gfx_v7_0_ring_emit_gds_switch,
>>>>          .emit_hdp_flush =3D gfx_v7_0_ring_emit_hdp_flush,
>>>>          .test_ring =3D gfx_v7_0_ring_test_ring,
>>>>          .test_ib =3D gfx_v7_0_ring_test_ib,
>>>>          .insert_nop =3D amdgpu_ring_insert_nop,
>>>>          .pad_ib =3D amdgpu_ring_generic_pad_ib,
>>>>          .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
>>>>    };
>>>>      static void gfx_v7_0_set_ring_funcs(struct amdgpu_device *adev)
>>>>    {
>>>> @@ -5169,42 +5116,28 @@ static void gfx_v7_0_set_irq_funcs(struct
>>>> amdgpu_device *adev)
>>>>          adev->gfx.priv_inst_irq.funcs =3D &gfx_v7_0_priv_inst_irq_fun=
cs;
>>>>    }
>>>>      static void gfx_v7_0_set_gds_init(struct amdgpu_device *adev)
>>>>    {
>>>>          /* init asci gds info */
>>>>          adev->gds.mem.total_size =3D RREG32(mmGDS_VMID0_SIZE);
>>>>          adev->gds.gws.total_size =3D 64;
>>>>          adev->gds.oa.total_size =3D 16;
>>>>    -     if (adev->gds.mem.total_size =3D=3D 64 * 1024) {
>>>> -               adev->gds.mem.gfx_partition_size =3D 4096;
>>>> -               adev->gds.mem.cs_partition_size =3D 4096;
>>>> -
>>>> -               adev->gds.gws.gfx_partition_size =3D 4;
>>>> -               adev->gds.gws.cs_partition_size =3D 4;
>>>> -
>>>> -               adev->gds.oa.gfx_partition_size =3D 4;
>>>> -               adev->gds.oa.cs_partition_size =3D 1;
>>>> -       } else {
>>>> -               adev->gds.mem.gfx_partition_size =3D 1024;
>>>> -               adev->gds.mem.cs_partition_size =3D 1024;
>>>> -
>>>> -               adev->gds.gws.gfx_partition_size =3D 16;
>>>> -               adev->gds.gws.cs_partition_size =3D 16;
>>>> -
>>>> -               adev->gds.oa.gfx_partition_size =3D 4;
>>>> -               adev->gds.oa.cs_partition_size =3D 4;
>>>> -       }
>>>> +       adev->gds.mem.gfx_size_per_vmid =3D adev->gds.mem.total_size /
>>>> AMDGPU_NUM_VMID;
>>>> +       adev->gds.mem.kfd_size_per_vmid =3D adev->gds.mem.total_size /
>>>> AMDGPU_NUM_VMID;
>>>> +       adev->gds.gws.gfx_size_per_vmid =3D adev->gds.gws.total_size /
>>>> AMDGPU_NUM_VMID;
>>>> +       adev->gds.gws.kfd_size_per_vmid =3D adev->gds.gws.total_size /
>>>> AMDGPU_NUM_VMID;
>>>> +       adev->gds.oa.gfx_size_per_vmid =3D adev->gds.oa.total_size / 8=
; /*
>>>> gfx only */
>>>> +       adev->gds.oa.kfd_size_per_vmid =3D 0;
>>>>    }
>>>>    -
>>>>    static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
>>>>    {
>>>>          int i, j, k, counter, active_cu_number =3D 0;
>>>>          u32 mask, bitmap, ao_bitmap, ao_cu_mask =3D 0;
>>>>          struct amdgpu_cu_info *cu_info =3D &adev->gfx.cu_info;
>>>>          unsigned disable_masks[4 * 2];
>>>>          u32 ao_cu_num;
>>>>          if (adev->flags & AMD_IS_APU)
>>>>                  ao_cu_num =3D 2;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> index 3882689b2d8f..b11a54bd0668 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> @@ -2154,57 +2154,34 @@ static int gfx_v8_0_sw_init(void *handle)
>>>>          kiq =3D &adev->gfx.kiq;
>>>>          r =3D amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
>>>>          if (r)
>>>>                  return r;
>>>>          /* create MQD for all compute queues as well as KIQ for SRIOV
>>>> case
>>>> */
>>>>          r =3D amdgpu_gfx_compute_mqd_sw_init(adev, sizeof(struct
>>>> vi_mqd_allocation));
>>>>          if (r)
>>>>                  return r;
>>>>    -     /* reserve GDS, GWS and OA resource for gfx */
>>>> -       r =3D amdgpu_bo_create_kernel(adev,
>>>> adev->gds.mem.gfx_partition_size,
>>>> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GDS,
>>>> -                                   &adev->gds.gds_gfx_bo, NULL, NULL)=
;
>>>> -       if (r)
>>>> -               return r;
>>>> -
>>>> -       r =3D amdgpu_bo_create_kernel(adev,
>>>> adev->gds.gws.gfx_partition_size,
>>>> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GWS,
>>>> -                                   &adev->gds.gws_gfx_bo, NULL, NULL)=
;
>>>> -       if (r)
>>>> -               return r;
>>>> -
>>>> -       r =3D amdgpu_bo_create_kernel(adev,
>>>> adev->gds.oa.gfx_partition_size,
>>>> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_OA,
>>>> -                                   &adev->gds.oa_gfx_bo, NULL, NULL);
>>>> -       if (r)
>>>> -               return r;
>>>> -
>>>>          adev->gfx.ce_ram_size =3D 0x8000;
>>>>          r =3D gfx_v8_0_gpu_early_init(adev);
>>>>          if (r)
>>>>                  return r;
>>>>          return 0;
>>>>    }
>>>>      static int gfx_v8_0_sw_fini(void *handle)
>>>>    {
>>>>          int i;
>>>>          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
>>>>    -     amdgpu_bo_free_kernel(&adev->gds.oa_gfx_bo, NULL, NULL);
>>>> -       amdgpu_bo_free_kernel(&adev->gds.gws_gfx_bo, NULL, NULL);
>>>> -       amdgpu_bo_free_kernel(&adev->gds.gds_gfx_bo, NULL, NULL);
>>>> -
>>>>          for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>>>>                  amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>>>>          for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>>>>                  amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>>>>          amdgpu_gfx_compute_mqd_sw_fini(adev);
>>>>          amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring,
>>>> &adev->gfx.kiq.irq);
>>>>          amdgpu_gfx_kiq_fini(adev);
>>>>          gfx_v8_0_mec_fini(adev);
>>>> @@ -3850,21 +3827,21 @@ static void gfx_v8_0_config_init(struct
>>>> amdgpu_device *adev)
>>>>          case CHIP_CARRIZO:
>>>>          case CHIP_STONEY:
>>>>                  adev->gfx.config.double_offchip_lds_buf =3D 0;
>>>>                  break;
>>>>          }
>>>>    }
>>>>      static void gfx_v8_0_gpu_init(struct amdgpu_device *adev)
>>>>    {
>>>>          u32 tmp, sh_static_mem_cfg;
>>>> -       int i;
>>>> +       int i, vmid;
>>>>          WREG32_FIELD(GRBM_CNTL, READ_TIMEOUT, 0xFF);
>>>>          WREG32(mmGB_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>>>>          WREG32(mmHDP_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>>>>          WREG32(mmDMIF_ADDR_CALC, adev->gfx.config.gb_addr_config);
>>>>          gfx_v8_0_tiling_mode_table_init(adev);
>>>>          gfx_v8_0_setup_rb(adev);
>>>>          gfx_v8_0_get_cu_info(adev);
>>>>          gfx_v8_0_config_init(adev);
>>>> @@ -3927,20 +3904,41 @@ static void gfx_v8_0_gpu_init(struct
>>>> amdgpu_device
>>>> *adev)
>>>>          tmp =3D RREG32(mmSPI_ARB_PRIORITY);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS0, =
2);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS1, =
2);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS2, =
2);
>>>>          tmp =3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS3, =
2);
>>>>          WREG32(mmSPI_ARB_PRIORITY, tmp);
>>>>          mutex_unlock(&adev->grbm_idx_mutex);
>>>>    +     for (vmid =3D 0; vmid < AMDGPU_NUM_VMID; vmid++) {
>>>> +               unsigned gds_size, gws_size, oa_size;
>>>> +
>>>> +               if (vmid <
>>>> adev->vm_manager.id_mgr[AMDGPU_GFXHUB].num_ids)
>>>> {
>>>> +                       gds_size =3D adev->gds.mem.gfx_size_per_vmid;
>>>> +                       gws_size =3D adev->gds.gws.gfx_size_per_vmid;
>>>> +                       oa_size =3D adev->gds.oa.gfx_size_per_vmid;
>>>> +               } else {
>>>> +                       gds_size =3D adev->gds.mem.kfd_size_per_vmid;
>>>> +                       gws_size =3D adev->gds.gws.kfd_size_per_vmid;
>>>> +                       oa_size =3D adev->gds.oa.kfd_size_per_vmid;
>>>> +               }
>>>> +
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].mem_base, vmid *
>>>> gds_size);
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].mem_size, gds_size)=
;
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].gws,
>>>> +                      (vmid * gws_size) |
>>>> +                      (gws_size << GDS_GWS_VMID0__SIZE__SHIFT));
>>>> +               WREG32(amdgpu_gds_reg_offset[vmid].oa,
>>>> +                      ((1 << oa_size) - 1) << (vmid * oa_size));
>>>> +       }
>>>>    }
>>>>      static void gfx_v8_0_wait_for_rlc_serdes(struct amdgpu_device
>>>> *adev)
>>>>    {
>>>>          u32 i, j, k;
>>>>          u32 mask;
>>>>          mutex_lock(&adev->grbm_idx_mutex);
>>>>          for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
>>>>                  for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++=
) {
>>>> @@ -5383,68 +5381,20 @@ static uint64_t
>>>> gfx_v8_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>>>>          uint64_t clock;
>>>>          mutex_lock(&adev->gfx.gpu_clock_mutex);
>>>>          WREG32(mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
>>>>          clock =3D (uint64_t)RREG32(mmRLC_GPU_CLOCK_COUNT_LSB) |
>>>>                  ((uint64_t)RREG32(mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL=
);
>>>>          mutex_unlock(&adev->gfx.gpu_clock_mutex);
>>>>          return clock;
>>>>    }
>>>>    -static void gfx_v8_0_ring_emit_gds_switch(struct amdgpu_ring *ring=
,
>>>> -                                         uint32_t vmid,
>>>> -                                         uint32_t gds_base, uint32_t
>>>> gds_size,
>>>> -                                         uint32_t gws_base, uint32_t
>>>> gws_size,
>>>> -                                         uint32_t oa_base, uint32_t
>>>> oa_size)
>>>> -{
>>>> -       gds_base =3D gds_base >> AMDGPU_GDS_SHIFT;
>>>> -       gds_size =3D gds_size >> AMDGPU_GDS_SHIFT;
>>>> -
>>>> -       gws_base =3D gws_base >> AMDGPU_GWS_SHIFT;
>>>> -       gws_size =3D gws_size >> AMDGPU_GWS_SHIFT;
>>>> -
>>>> -       oa_base =3D oa_base >> AMDGPU_OA_SHIFT;
>>>> -       oa_size =3D oa_size >> AMDGPU_OA_SHIFT;
>>>> -
>>>> -       /* GDS Base */
>>>> -       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>>>> -       amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180977B44E93B5357C5145B3F71A0BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Why don't we just fix up the curr=
ent GDS code so it works the same as vram and then we can add a new CS or c=
ontext flag to ignore the current static allocation for gfx.&nbsp; We can i=
gnore data persistence if it's too much
 trouble.&nbsp; Assume you always have to init the memory before you use it=
.&nbsp; That's already the case.<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Marek Ol=9A=E1k &lt;maraeo@gm=
ail.com&gt;<br>
<b>Sent:</b> Thursday, September 13, 2018 2:20:28 PM<br>
<b>To:</b> Koenig, Christian<br>
<b>Cc:</b> amd-gfx mailing list<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: reserve GDS resources statically</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">GDS is a temporary memory. Its purpose depends on =
the job, but most of<br>
the time, the idea is:<br>
- beginning of IB<br>
- initialize GDS variables<br>
- dispatch compute that works with GDS variables<br>
- when done, copy GDS variables to memory<br>
- repeat ...<br>
- end of IB<br>
<br>
GDS is like a pool of global shader GPRs.<br>
<br>
GDS is too small for persistent data.<br>
<br>
Marek<br>
<br>
On Thu, Sep 13, 2018 at 1:26 PM, Christian K=F6nig<br>
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; Are you sure of that? I mean it is rather pointless to have a Global D=
ata<br>
&gt; Share when it can't be used to share anything?<br>
&gt;<br>
&gt; On the other hand I'm not opposed to get rid of all that stuff if we r=
eally<br>
&gt; don't need it.<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt; Am 13.09.2018 um 17:27 schrieb Marek Ol=9A=E1k:<br>
&gt;&gt;<br>
&gt;&gt; That's OK. We don't need IBs to get the same VMID.<br>
&gt;&gt;<br>
&gt;&gt; Marek<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Sep 13, 2018 at 4:40 AM, Christian K=F6nig<br>
&gt;&gt; &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; As discussed internally that doesn't work because threads don'=
t necessary<br>
&gt;&gt;&gt; get the same VMID assigned.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 12.09.2018 um 22:33 schrieb Marek Ol=9A=E1k:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; From: Marek Ol=9A=E1k &lt;marek.olsak-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I've chosen to do it like this because it's easy and allow=
s an arbitrary<br>
&gt;&gt;&gt;&gt; number of processes.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Marek Ol=9A=E1k &lt;marek.olsak-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_bo_lis=
t.c |&nbsp; 10 --<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_bo_lis=
t.h |&nbsp;&nbsp; 3 -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 ----<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 19 &#43;--<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 24 &#43;---<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 --<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 &#43;--<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object=
.c&nbsp; |&nbsp; 21 ----<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object=
.h&nbsp; |&nbsp;&nbsp; 6 -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h=
&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 61 ----------<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 --<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 34 &#43;-----<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 125<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43;&#43;&#43;---------------<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 123 &#43;&#43;&#43;&#43;&#43;----------=
----<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 124 &#43;&#43;&#43;&#43;&#43;&#43;-----=
--------<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 15 &#43;--<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 19 files changed, 109 insertions(&#43;),=
 519 deletions(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<b=
r>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt;&gt;&gt;&gt; index b80243d3972e..7264a4930b88 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_lis=
t.c<br>
&gt;&gt;&gt;&gt; @@ -71,23 &#43;71,20 @@ int amdgpu_bo_list_create(struct a=
mdgpu_device<br>
&gt;&gt;&gt;&gt; *adev,<br>
&gt;&gt;&gt;&gt; struct drm_file *filp,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / sizeof(s=
truct amdgpu_bo_list_entry))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size=
 =3D sizeof(struct amdgpu_bo_list);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size=
 &#43;=3D num_entries * sizeof(struct amdgpu_bo_list_entry);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list=
 =3D kvmalloc(size, GFP_KERNEL);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!list)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref=
_init(&amp;list-&gt;refcount);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list-&gt;gds_obj =3D=
 adev-&gt;gds.gds_gfx_bo;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list-&gt;gws_obj =3D=
 adev-&gt;gds.gws_gfx_bo;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list-&gt;oa_obj =3D =
adev-&gt;gds.oa_gfx_bo;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arra=
y =3D amdgpu_bo_list_array_entry(list, 0);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mems=
et(array, 0, num_entries * sizeof(struct<br>
&gt;&gt;&gt;&gt; amdgpu_bo_list_entry));<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for =
(i =3D 0; i &lt; num_entries; &#43;&#43;i) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_list_entry *en=
try;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *gobj;<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *usermm;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; @@ -111,27 &#43;108,20 @@ int amdgpu_bo_=
list_create(struct amdgpu_device<br>
&gt;&gt;&gt;&gt; *adev, struct drm_file *filp,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; entry =3D &amp;array[last_entry&#43;&#43;];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;robj =3D bo;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;priority =3D min(info=
[i].bo_priority,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_BO_LIST_MAX_PRIORITY);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;tv.bo =3D &amp;entry-=
&gt;robj-&gt;tbo;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;tv.shared =3D !entry-=
&gt;robj-&gt;prime_shared_count;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry-&gt;robj-&gt;preferred_domains =
=3D=3D<br>
&gt;&gt;&gt;&gt; AMDGPU_GEM_DOMAIN_GDS)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 list-&gt;gds_obj =3D entry-&gt;robj;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry-&gt;robj-&gt;preferred_domains =3D=3D=
<br>
&gt;&gt;&gt;&gt; AMDGPU_GEM_DOMAIN_GWS)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 list-&gt;gws_obj =3D entry-&gt;robj;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry-&gt;robj-&gt;preferred_domains =3D=3D=
<br>
&gt;&gt;&gt;&gt; AMDGPU_GEM_DOMAIN_OA)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 list-&gt;oa_obj =3D entry-&gt;robj;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_size &#43;=3D amdgpu_bo_s=
ize(entry-&gt;robj);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_bo_list_set(list, =
entry-&gt;robj);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list=
-&gt;first_userptr =3D first_userptr;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list=
-&gt;num_entries =3D num_entries;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trac=
e_amdgpu_cs_bo_status(list-&gt;num_entries, total_size);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *res=
ult =3D list;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h<b=
r>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h<br>
&gt;&gt;&gt;&gt; index 61b089768e1c..30f12a60aa28 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_lis=
t.h<br>
&gt;&gt;&gt;&gt; @@ -36,23 &#43;36,20 @@ struct amdgpu_bo_list_entry {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct ttm_validate_buffer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_bo_va&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; *bo_va;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priorit=
y;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **user_pages;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; user_invalidated;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_list {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct rcu_head rhead;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct kref refcount;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *gd=
s_obj;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *gw=
s_obj;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *oa=
_obj;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned first_userptr;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned num_entries;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int amdgpu_bo_list_get(struc=
t amdgpu_fpriv *fpriv, int id,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_bo_list **result);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; void amdgpu_bo_list_get_list(struct amdg=
pu_bo_list *list,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *validated)=
;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; void amdgpu_bo_list_put(struct amdgpu_bo=
_list *list);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_bo_create_list_entry_array(st=
ruct drm_amdgpu_bo_list_in<br>
&gt;&gt;&gt;&gt; *in,<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt;&gt;&gt;&gt; index 1081fd00b059..88b58facf29e 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<b=
r>
&gt;&gt;&gt;&gt; @@ -565,23 &#43;565,20 @@ static int amdgpu_cs_list_valida=
te(struct<br>
&gt;&gt;&gt;&gt; amdgpu_cs_parser *p,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static int amdgpu_cs_parser_=
bos(struct amdgpu_cs_parser *p,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union drm_=
amdgpu_cs *cs)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_fpriv *fpriv =3D p-&gt;filp-&gt;driver_priv;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vm *vm =3D &amp;fpriv-&gt;vm;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_bo_list_entry *e;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct list_head duplicates;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *gd=
s;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *gw=
s;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *oa=
;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned tries =3D 10;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT=
_LIST_HEAD(&amp;p-&gt;validated);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* p=
-&gt;bo_list could already be assigned if<br>
&gt;&gt;&gt;&gt; AMDGPU_CHUNK_ID_BO_HANDLES is present */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
cs-&gt;in.bo_list_handle) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;bo_list)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; @@ -705,40 &#43;702,23 @@ static int amd=
gpu_cs_parser_bos(struct<br>
&gt;&gt;&gt;&gt; amdgpu_cs_parser *p,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_cs_list_validate(p, &amp;p-&gt;validated);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;amdgpu_cs_list_=
validate(validated)<br>
&gt;&gt;&gt;&gt; failed.\n&quot;);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_validate;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_cs_report_moved_bytes(p-&gt;adev, p-&gt;bytes_moved,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; p-&gt;bytes_moved_vis);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; gds =3D p-&gt;=
bo_list-&gt;gds_obj;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws =3D p-&gt;bo_lis=
t-&gt;gws_obj;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oa =3D p-&gt;bo_list=
-&gt;oa_obj;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_bo_list_for_each_entry(e, p-&gt;bo_list)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e-&gt;bo_va =3D amdgpu_vm_bo_fi=
nd(vm, e-&gt;robj);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; if (gds) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;gds_base =3D amdgpu_bo_gpu_offset=
(gds);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;gds_size =3D amdgpu_bo_size(gds);=
<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gws) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;gws_base =3D amdgpu_bo_gpu_offset=
(gws);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;gws_size =3D amdgpu_bo_size(gws);=
<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (oa) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;oa_base =3D amdgpu_bo_gpu_offset(=
oa);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;oa_size =3D amdgpu_bo_size(oa);<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!r &amp;&amp; p-&gt;uf_entry.robj) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *uf =3D p-&gt;=
uf_entry.robj;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ttm_alloc_gart(&am=
p;uf-&gt;tbo);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;uf_addr &#43;=3D =
amdgpu_bo_gpu_offset(uf);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_validate:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_eu_backoff_reservation(&amp=
;p-&gt;ticket, &amp;p-&gt;validated);<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
&gt;&gt;&gt;&gt; index e73728d90388..69ba25c2e921 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<=
br>
&gt;&gt;&gt;&gt; @@ -17,48 &#43;17,33 @@<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * THE COPYRIGHT HOLDER(S) OR AUTHO=
R(S) BE LIABLE FOR ANY CLAIM,<br>
&gt;&gt;&gt;&gt; DAMAGES<br>
&gt;&gt;&gt;&gt; OR<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * OTHER LIABILITY, WHETHER IN AN A=
CTION OF CONTRACT, TORT OR<br>
&gt;&gt;&gt;&gt; OTHERWISE,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNE=
CTION WITH THE SOFTWARE OR THE USE<br>
&gt;&gt;&gt;&gt; OR<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<=
br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #ifndef __AMDGPU_GDS_H__<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define __AMDGPU_GDS_H__<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -/* Because TTM request that alloacted b=
uffer should be PAGE_SIZE<br>
&gt;&gt;&gt;&gt; aligned,<br>
&gt;&gt;&gt;&gt; - * we should report GDS/GWS/OA size as PAGE_SIZE aligned<=
br>
&gt;&gt;&gt;&gt; - * */<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_GDS_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 2<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_GWS_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PAGE_SHIFT<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_OA_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SHIFT<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; struct amdgpu_ring;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; struct amdgpu_bo;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gds_asic_info =
{<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_partition_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cs_partition_size;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gds {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_gds_asic_info&nbsp;&nbsp;&nbsp;&nbsp; mem;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_gds_asic_info&nbsp;&nbsp;&nbsp;&nbsp; gws;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_gds_asic_info&nbsp;&nbsp;&nbsp;&nbsp; oa;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* At present, GDS, =
GWS and OA resources for gfx (graphics)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is always pr=
e-allocated and available for graphics operation.<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Such resourc=
e is shared between all gfx clients.<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: move t=
his operation to user space<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo*&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; gds_gfx_bo;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo*&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; gws_gfx_bo;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo*&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; oa_gfx_bo;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gds_reg_offset=
 {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_base;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_size;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oa;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #endif /* __AMDGPU_GDS_H__ *=
/<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt;&gt;&gt; index d30a0838851b..c87ad4b4d0b6 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<=
br>
&gt;&gt;&gt;&gt; @@ -223,43 &#43;223,25 @@ int amdgpu_gem_create_ioctl(stru=
ct drm_device<br>
&gt;&gt;&gt;&gt; *dev,<br>
&gt;&gt;&gt;&gt; void *data,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
flags &amp; ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMDGPU_GEM_CREATE_NO_CPU_ACCESS |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMDGPU_GEM_CREATE_CPU_GTT_USWC |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMDGPU_GEM_CREATE_VRAM_CLEARED |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMDGPU_GEM_CREATE_EXPLICIT_SYNC))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* r=
eject invalid gem domains */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;in.doma=
ins &amp; ~AMDGPU_GEM_DOMAIN_MASK)<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;in.=
domains &amp; ~(AMDGPU_GEM_DOMAIN_CPU |<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAI=
N_GTT |<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAI=
N_VRAM))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; /* create a ge=
m object to contain this object in */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;in.doma=
ins &amp; (AMDGPU_GEM_DOMAIN_GDS |<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_GEM_CREATE_VM_ALWAYS_VAL=
ID) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* if gds bo is created from user space, it must<br>
&gt;&gt;&gt;&gt; be<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; * passed to bo list<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 DRM_ERROR(&quot;GDS bo cannot be per-vm-bo\n&quot;);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return -EINVAL;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;in.domains =3D=3D AMDGPU_GEM_DOMAI=
N_GDS)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 size =3D size &lt;&lt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; else if (args-&gt;in.domains =3D=3D AMDGPU_GEM_=
DOMAIN_GWS)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 size =3D size &lt;&lt; AMDGPU_GWS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; else if (args-&gt;in.domains =3D=3D AMDGPU_GEM_=
DOMAIN_OA)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 size =3D size &lt;&lt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return -EINVAL;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size=
 =3D roundup(size, PAGE_SIZE);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
flags &amp; AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(vm-&gt;=
root.base.bo, false);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv =3D vm-&gt;root.base.bo-&g=
t;tbo.resv;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/=
amdgpu_ids.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c<br>
&gt;&gt;&gt;&gt; index 3a072a7a39f0..c2e6a1a11d7f 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c<=
br>
&gt;&gt;&gt;&gt; @@ -516,26 &#43;516,20 @@ void amdgpu_vmid_free_reserved(s=
truct<br>
&gt;&gt;&gt;&gt; amdgpu_device<br>
&gt;&gt;&gt;&gt; *adev,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Reset saved GDW, GWS and OA to f=
orce switch on next flush.<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; void amdgpu_vmid_reset(struct amdgpu_dev=
ice *adev, unsigned vmhub,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned vmid)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vmid_mgr *id_mgr =3D<br>
&gt;&gt;&gt;&gt; &amp;adev-&gt;vm_manager.id_mgr[vmhub];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vmid *id =3D &amp;id_mgr-&gt;ids[vmid];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_lock(&amp;id_mgr-&gt;lock);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&=
gt;owner =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_base =3D =
0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_size =3D =
0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_base =3D =
0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_size =3D =
0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_base =3D 0=
;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_size =3D 0=
;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_unlock(&amp;id_mgr-&gt;lock);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_vmid_reset_all - reset VM=
ID to zero<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @adev: amdgpu device structure<b=
r>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Reset VMID to force flush on nex=
t use<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
&gt;&gt;&gt;&gt; index 7625419f0fc2..06078e665532 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<=
br>
&gt;&gt;&gt;&gt; @@ -44,27 &#43;44,20 @@ struct amdgpu_vmid {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_sync&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct dma_fence&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *last_flush;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; owner;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pd_gpu_addr;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* l=
ast flushed PD/PT update */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct dma_fence&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flushed_updates;<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; current_gpu_reset_count;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; gds_base;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gds_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gws_base;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gws_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; oa_base;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; oa_size;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pasid;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct dma_fence&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pasid_mapping;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmid_mgr {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lock;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; num_ids;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ids_lru;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vmid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ids[AMDGPU_NUM_VMID];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom=
ic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; reserved_vmid_num;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt;&gt;&gt;&gt; index 57cfe78a262b..3db553f6ad01 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<=
br>
&gt;&gt;&gt;&gt; @@ -42,23 &#43;42,20 @@ struct amdgpu_job {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_sync&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_sync;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_ib&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ibs;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct dma_fence&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fence; /* the hw fe=
nce */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; preamble_status;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; num_ibs;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *owner;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_needs_flush;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vm_pd_addr;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vmid;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pasid;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gds_base, gds_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gws_base, gws_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; oa_base, oa_size;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vram_lost_counter;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* u=
ser fence handling */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uf_addr;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uf_sequence;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int amdgpu_job_alloc(struct =
amdgpu_device *adev, unsigned num_ibs,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct amdgpu_job **job, struct amdgpu_vm *vm);<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt;&gt; index 29ac3873eeb0..209954290954 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<=
br>
&gt;&gt;&gt;&gt; @@ -517,27 &#43;517,27 @@ static int amdgpu_info_ioctl(str=
uct drm_device<br>
&gt;&gt;&gt;&gt; *dev,<br>
&gt;&gt;&gt;&gt; void *data, struct drm_file<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 AMDGPU_INFO_VIS_VRAM_USAGE:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui64 =3D<br>
&gt;&gt;&gt;&gt; amdgpu_vram_mgr_vis_usage(&amp;adev-&gt;mman.bdev.man[TTM_=
PL_VRAM]);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out, &amp;u=
i64, min(size, 8u)) ?<br>
&gt;&gt;&gt;&gt; -EFAULT :<br>
&gt;&gt;&gt;&gt; 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 AMDGPU_INFO_GTT_USAGE:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui64 =3D<br>
&gt;&gt;&gt;&gt; amdgpu_gtt_mgr_usage(&amp;adev-&gt;mman.bdev.man[TTM_PL_TT=
]);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out, &amp;u=
i64, min(size, 8u)) ?<br>
&gt;&gt;&gt;&gt; -EFAULT :<br>
&gt;&gt;&gt;&gt; 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 AMDGPU_INFO_GDS_CONFIG: {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_gds gds_=
info;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;gds_info, 0, sizeof=
(gds_info));<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gds_gfx_partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.gfx_partition_size &gt;&gt; AMDGPU_GDS_SH=
IFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.compute_partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.cs_partition_size &gt;&gt; AMDGPU_GDS_SHI=
FT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gds_total_size =3D adev-&gt;gds.mem.to=
tal_size &gt;&gt;<br>
&gt;&gt;&gt;&gt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gws_per_gfx_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.gfx_partition_size &gt;&gt; AMDGPU_GWS_SH=
IFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gws_per_compute_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.cs_partition_size &gt;&gt; AMDGPU_GWS_SHI=
FT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.oa_per_gfx_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.oa.gfx_partition_size &gt;&gt; AMDGPU_OA_SHIF=
T;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.oa_per_compute_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.oa.cs_partition_size &gt;&gt; AMDGPU_OA_SHIFT=
;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gds_gfx_partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.compute_partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gds_total_size =3D adev-&gt;gds.me=
m.total_size;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gws_per_gfx_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.gws_per_compute_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.oa_per_gfx_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.oa.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_info.oa_per_compute_partition =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.oa.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out, &amp;g=
ds_info,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; min((size_t)size,<br>
&gt;&gt;&gt;&gt; sizeof(gds_info))) ?<br>
&gt;&gt;&gt;&gt; -EFAULT : 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 AMDGPU_INFO_VRAM_GTT: {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_vram_gtt=
 vram_gtt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_gtt.vram_size =3D adev-&gt=
;gmc.real_vram_size -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; atomic64_read(&amp;adev-&gt;vram_pin_size);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_gtt.vram_cpu_accessible_si=
ze =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gmc.visible_vram_size -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; atomic64_read(&amp;adev-&gt;visible_pin_size);<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br=
>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;&gt;&gt; index de990bdcdd6c..76770a8c29a5 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object=
.c<br>
&gt;&gt;&gt;&gt; @@ -178,41 &#43;178,20 @@ void amdgpu_bo_placement_from_do=
main(struct<br>
&gt;&gt;&gt;&gt; amdgpu_bo *abo, u32 domain)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].lpfn =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags =3D TTM_PL_FLAG=
_SYSTEM;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_GEM_CREA=
TE_CPU_GTT_USWC)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; places[c].flags |=3D TTM_PL_FLAG_WC |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TTM_PL_FLA=
G_UNCACHED;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; places[c].flags |=3D TTM_PL_FLAG_CACHED;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&#43;&#43;;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; if (domain &am=
p; AMDGPU_GEM_DOMAIN_GDS) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].fpfn =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].lpfn =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags =3D TTM_PL_FLAG_UNCACHED |<br>
&gt;&gt;&gt;&gt; AMDGPU_PL_FLAG_GDS;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; c&#43;&#43;;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (domain &amp; AMD=
GPU_GEM_DOMAIN_GWS) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].fpfn =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].lpfn =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags =3D TTM_PL_FLAG_UNCACHED |<br>
&gt;&gt;&gt;&gt; AMDGPU_PL_FLAG_GWS;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; c&#43;&#43;;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (domain &amp; AMD=
GPU_GEM_DOMAIN_OA) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].fpfn =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].lpfn =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags =3D TTM_PL_FLAG_UNCACHED |<br>
&gt;&gt;&gt;&gt; AMDGPU_PL_FLAG_OA;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; c&#43;&#43;;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!c) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].fpfn =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].lpfn =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags =3D TTM_PL_MASK=
_CACHING |<br>
&gt;&gt;&gt;&gt; TTM_PL_FLAG_SYSTEM;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&#43;&#43;;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_=
ON(c &gt;=3D AMDGPU_BO_MAX_PLACEMENTS);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plac=
ement-&gt;num_placement =3D c;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br=
>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt;&gt;&gt;&gt; index 907fdf46d895..e089964cbcb7 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object=
.h<br>
&gt;&gt;&gt;&gt; @@ -120,26 &#43;120,20 @@ static inline struct amdgpu_bo<b=
r>
&gt;&gt;&gt;&gt; *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static inline unsigned amdgpu_mem_type_t=
o_domain(u32 mem_type)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swit=
ch (mem_type) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 TTM_PL_VRAM:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_GEM_DOMAIN_VRAM;<=
br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 TTM_PL_TT:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_GEM_DOMAIN_GTT;<b=
r>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 TTM_PL_SYSTEM:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_GEM_DOMAIN_CPU;<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PL_GDS:<=
br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_GEM_DOMAIN_GDS;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PL_GWS:<=
br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_GEM_DOMAIN_GWS;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PL_OA:<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_GEM_DOMAIN_OA;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defa=
ult:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_bo_reserve - reserve bo<b=
r>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @bo:&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo structure<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @no_intr:&nbsp; don't return -ER=
ESTARTSYS on pending signal<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt;&gt;&gt;&gt; index 9cc239968e40..f6ea9604e611 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h=
<br>
&gt;&gt;&gt;&gt; @@ -130,24 &#43;130,20 @@ struct amdgpu_ring_funcs {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* c=
ommand emit functions */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*emit_ib)(struct amdgpu_ring *ring,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; unsigned vmid, bool ctx_switch);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*emit_fence)(struct amdgpu_ring *ring, uint64_t addr,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t seq, unsigned flags);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*emit_pipeline_sync)(struct amdgpu_ring *ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*emit_vm_flush)(struct amdgpu_ring *ring, unsigned vmid,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pd_addr);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*emit_hdp_flush)(struct amdgpu_ring *ring);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*emit_gds_swit=
ch)(struct amdgpu_ring *ring, uint32_t vmid,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gds_base, uint32_=
t gds_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gws_base, uint32_=
t gws_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t oa_base, uint32_t=
 oa_size);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* t=
esting functions */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
(*test_ring)(struct amdgpu_ring *ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
(*test_ib)(struct amdgpu_ring *ring, long timeout);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* i=
nsert NOP packets */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*insert_nop)(struct amdgpu_ring *ring, uint32_t count);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*insert_start)(struct amdgpu_ring *ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*insert_end)(struct amdgpu_ring *ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* p=
ad the indirect buffer to the necessary number of dw */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 (*pad_ib)(struct amdgpu_ring *ring, struct amdgpu_ib *ib);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned (*init_cond_exec)(struct amdgpu_ring *ring);<br>
&gt;&gt;&gt;&gt; @@ -226,21 &#43;222,20 @@ struct amdgpu_ring {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_patch_cs_in_place(r,=
 p, ib)<br>
&gt;&gt;&gt;&gt; ((r)-&gt;funcs-&gt;patch_cs_in_place((p), (ib)))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_test_ring(r) (r)-&gt=
;funcs-&gt;test_ring((r))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_test_ib(r, t) (r)-&g=
t;funcs-&gt;test_ib((r), (t))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_get_rptr(r) (r)-&gt;=
funcs-&gt;get_rptr((r))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_get_wptr(r) (r)-&gt;=
funcs-&gt;get_wptr((r))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_set_wptr(r) (r)-&gt;=
funcs-&gt;set_wptr((r))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_ib(r, ib, vmid,=
 c) (r)-&gt;funcs-&gt;emit_ib((r),<br>
&gt;&gt;&gt;&gt; (ib), (vmid), (c))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_pipeline_sync(r=
)<br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_pipeline_sync((r))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_vm_flush(r, vmi=
d, addr)<br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_vm_flush((r), (vmid), (addr))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_fence(r, addr, =
seq, flags)<br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_fence((r), (addr), (seq), (flags))<=
br>
&gt;&gt;&gt;&gt; -#define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws,=
 ab, as)<br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_gds_switch((r), (v), (db), (ds), (w=
b), (ws), (ab),<br>
&gt;&gt;&gt;&gt; (as))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_hdp_flush(r) (r=
)-&gt;funcs-&gt;emit_hdp_flush((r))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_switch_buffer(r=
)<br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_switch_buffer((r))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_cntxcntl(r, d)<=
br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_cntxcntl((r),<br>
&gt;&gt;&gt;&gt; (d))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_rreg(r, d) (r)-=
&gt;funcs-&gt;emit_rreg((r), (d))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_wreg(r, d, v) (=
r)-&gt;funcs-&gt;emit_wreg((r),<br>
&gt;&gt;&gt;&gt; (d),<br>
&gt;&gt;&gt;&gt; (v))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_reg_wait(r, d, =
v, m)<br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_reg_wait((r), (d), (v), (m))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_reg_write_reg_w=
ait(r, d0, d1, v, m)<br>
&gt;&gt;&gt;&gt; (r)-&gt;funcs-&gt;emit_reg_write_reg_wait((r), (d0), (d1),=
 (v), (m))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_emit_tmz(r, b) (r)-&=
gt;funcs-&gt;emit_tmz((r), (b))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_pad_ib(r, ib) ((r)-&=
gt;funcs-&gt;pad_ib((r), (ib)))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define amdgpu_ring_init_cond_exec(r) (r=
)-&gt;funcs-&gt;init_cond_exec((r))<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt; index 8a158ee922f7..2cc62b0e7ea8 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<=
br>
&gt;&gt;&gt;&gt; @@ -195,30 &#43;195,20 @@ static int amdgpu_init_mem_type(=
struct<br>
&gt;&gt;&gt;&gt; ttm_bo_device<br>
&gt;&gt;&gt;&gt; *bdev, uint32_t type,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 TTM_PL_VRAM:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* &quot;On-card&quot; video ra=
m */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;func =3D &amp;amdgpu_vr=
am_mgr_func;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;gpu_offset =3D adev-&gt=
;gmc.vram_start;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;flags =3D TTM_MEMTYPE_F=
LAG_FIXED |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TTM_MEMTYPE_FLAG_MAPPABLE;<b=
r>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;available_caching =3D T=
TM_PL_FLAG_UNCACHED |<br>
&gt;&gt;&gt;&gt; TTM_PL_FLAG_WC;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;default_caching =3D TTM=
_PL_FLAG_WC;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PL_GDS:<=
br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PL_GWS:<=
br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PL_OA:<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* On-chip GDS memory*/<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;func =3D &amp;ttm_bo_manager_func;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;gpu_offset =3D 0;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;flags =3D TTM_MEMTYPE_FLAG_FIXED |<br>
&gt;&gt;&gt;&gt; TTM_MEMTYPE_FLAG_CMA;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;available_caching =3D TTM_PL_FLAG_UNCAC=
HED;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;default_caching =3D TTM_PL_FLAG_UNCACHE=
D;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defa=
ult:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unsupported mem=
ory type %u\n&quot;,<br>
&gt;&gt;&gt;&gt; (unsigned)type);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_evict_flags - Compute pla=
cement flags<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt; @@ -1039,25 &#43;1029,20 @@ static int amdgpu_ttm_backend_=
bind(struct ttm_tt<br>
&gt;&gt;&gt;&gt; *ttm,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to pin userptr\n&quot;);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!ttm-&gt;num_pages) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(1, &quot;nothing to bind %=
lu pages for mreg %p back<br>
&gt;&gt;&gt;&gt; %p!\n&quot;,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t=
tm-&gt;num_pages, bo_mem, ttm);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; if (bo_mem-&gt=
;mem_type =3D=3D AMDGPU_PL_GDS ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bo_mem-&gt;mem_type =3D=3D AMDGPU_PL_GWS ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bo_mem-&gt;mem_type =3D=3D AMDGPU_PL_OA)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!amdgpu_gtt_mgr_has_gart_addr(bo_mem)) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;offset =3D AMDGPU_BO_IN=
VALID_OFFSET;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* c=
ompute PTE flags relevant to this BO memory */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flag=
s =3D amdgpu_ttm_tt_pte_flags(adev, ttm, bo_mem);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* b=
ind pages into GART page tables */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-=
&gt;offset =3D ((u64)bo_mem-&gt;start &lt;&lt; PAGE_SHIFT) -<br>
&gt;&gt;&gt;&gt; adev-&gt;gmc.gart_start;<br>
&gt;&gt;&gt;&gt; @@ -1818,60 &#43;1803,20 @@ int amdgpu_ttm_init(struct amd=
gpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* I=
nitialize GTT memory pool */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, TTM_PL_TT, gtt_size &gt;&gt;<br=
>
&gt;&gt;&gt;&gt; PAGE_SHIFT);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed initiali=
zing GTT heap.\n&quot;);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_=
INFO(&quot;amdgpu: %uM of GTT memory ready.\n&quot;,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned)(gtt_size / (10=
24 * 1024)));<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize =
various on-chip memory pools */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.tot=
al_size =3D adev-&gt;gds.mem.total_size &lt;&lt;<br>
&gt;&gt;&gt;&gt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.gfx=
_partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.gfx_partition_size &lt;&lt; AMDGPU_GDS_SH=
IFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.cs_=
partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.cs_partition_size<br>
&gt;&gt;&gt;&gt; &lt;&lt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws.tot=
al_size =3D adev-&gt;gds.gws.total_size &lt;&lt;<br>
&gt;&gt;&gt;&gt; AMDGPU_GWS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws.gfx=
_partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.gfx_partition_size &lt;&lt; AMDGPU_GWS_SH=
IFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws.cs_=
partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.cs_partition_size<br>
&gt;&gt;&gt;&gt; &lt;&lt; AMDGPU_GWS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.tota=
l_size =3D adev-&gt;gds.oa.total_size &lt;&lt;<br>
&gt;&gt;&gt;&gt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.gfx_=
partition_size =3D<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.oa.gfx_partition_size<br>
&gt;&gt;&gt;&gt; &lt;&lt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.cs_p=
artition_size =3D adev-&gt;gds.oa.cs_partition_size<br>
&gt;&gt;&gt;&gt; &lt;&lt;<br>
&gt;&gt;&gt;&gt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GDS Memory */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gds.mem=
.total_size) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, A=
MDGPU_PL_GDS,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;gds.mem.total_size &gt;&gt;<br>
&gt;&gt;&gt;&gt; PAGE_SHIFT);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 DRM_ERROR(&quot;Failed initializing GDS heap.\n&quot;);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GWS */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gds.gws=
.total_size) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, A=
MDGPU_PL_GWS,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;gds.gws.total_size &gt;&gt;<br>
&gt;&gt;&gt;&gt; PAGE_SHIFT);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 DRM_ERROR(&quot;Failed initializing gws heap.\n&quot;);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* OA */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gds.oa.=
total_size) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, A=
MDGPU_PL_OA,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;gds.oa.total_size &gt;&gt;<br>
&gt;&gt;&gt;&gt; PAGE_SHIFT);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 DRM_ERROR(&quot;Failed initializing oa heap.\n&quot;);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* R=
egister debugfs entries for amdgpu_ttm */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ttm_debugfs_init(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to init =
debugfs\n&quot;);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt; @@ -1892,26 &#43;1837,20 @@ void amdgpu_ttm_fini(struct am=
dgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_ttm_debugfs_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_ttm_fw_reserve_vram_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
adev-&gt;mman.aper_base_kaddr)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iounmap(adev-&gt;mman.aper_base=
_kaddr);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;mman.aper_base_kaddr =3D NULL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_=
bo_clean_mm(&amp;adev-&gt;mman.bdev, TTM_PL_VRAM);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_=
bo_clean_mm(&amp;adev-&gt;mman.bdev, TTM_PL_TT);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gds.mem=
.total_size)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_clean_mm(&amp;adev-&gt;mman.bdev, AMDGPU=
_PL_GDS);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gds.gws=
.total_size)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_clean_mm(&amp;adev-&gt;mman.bdev, AMDGPU=
_PL_GWS);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gds.oa.=
total_size)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_clean_mm(&amp;adev-&gt;mman.bdev, AMDGPU=
_PL_OA);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_=
bo_device_release(&amp;adev-&gt;mman.bdev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_ttm_global_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;mman.initialized =3D false;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_=
INFO(&quot;amdgpu: ttm finalized\n&quot;);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_ttm_set_buffer_funcs_stat=
us - enable/disable use of buffer<br>
&gt;&gt;&gt;&gt; functions<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt;&gt;&gt; index fe8f276e9811..04557a382b19 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<=
br>
&gt;&gt;&gt;&gt; @@ -20,28 &#43;20,20 @@<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<=
br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #ifndef __AMDGPU_TTM_H__<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define __AMDGPU_TTM_H__<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #include &quot;amdgpu.h&quot=
;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #include &lt;drm/gpu_scheduler.h&gt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -#define AMDGPU_PL_GDS&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (T=
TM_PL_PRIV &#43; 0)<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_PL_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (TTM_PL_PRIV &#43; 1)<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_PL_OA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; (TTM_PL_PRIV &#43; 2)<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_PL_FLAG_GDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (TTM_PL_FLAG_PRIV &lt;&lt; 0)<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_PL_FLAG_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (TTM_PL_FLAG_PRIV &lt;&lt; 1)<br>
&gt;&gt;&gt;&gt; -#define AMDGPU_PL_FLAG_OA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (TTM_PL_FLAG_PRIV &lt;&lt; 2=
)<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define AMDGPU_GTT_MAX_TRANSFER_SIZE&nbs=
p; 512<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mman {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct ttm_bo_global_ref&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_global_re=
f;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct drm_global_reference&nbsp;&nbsp;&nbsp;&nbsp; mem_global_ref;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct ttm_bo_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; bdev;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; mem_global_referenced;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; initialized;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 __iomem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *aper_base_kaddr;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt;&gt; index be1659fedf94..c66f1c6f0ba8 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<b=
r>
&gt;&gt;&gt;&gt; @@ -803,86 &#43;803,69 @@ void amdgpu_vm_check_compute_bug=
(struct<br>
&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Returns:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * True if sync is needed.<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; bool amdgpu_vm_need_pipeline_sync(struct=
 amdgpu_ring *ring,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_job *job)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned vmhub =3D ring-&gt;funcs-&gt;vmhub;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vmid_mgr *id_mgr =3D<br>
&gt;&gt;&gt;&gt; &amp;adev-&gt;vm_manager.id_mgr[vmhub];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vmid *id;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gds_switch_need=
ed;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 vm_flush_needed =3D job-&gt;vm_needs_flush ||<br>
&gt;&gt;&gt;&gt; ring-&gt;has_compute_vm_bug;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
job-&gt;vmid =3D=3D 0)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =
=3D &amp;id_mgr-&gt;ids[job-&gt;vmid];<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_switch_needed =
=3D ring-&gt;funcs-&gt;emit_gds_switch &amp;&amp; (<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_base !=3D job-&gt;gds_base ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_size !=3D job-&gt;gds_size ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_base !=3D job-&gt;gws_base ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_size !=3D job-&gt;gws_size ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_base !=3D job-&gt;oa_base ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_size !=3D job-&gt;oa_size);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
amdgpu_vmid_had_gpu_reset(adev, id))<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; return vm_flus=
h_needed || gds_switch_needed;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vm_flush_=
needed;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_vm_flush - hardware flush=
 the vm<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @ring: ring to use for flush<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @job:&nbsp; related job<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @need_pipe_sync: is pipe sync ne=
eded<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Emit a VM flush when it is neces=
sary.<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Returns:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * 0 on success, errno otherwise.<b=
r>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_vm_flush(struct amdgpu_ring *=
ring, struct amdgpu_job *job,<br>
&gt;&gt;&gt;&gt; bool need_pipe_sync)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned vmhub =3D ring-&gt;funcs-&gt;vmhub;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vmid_mgr *id_mgr =3D<br>
&gt;&gt;&gt;&gt; &amp;adev-&gt;vm_manager.id_mgr[vmhub];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_vmid *id =3D &amp;id_mgr-&gt;ids[job-&gt;vmid];<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gds_switch_need=
ed =3D ring-&gt;funcs-&gt;emit_gds_switch &amp;&amp; (<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_base !=3D job-&gt;gds_base ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_size !=3D job-&gt;gds_size ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_base !=3D job-&gt;gws_base ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_size !=3D job-&gt;gws_size ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_base !=3D job-&gt;oa_base ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_size !=3D job-&gt;oa_size);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 vm_flush_needed =3D job-&gt;vm_needs_flush;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 pasid_mapping_needed =3D id-&gt;pasid !=3D job-&gt;pasid ||<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !id-&gt;pasid_mapping ||<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !dma_fence_is_signaled(id-&gt;p=
asid_mapping);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct dma_fence *fence =3D NULL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned patch_offset =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
amdgpu_vmid_had_gpu_reset(adev, id)) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gds_switch_needed =3D true;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_flush_needed =3D true;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasid_mapping_needed =3D true;<=
br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; gds_switch_nee=
ded &amp;=3D !!ring-&gt;funcs-&gt;emit_gds_switch;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_f=
lush_needed &amp;=3D !!ring-&gt;funcs-&gt;emit_vm_flush&nbsp; &amp;&amp;<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; job-&gt;vm_pd_addr !=3D AMDGPU_BO_INVALID_OFFSET;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasi=
d_mapping_needed &amp;=3D adev-&gt;gmc.gmc_funcs-&gt;emit_pasid_mapping<br>
&gt;&gt;&gt;&gt; &amp;&amp;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;funcs-&gt;emit_wreg;<b=
r>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; if (!vm_flush_=
needed &amp;&amp; !gds_switch_needed &amp;&amp; !need_pipe_sync)<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm_flush_ne=
eded &amp;&amp; !need_pipe_sync)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
ring-&gt;funcs-&gt;init_cond_exec)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; patch_offset =3D amdgpu_ring_in=
it_cond_exec(ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
need_pipe_sync)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_pipeline_sync(=
ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
vm_flush_needed) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_flush(ring, job=
-&gt;vmid,<br>
&gt;&gt;&gt;&gt; job-&gt;vm_pd_addr);<br>
&gt;&gt;&gt;&gt; @@ -907,33 &#43;890,20 @@ int amdgpu_vm_flush(struct amdgp=
u_ring *ring,<br>
&gt;&gt;&gt;&gt; struct<br>
&gt;&gt;&gt;&gt; amdgpu_job *job, bool need_<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;id_mgr-&gt;lo=
ck);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
pasid_mapping_needed) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;pasid =3D job-&gt;pasid;=
<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(id-&gt;pasid_mapp=
ing);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;pasid_mapping =3D dma_fe=
nce_get(fence);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_=
fence_put(fence);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;f=
uncs-&gt;emit_gds_switch &amp;&amp; gds_switch_needed) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_base =3D job-&gt;gds_base;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gds_size =3D job-&gt;gds_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_base =3D job-&gt;gws_base;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;gws_size =3D job-&gt;gws_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_base =3D job-&gt;oa_base;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;oa_size =3D job-&gt;oa_size;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_gds_switch(ring, job-&gt;vmid,=
<br>
&gt;&gt;&gt;&gt; job-&gt;gds_base,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;gds_size,<br>
&gt;&gt;&gt;&gt; job-&gt;gws_base,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;gws_size, job-&gt;oa_=
base,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;oa_size);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
ring-&gt;funcs-&gt;patch_cond_exec)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_patch_cond_exec(rin=
g, patch_offset);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* t=
he double SWITCH_BUFFER here *cannot* be skipped by<br>
&gt;&gt;&gt;&gt; COND_EXEC<br>
&gt;&gt;&gt;&gt; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
ring-&gt;funcs-&gt;emit_switch_buffer) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_switch_buffer(=
ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_switch_buffer(=
ring);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt;&gt;&gt;&gt; index a15d9c0f233b..f5228e169c3a 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br=
>
&gt;&gt;&gt;&gt; @@ -1890,21 &#43;1890,21 @@ static void gfx_v7_0_config_in=
it(struct<br>
&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * Configures the 3D engine and til=
ing configuration<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * registers so that the 3D engine =
is usable.<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static void gfx_v7_0_gpu_init(struct amd=
gpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
sh_mem_cfg, sh_static_mem_cfg, sh_mem_base;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
tmp;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, vmid;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmGRBM_CNTL, (0xff &lt;&lt; GRBM_CNTL__READ_TIMEOUT__SHIFT));<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmGB_ADDR_CONFIG, adev-&gt;gfx.config.gb_addr_config);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmHDP_ADDR_CONFIG, adev-&gt;gfx.config.gb_addr_config);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmDMIF_ADDR_CALC, adev-&gt;gfx.config.gb_addr_config);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v7_0_tiling_mode_table_init(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v7_0_setup_rb(adev);<br>
&gt;&gt;&gt;&gt; @@ -2014,20 &#43;2014,42 @@ static void gfx_v7_0_gpu_init(=
struct<br>
&gt;&gt;&gt;&gt; amdgpu_device<br>
&gt;&gt;&gt;&gt; *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D RREG32(mmSPI_ARB_PRIORITY);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS0, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS1, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS2, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS3, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmSPI_ARB_PRIORITY, tmp);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (vmid =
=3D 0; vmid &lt; AMDGPU_NUM_VMID; vmid&#43;&#43;) {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned gds_size, gws_size, oa_size;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmid &lt;<br>
&gt;&gt;&gt;&gt; adev-&gt;vm_manager.id_mgr[AMDGPU_GFXHUB].num_ids)<br>
&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gds_size =3D adev-&gt;gds.mem.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gws_size =3D adev-&gt;gds.gws.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; oa_size =3D adev-&gt;gds.oa.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gds_size =3D adev-&gt;gds.mem.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gws_size =3D adev-&gt;gds.gws.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; oa_size =3D adev-&gt;gds.oa.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].mem_base=
, vmid *<br>
&gt;&gt;&gt;&gt; gds_size);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].mem_size=
, gds_size);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].gws,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
vmid * gws_size) |<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
gws_size &lt;&lt; GDS_GWS_VMID0__SIZE__SHIFT));<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].oa,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
(1 &lt;&lt; oa_size) - 1) &lt;&lt; (vmid * oa_size));<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udel=
ay(50);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * GPU scratch registers helpers fu=
nction.<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * gfx_v7_0_scratch_init - setup dr=
iver info for CP scratch regs<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt;&gt;&gt;&gt; @@ -4157,68 &#43;4179,20 @@ static uint64_t<br>
&gt;&gt;&gt;&gt; gfx_v7_0_get_gpu_clock_counter(struct amdgpu_device *adev)=
<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t clock;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_lock(&amp;adev-&gt;gfx.gpu_clock_mutex);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cloc=
k =3D (uint64_t)RREG32(mmRLC_GPU_CLOCK_COUNT_LSB) |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)RREG32(mmRLC_GPU_CLO=
CK_COUNT_MSB) &lt;&lt; 32ULL);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_unlock(&amp;adev-&gt;gfx.gpu_clock_mutex);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn clock;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -static void gfx_v7_0_ring_emit_gds_swit=
ch(struct amdgpu_ring *ring,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gds_base, uint32_t<br>
&gt;&gt;&gt;&gt; gds_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gws_base, uint32_t<br>
&gt;&gt;&gt;&gt; gws_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t oa_base, uint32_t<br>
&gt;&gt;&gt;&gt; oa_size)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_base =3D gds_bas=
e &gt;&gt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_size =3D gds_siz=
e &gt;&gt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_base =3D gws_bas=
e &gt;&gt; AMDGPU_GWS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_size =3D gws_siz=
e &gt;&gt; AMDGPU_GWS_SHIFT;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oa_base =3D oa_base =
&gt;&gt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oa_size =3D oa_size =
&gt;&gt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GDS Base */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, PACKET3(PACKET3_WRITE_DATA, 3));<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, (WRITE_DATA_ENGINE_SEL(0) |<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, amdgpu_gds_reg_offset[vmid].mem_base);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, 0);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, gds_base);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GDS Size */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, PACKET3(PACKET3_WRITE_DATA, 3));<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, (WRITE_DATA_ENGINE_SEL(0) |<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, amdgpu_gds_reg_offset[vmid].mem_size);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, 0);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, gds_size);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GWS */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, PACKET3(PACKET3_WRITE_DATA, 3));<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, (WRITE_DATA_ENGINE_SEL(0) |<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, amdgpu_gds_reg_offset[vmid].gws);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, 0);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, gws_size &lt;&lt; GDS_GWS_VMID0__SIZE__SHIFT |<br>
&gt;&gt;&gt;&gt; gws_base);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* OA */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, PACKET3(PACKET3_WRITE_DATA, 3));<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, (WRITE_DATA_ENGINE_SEL(0) |<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, amdgpu_gds_reg_offset[vmid].oa);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, 0);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, (1 &lt;&lt; (oa_size &#43; oa_base)) - (1 &lt;&lt;<br>
&gt;&gt;&gt;&gt; oa_base));<br>
&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static void gfx_v7_0_ring_soft_recovery(=
struct amdgpu_ring *ring,<br>
&gt;&gt;&gt;&gt; unsigned vmid)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_device *adev =3D ring-&gt;adev;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t value =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; valu=
e =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; valu=
e =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; valu=
e =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; valu=
e =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmSQ_CMD, value);<br>
&gt;&gt;&gt;&gt; @@ -4584,55 &#43;4558,32 @@ static int gfx_v7_0_sw_init(vo=
id *handle)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ring_id,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, k,<br>
&gt;&gt;&gt;&gt; j);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_id&#4=
3;&#43;;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; /* reserve GDS=
, GWS and OA resource for gfx */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_crea=
te_kernel(adev,<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.gfx_partition_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PA=
GE_SIZE, AMDGPU_GEM_DOMAIN_GDS,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;adev-&gt;gds.gds_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_crea=
te_kernel(adev,<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.gfx_partition_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PA=
GE_SIZE, AMDGPU_GEM_DOMAIN_GWS,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;adev-&gt;gds.gws_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_crea=
te_kernel(adev,<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.oa.gfx_partition_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PA=
GE_SIZE, AMDGPU_GEM_DOMAIN_OA,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;adev-&gt;gds.oa_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;gfx.ce_ram_size =3D 0x8000;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v7_0_gpu_early_init(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static int gfx_v7_0_sw_fini(=
void *handle)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
i;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_device *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free=
_kernel(&amp;adev-&gt;gds.oa_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kerne=
l(&amp;adev-&gt;gds.gws_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kerne=
l(&amp;adev-&gt;gds.gds_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for =
(i =3D 0; i &lt; adev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;=
gfx.gfx_ring[i]);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for =
(i =3D 0; i &lt; adev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;=
gfx.compute_ring[i]);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v7_0_cp_compute_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v7_0_rlc_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v7_0_mec_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_bo_free_kernel(&amp;adev-&gt;gfx.rlc.clear_state_obj,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-=
&gt;gfx.rlc.clear_state_gpu_addr,<br>
&gt;&gt;&gt;&gt; @@ -5073,64 &#43;5024,60 @@ static const struct amd_ip_fun=
cs<br>
&gt;&gt;&gt;&gt; gfx_v7_0_ip_funcs<br>
&gt;&gt;&gt;&gt; =3D {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const struct amdgpu_r=
ing_funcs gfx_v7_0_ring_funcs_gfx =3D {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .typ=
e =3D AMDGPU_RING_TYPE_GFX,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ali=
gn_mask =3D 0xff,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .nop=
 =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sup=
port_64bit_ptrs =3D false,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get=
_rptr =3D gfx_v7_0_ring_get_rptr,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get=
_wptr =3D gfx_v7_0_ring_get_wptr_gfx,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set=
_wptr =3D gfx_v7_0_ring_set_wptr_gfx,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_frame_size =3D<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 20 &#43; /* gfx_v7_0_ring_emit_gds_switch */<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 &#43; /* gfx_v7_0_ring_emit_h=
dp_flush */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 &#43; /* hdp invalidate */<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12 &#43; 12 &#43; 12 &#43; /* g=
fx_v7_0_ring_emit_fence_gfx x3 for<br>
&gt;&gt;&gt;&gt; user<br>
&gt;&gt;&gt;&gt; fence, vm fence */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 &#43; 4 &#43; /* gfx_v7_0_rin=
g_emit_pipeline_sync */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CIK_FLUSH_GPU_TLB_NUM_WREG * 5 =
&#43; 7 &#43; 6 &#43; /*<br>
&gt;&gt;&gt;&gt; gfx_v7_0_ring_emit_vm_flush */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 &#43; 4, /* gfx_v7_ring_emit_=
cntxcntl including vgt<br>
&gt;&gt;&gt;&gt; flush*/<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_ib_size =3D 4, /* gfx_v7_0_ring_emit_ib_gfx */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_ib =3D gfx_v7_0_ring_emit_ib_gfx,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_fence =3D gfx_v7_0_ring_emit_fence_gfx,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_pipeline_sync =3D gfx_v7_0_ring_emit_pipeline_sync,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_vm_flush =3D gfx_v7_0_ring_emit_vm_flush,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_gds_switch =3D=
 gfx_v7_0_ring_emit_gds_switch,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_hdp_flush =3D gfx_v7_0_ring_emit_hdp_flush,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tes=
t_ring =3D gfx_v7_0_ring_test_ring,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tes=
t_ib =3D gfx_v7_0_ring_test_ib,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ins=
ert_nop =3D amdgpu_ring_insert_nop,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad=
_ib =3D amdgpu_ring_generic_pad_ib,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_cntxcntl =3D gfx_v7_ring_emit_cntxcntl,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_wreg =3D gfx_v7_0_ring_emit_wreg,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sof=
t_recovery =3D gfx_v7_0_ring_soft_recovery,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const struct amdgpu_r=
ing_funcs gfx_v7_0_ring_funcs_compute =3D<br>
&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .typ=
e =3D AMDGPU_RING_TYPE_COMPUTE,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ali=
gn_mask =3D 0xff,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .nop=
 =3D PACKET3(PACKET3_NOP, 0x3FFF),<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sup=
port_64bit_ptrs =3D false,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get=
_rptr =3D gfx_v7_0_ring_get_rptr,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get=
_wptr =3D gfx_v7_0_ring_get_wptr_compute,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set=
_wptr =3D gfx_v7_0_ring_set_wptr_compute,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_frame_size =3D<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 20 &#43; /* gfx_v7_0_ring_emit_gds_switch */<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 &#43; /* gfx_v7_0_ring_emit_h=
dp_flush */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 &#43; /* hdp invalidate */<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 &#43; /* gfx_v7_0_ring_emit_p=
ipeline_sync */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CIK_FLUSH_GPU_TLB_NUM_WREG * 5 =
&#43; 7 &#43; /*<br>
&gt;&gt;&gt;&gt; gfx_v7_0_ring_emit_vm_flush */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 &#43; 7 &#43; 7, /* gfx_v7_0_=
ring_emit_fence_compute x3 for<br>
&gt;&gt;&gt;&gt; user<br>
&gt;&gt;&gt;&gt; fence, vm fence */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_ib_size =3D 4, /* gfx_v7_0_ring_emit_ib_compute */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_ib =3D gfx_v7_0_ring_emit_ib_compute,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_fence =3D gfx_v7_0_ring_emit_fence_compute,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_pipeline_sync =3D gfx_v7_0_ring_emit_pipeline_sync,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_vm_flush =3D gfx_v7_0_ring_emit_vm_flush,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_gds_switch =3D=
 gfx_v7_0_ring_emit_gds_switch,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_hdp_flush =3D gfx_v7_0_ring_emit_hdp_flush,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tes=
t_ring =3D gfx_v7_0_ring_test_ring,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tes=
t_ib =3D gfx_v7_0_ring_test_ib,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ins=
ert_nop =3D amdgpu_ring_insert_nop,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad=
_ib =3D amdgpu_ring_generic_pad_ib,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emi=
t_wreg =3D gfx_v7_0_ring_emit_wreg,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void gfx_v7_0_set_rin=
g_funcs(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt; @@ -5169,42 &#43;5116,28 @@ static void gfx_v7_0_set_irq_f=
uncs(struct<br>
&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;gfx.priv_inst_irq.funcs =3D &amp;gfx_v7_0_priv_inst_irq_funcs;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void gfx_v7_0_set_gds=
_init(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* i=
nit asci gds info */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;gds.mem.total_size =3D RREG32(mmGDS_VMID0_SIZE);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;gds.gws.total_size =3D 64;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;gds.oa.total_size =3D 16;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;g=
ds.mem.total_size =3D=3D 64 * 1024) {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.gfx_partition_size =3D 4096;<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.cs_partition_size =3D 4096;<br=
>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws.gfx_partition_size =3D 4;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws.cs_partition_size =3D 4;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.gfx_partition_size =3D 4;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.cs_partition_size =3D 1;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.gfx_partition_size =3D 1024;<b=
r>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.cs_partition_size =3D 1024;<br=
>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws.gfx_partition_size =3D 16;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws.cs_partition_size =3D 16;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.gfx_partition_size =3D 4;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.cs_partition_size =3D 4;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem=
.gfx_size_per_vmid =3D adev-&gt;gds.mem.total_size /<br>
&gt;&gt;&gt;&gt; AMDGPU_NUM_VMID;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem=
.kfd_size_per_vmid =3D adev-&gt;gds.mem.total_size /<br>
&gt;&gt;&gt;&gt; AMDGPU_NUM_VMID;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws=
.gfx_size_per_vmid =3D adev-&gt;gds.gws.total_size /<br>
&gt;&gt;&gt;&gt; AMDGPU_NUM_VMID;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gws=
.kfd_size_per_vmid =3D adev-&gt;gds.gws.total_size /<br>
&gt;&gt;&gt;&gt; AMDGPU_NUM_VMID;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.=
gfx_size_per_vmid =3D adev-&gt;gds.oa.total_size / 8; /*<br>
&gt;&gt;&gt;&gt; gfx only */<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.oa.=
kfd_size_per_vmid =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static void gfx_v7_0_get_cu_info(struct =
amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
i, j, k, counter, active_cu_number =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
mask, bitmap, ao_bitmap, ao_cu_mask =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_cu_info *cu_info =3D &amp;adev-&gt;gfx.cu_info;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsi=
gned disable_masks[4 * 2];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
ao_cu_num;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
adev-&gt;flags &amp; AMD_IS_APU)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ao_cu_num =3D 2;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt;&gt;&gt;&gt; index 3882689b2d8f..b11a54bd0668 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br=
>
&gt;&gt;&gt;&gt; @@ -2154,57 &#43;2154,34 @@ static int gfx_v8_0_sw_init(vo=
id *handle)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq =
=3D &amp;adev-&gt;gfx.kiq;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_gfx_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* c=
reate MQD for all compute queues as well as KIQ for SRIOV<br>
&gt;&gt;&gt;&gt; case<br>
&gt;&gt;&gt;&gt; */<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_gfx_compute_mqd_sw_init(adev, sizeof(struct<br>
&gt;&gt;&gt;&gt; vi_mqd_allocation));<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; /* reserve GDS=
, GWS and OA resource for gfx */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_crea=
te_kernel(adev,<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.mem.gfx_partition_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PA=
GE_SIZE, AMDGPU_GEM_DOMAIN_GDS,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;adev-&gt;gds.gds_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_crea=
te_kernel(adev,<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.gws.gfx_partition_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PA=
GE_SIZE, AMDGPU_GEM_DOMAIN_GWS,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;adev-&gt;gds.gws_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_crea=
te_kernel(adev,<br>
&gt;&gt;&gt;&gt; adev-&gt;gds.oa.gfx_partition_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PA=
GE_SIZE, AMDGPU_GEM_DOMAIN_OA,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;adev-&gt;gds.oa_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;gfx.ce_ram_size =3D 0x8000;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v8_0_gpu_early_init(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static int gfx_v8_0_sw_fini(=
void *handle)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
i;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_device *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free=
_kernel(&amp;adev-&gt;gds.oa_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kerne=
l(&amp;adev-&gt;gds.gws_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kerne=
l(&amp;adev-&gt;gds.gds_gfx_bo, NULL, NULL);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for =
(i =3D 0; i &lt; adev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;=
gfx.gfx_ring[i]);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for =
(i =3D 0; i &lt; adev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;=
gfx.compute_ring[i]);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_gfx_compute_mqd_sw_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_gfx_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring,<br>
&gt;&gt;&gt;&gt; &amp;adev-&gt;gfx.kiq.irq);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_gfx_kiq_fini(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v8_0_mec_fini(adev);<br>
&gt;&gt;&gt;&gt; @@ -3850,21 &#43;3827,21 @@ static void gfx_v8_0_config_in=
it(struct<br>
&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 CHIP_CARRIZO:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 CHIP_STONEY:<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.double_offc=
hip_lds_buf =3D 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void gfx_v8_0_gpu_ini=
t(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
tmp, sh_static_mem_cfg;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, vmid;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32_FIELD(GRBM_CNTL, READ_TIMEOUT, 0xFF);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmGB_ADDR_CONFIG, adev-&gt;gfx.config.gb_addr_config);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmHDP_ADDR_CONFIG, adev-&gt;gfx.config.gb_addr_config);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmDMIF_ADDR_CALC, adev-&gt;gfx.config.gb_addr_config);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v8_0_tiling_mode_table_init(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v8_0_setup_rb(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v8_0_get_cu_info(adev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
v8_0_config_init(adev);<br>
&gt;&gt;&gt;&gt; @@ -3927,20 &#43;3904,41 @@ static void gfx_v8_0_gpu_init(=
struct<br>
&gt;&gt;&gt;&gt; amdgpu_device<br>
&gt;&gt;&gt;&gt; *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D RREG32(mmSPI_ARB_PRIORITY);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS0, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS1, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS2, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D REG_SET_FIELD(tmp, SPI_ARB_PRIORITY, PIPE_ORDER_TS3, 2);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmSPI_ARB_PRIORITY, tmp);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (vmid =
=3D 0; vmid &lt; AMDGPU_NUM_VMID; vmid&#43;&#43;) {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned gds_size, gws_size, oa_size;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmid &lt;<br>
&gt;&gt;&gt;&gt; adev-&gt;vm_manager.id_mgr[AMDGPU_GFXHUB].num_ids)<br>
&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gds_size =3D adev-&gt;gds.mem.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gws_size =3D adev-&gt;gds.gws.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; oa_size =3D adev-&gt;gds.oa.gfx_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gds_size =3D adev-&gt;gds.mem.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; gws_size =3D adev-&gt;gds.gws.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; oa_size =3D adev-&gt;gds.oa.kfd_size_per_vmid;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].mem_base=
, vmid *<br>
&gt;&gt;&gt;&gt; gds_size);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].mem_size=
, gds_size);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].gws,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
vmid * gws_size) |<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
gws_size &lt;&lt; GDS_GWS_VMID0__SIZE__SHIFT));<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(amdgpu_gds_reg_offset[vmid].oa,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
(1 &lt;&lt; oa_size) - 1) &lt;&lt; (vmid * oa_size));<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void gfx_v8_0_wait_fo=
r_rlc_serdes(struct amdgpu_device<br>
&gt;&gt;&gt;&gt; *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
i, j, k;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
mask;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_lock(&amp;adev-&gt;grbm_idx_mutex);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for =
(i =3D 0; i &lt; adev-&gt;gfx.config.max_shader_engines; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;g=
fx.config.max_sh_per_se; j&#43;&#43;) {<br>
&gt;&gt;&gt;&gt; @@ -5383,68 &#43;5381,20 @@ static uint64_t<br>
&gt;&gt;&gt;&gt; gfx_v8_0_get_gpu_clock_counter(struct amdgpu_device *adev)=
<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t clock;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_lock(&amp;adev-&gt;gfx.gpu_clock_mutex);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG=
32(mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cloc=
k =3D (uint64_t)RREG32(mmRLC_GPU_CLOCK_COUNT_LSB) |<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)RREG32(mmRLC_GPU_CLO=
CK_COUNT_MSB) &lt;&lt; 32ULL);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute=
x_unlock(&amp;adev-&gt;gfx.gpu_clock_mutex);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn clock;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; -static void gfx_v8_0_ring_emit_gds_swit=
ch(struct amdgpu_ring *ring,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gds_base, uint32_t<br>
&gt;&gt;&gt;&gt; gds_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gws_base, uint32_t<br>
&gt;&gt;&gt;&gt; gws_size,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t oa_base, uint32_t<br>
&gt;&gt;&gt;&gt; oa_size)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_base =3D gds_bas=
e &gt;&gt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_size =3D gds_siz=
e &gt;&gt; AMDGPU_GDS_SHIFT;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_base =3D gws_bas=
e &gt;&gt; AMDGPU_GWS_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_size =3D gws_siz=
e &gt;&gt; AMDGPU_GWS_SHIFT;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oa_base =3D oa_base =
&gt;&gt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oa_size =3D oa_size =
&gt;&gt; AMDGPU_OA_SHIFT;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GDS Base */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, PACKET3(PACKET3_WRITE_DATA, 3));<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ri=
ng, (WRITE_DATA_ENGINE_SEL(0) |<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180977B44E93B5357C5145B3F71A0BN6PR12MB1809namp_--

--===============1886138055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1886138055==--
