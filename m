From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Tue, 28 Feb 2017 09:46:54 +0800
Message-ID: <58B4D68E.5080606@amd.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
 <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
 <a25fdfeb-be5d-2d23-d7b1-ef14891ba6d5@gmail.com>
 <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050002060306040803050803"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

--------------050002060306040803050803
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

The attached is our semaphore implementation, amdgpu_cs.c is drm file, 
the others are kernel file.
Any suggestion?

Regards,
David Zhou

On 2017年02月28日 03:36, Dave Airlie wrote:
> Hi,
>
> Any further news on these?
>
> Dave.
>
> On 6 January 2017 at 03:48, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Cool, thanks for the heads up David.
>>
>>
>> Regards,
>>
>> Andres
>>
>>
>> On 1/4/2017 11:13 PM, Mao, David wrote:
>>
>> Hi Andres,
>>
>> We have a local change made yesterday which eliminate the need to get unused
>> fd in the creation time.
>>
>> If everything goes well, I expect the change could be sent out for review
>> next week.
>>
>>
>>
>> Best Regards,
>>
>> David
>>
>>
>>
>> From: Andres Rodriguez [mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org]
>> Sent: Thursday, January 5, 2017 12:10 PM
>> To: Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; Mao, David
>> <David.Mao-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>> Cc: Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>; Dave Airlie
>> <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: Shared semaphores for amdgpu
>>
>>
>>
>> Hey guys,
>>
>> Just curious if there are any updates on the topic of shared semaphores for
>> amdgpu discussed here:
>> https://lists.freedesktop.org/archives/amd-gfx/2016-December/003777.html
>>
>> I wasn't subscribed to amd-gfx yet when the topic started, so replying to it
>> directly is cumbersome.
>>
>> Regards,
>> Andres
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>


--------------050002060306040803050803
Content-Type: text/x-csrc; name="amdgpu_sem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="amdgpu_sem.c"

/*
 * Copyright 2016 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * Authors:
 *    Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
 */
#include <linux/file.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/poll.h>
#include <linux/seq_file.h>
#include <linux/export.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/uaccess.h>
#include <linux/anon_inodes.h>
#include "amdgpu_sem.h"
#include "amdgpu.h"
#include <drm/drmP.h>

static int amdgpu_sem_cring_add(struct amdgpu_fpriv *fpriv,
				struct drm_amdgpu_sem_in *in,
				struct amdgpu_sem *sem);

static void amdgpu_sem_core_free(struct kref *kref)
{
	struct amdgpu_sem_core *core = container_of(
		kref, struct amdgpu_sem_core, kref);

	if (core->file)
		fput(core->file);

	fence_put(core->fence);
	mutex_destroy(&core->lock);
	kfree(core);
}

static void amdgpu_sem_free(struct kref *kref)
{
	struct amdgpu_sem *sem = container_of(
		kref, struct amdgpu_sem, kref);

	list_del(&sem->list);
	kref_put(&sem->base->kref, amdgpu_sem_core_free);
	kfree(sem);
}

static inline void amdgpu_sem_get(struct amdgpu_sem *sem)
{
	if (sem)
		kref_get(&sem->kref);
}

static inline void amdgpu_sem_put(struct amdgpu_sem *sem)
{
	if (sem)
		kref_put(&sem->kref, amdgpu_sem_free);
}

static int amdgpu_sem_release(struct inode *inode, struct file *file)
{
	struct amdgpu_sem_core *core = file->private_data;

	kref_put(&core->kref, amdgpu_sem_core_free);
	return 0;
}

static unsigned int amdgpu_sem_poll(struct file *file, poll_table *wait)
{
	return 0;
}

static long amdgpu_sem_file_ioctl(struct file *file, unsigned int cmd,
				   unsigned long arg)
{
	return 0;
}

static const struct file_operations amdgpu_sem_fops = {
	.release = amdgpu_sem_release,
	.poll = amdgpu_sem_poll,
	.unlocked_ioctl = amdgpu_sem_file_ioctl,
	.compat_ioctl = amdgpu_sem_file_ioctl,
};


static inline struct amdgpu_sem *amdgpu_sem_lookup(struct amdgpu_fpriv *fpriv, u32 handle)
{
	struct amdgpu_sem *sem;

	spin_lock(&fpriv->sem_handles_lock);

	/* Check if we currently have a reference on the object */
	sem = idr_find(&fpriv->sem_handles, handle);
	amdgpu_sem_get(sem);

	spin_unlock(&fpriv->sem_handles_lock);

	return sem;
}

static struct amdgpu_sem_core *amdgpu_sem_core_alloc(void)
{
	struct amdgpu_sem_core *core;

	core = kzalloc(sizeof(*core), GFP_KERNEL);
	if (!core)
		return NULL;

	kref_init(&core->kref);
	mutex_init(&core->lock);
	return core;
}

static struct amdgpu_sem *amdgpu_sem_alloc(void)
{
	struct amdgpu_sem *sem;

	sem = kzalloc(sizeof(*sem), GFP_KERNEL);
	if (!sem)
		return NULL;

	kref_init(&sem->kref);
	INIT_LIST_HEAD(&sem->list);

	return sem;
}

static int amdgpu_sem_create(struct amdgpu_fpriv *fpriv, u32 *handle)
{
	struct amdgpu_sem *sem;
	struct amdgpu_sem_core *core;
	int ret;

	sem = amdgpu_sem_alloc();
	core = amdgpu_sem_core_alloc();
	if (!sem || !core) {
		kfree(sem);
		kfree(core);
		return -ENOMEM;
	}

	sem->base = core;

	idr_preload(GFP_KERNEL);
	spin_lock(&fpriv->sem_handles_lock);

	ret = idr_alloc(&fpriv->sem_handles, sem, 1, 0, GFP_NOWAIT);

	spin_unlock(&fpriv->sem_handles_lock);
	idr_preload_end();

	if (ret < 0)
		return ret;

	*handle = ret;
	return 0;
}

static int amdgpu_sem_signal(struct amdgpu_fpriv *fpriv,
				u32 handle, struct fence *fence)
{
	struct amdgpu_sem *sem;
	struct amdgpu_sem_core *core;

	sem = amdgpu_sem_lookup(fpriv, handle);
	if (!sem)
		return -EINVAL;

	core = sem->base;
	mutex_lock(&core->lock);
	fence_put(core->fence);
	core->fence = fence_get(fence);
	mutex_unlock(&core->lock);

	amdgpu_sem_put(sem);
	return 0;
}

static int amdgpu_sem_wait(struct amdgpu_fpriv *fpriv,
			  struct drm_amdgpu_sem_in *in)
{
	struct amdgpu_sem *sem;
	int ret;

	sem = amdgpu_sem_lookup(fpriv, in->handle);
	if (!sem)
		return -EINVAL;

	ret = amdgpu_sem_cring_add(fpriv, in, sem);
	amdgpu_sem_put(sem);

	return ret;
}

static int amdgpu_sem_import(struct amdgpu_fpriv *fpriv,
				       int fd, u32 *handle)
{
	struct file *file = fget(fd);
	struct amdgpu_sem *sem;
	struct amdgpu_sem_core *core;
	int ret;

	if (!file)
		return -EINVAL;

	core = file->private_data;
	if (!core) {
		fput(file);
		return -EINVAL;
	}

	mutex_lock(&core->lock);
	kref_get(&core->kref);
	mutex_unlock(&core->lock);
	sem = amdgpu_sem_alloc();
	if (!sem) {
		ret = -ENOMEM;
		goto err_sem;
	}

	sem->base = core;

	idr_preload(GFP_KERNEL);
	spin_lock(&fpriv->sem_handles_lock);

	ret = idr_alloc(&fpriv->sem_handles, sem, 1, 0, GFP_NOWAIT);

	spin_unlock(&fpriv->sem_handles_lock);
	idr_preload_end();

	if (ret < 0)
		goto err_out;

	*handle = ret;
	fput(file);
	return 0;
err_sem:
	kref_put(&core->kref, amdgpu_sem_core_free);
err_out:
	amdgpu_sem_put(sem);
	fput(file);
	return ret;

}

static int amdgpu_sem_export(struct amdgpu_fpriv *fpriv,
				       u32 handle, int *fd)
{
	struct amdgpu_sem *sem;
	struct amdgpu_sem_core *core;
	int ret;

	sem = amdgpu_sem_lookup(fpriv, handle);
	if (!sem)
		return -EINVAL;

	core = sem->base;
	mutex_lock(&core->lock);
	if (!core->file) {
		core->file = anon_inode_getfile("sem_file",
					       &amdgpu_sem_fops,
					       core, 0);
		if (IS_ERR(core->file)) {
			mutex_unlock(&core->lock);
			ret = -ENOMEM;
			goto err_put_sem;
		}
	}
	kref_get(&core->kref);
	mutex_unlock(&core->lock);

	ret = get_unused_fd_flags(O_CLOEXEC);
	if (ret < 0)
		goto err_put_file;

	fd_install(ret, core->file);

	*fd = ret;
	amdgpu_sem_put(sem);
	return 0;

err_put_file:
	kref_put(&core->kref, amdgpu_sem_core_free);
	fput(core->file);
err_put_sem:
	amdgpu_sem_put(sem);
	return ret;
}

void amdgpu_sem_destroy(struct amdgpu_fpriv *fpriv, u32 handle)
{
	struct amdgpu_sem *sem = amdgpu_sem_lookup(fpriv, handle);
	if (!sem)
		return;

	spin_lock(&fpriv->sem_handles_lock);
	idr_remove(&fpriv->sem_handles, handle);
	spin_unlock(&fpriv->sem_handles_lock);

	kref_sub(&sem->kref, 2, amdgpu_sem_free);
}

static struct fence *amdgpu_sem_get_fence(struct amdgpu_fpriv *fpriv,
					 struct drm_amdgpu_sem_in *in)
{
	struct amdgpu_ring *out_ring;
	struct amdgpu_ctx *ctx;
	struct fence *fence;
	uint32_t ctx_id, ip_type, ip_instance, ring;
	int r;

	ctx_id = in->ctx_id;
	ip_type = in->ip_type;
	ip_instance = in->ip_instance;
	ring = in->ring;
	ctx = amdgpu_ctx_get(fpriv, ctx_id);
	if (!ctx)
		return NULL;
	r = amdgpu_cs_get_ring(ctx->adev, ip_type, ip_instance, ring,
			       &out_ring);
	if (r) {
		amdgpu_ctx_put(ctx);
		return NULL;
	}
	/* get the last fence of this entity */
	fence = amdgpu_ctx_get_fence(ctx, out_ring,
				     in->seq ? in->seq :
				     ctx->rings[out_ring->idx].sequence - 1);
	amdgpu_ctx_put(ctx);

	return fence;
}

static int amdgpu_sem_cring_add(struct amdgpu_fpriv *fpriv,
				struct drm_amdgpu_sem_in *in,
				struct amdgpu_sem *sem)
{
	struct amdgpu_ring *out_ring;
	struct amdgpu_ctx *ctx;
	uint32_t ctx_id, ip_type, ip_instance, ring;
	int r;

	ctx_id = in->ctx_id;
	ip_type = in->ip_type;
	ip_instance = in->ip_instance;
	ring = in->ring;
	ctx = amdgpu_ctx_get(fpriv, ctx_id);
	if (!ctx)
		return -EINVAL;
	r = amdgpu_cs_get_ring(ctx->adev, ip_type, ip_instance, ring,
			       &out_ring);
	if (r)
		goto err;
	mutex_lock(&ctx->rings[out_ring->idx].sem_lock);
	list_add(&sem->list, &ctx->rings[out_ring->idx].sem_list);
	mutex_unlock(&ctx->rings[out_ring->idx].sem_lock);

err:
	amdgpu_ctx_put(ctx);
	return r;
}

int amdgpu_sem_add_cs(struct amdgpu_ctx *ctx, struct amdgpu_ring *ring,
		     struct amdgpu_sync *sync)
{
	struct amdgpu_sem *sem, *tmp;
	int r = 0;

	if (list_empty(&ctx->rings[ring->idx].sem_list))
		return 0;

	mutex_lock(&ctx->rings[ring->idx].sem_lock);
	list_for_each_entry_safe(sem, tmp, &ctx->rings[ring->idx].sem_list,
				 list) {
		r = amdgpu_sync_fence(ctx->adev, sync, sem->base->fence);
		if (r)
			goto err;
		mutex_lock(&sem->base->lock);
		fence_put(sem->base->fence);
		sem->base->fence = NULL;
		mutex_unlock(&sem->base->lock);
		list_del_init(&sem->list);
	}
err:
	mutex_unlock(&ctx->rings[ring->idx].sem_lock);
	return r;
}

int amdgpu_sem_ioctl(struct drm_device *dev, void *data,
		     struct drm_file *filp)
{
	union drm_amdgpu_sem *args = data;
	struct amdgpu_fpriv *fpriv = filp->driver_priv;
	struct fence *fence;
	int r = 0;

	switch (args->in.op) {
	case AMDGPU_SEM_OP_CREATE_SEM:
		r = amdgpu_sem_create(fpriv, &args->out.handle);
		break;
	case AMDGPU_SEM_OP_WAIT_SEM:
		r = amdgpu_sem_wait(fpriv, &args->in);
		break;
	case AMDGPU_SEM_OP_SIGNAL_SEM:
		fence = amdgpu_sem_get_fence(fpriv, &args->in);
		if (IS_ERR(fence)) {
			r = PTR_ERR(fence);
			return r;
		}
		r = amdgpu_sem_signal(fpriv, args->in.handle, fence);
		fence_put(fence);
		break;
	case AMDGPU_SEM_OP_IMPORT_SEM:
		r = amdgpu_sem_import(fpriv, args->in.handle, &args->out.handle);
		break;
	case AMDGPU_SEM_OP_EXPORT_SEM:
		r = amdgpu_sem_export(fpriv, args->in.handle, &args->out.fd);
		break;
	case AMDGPU_SEM_OP_DESTROY_SEM:
		amdgpu_sem_destroy(fpriv, args->in.handle);
		break;
	default:
		r = -EINVAL;
		break;
	}

	return r;
}

--------------050002060306040803050803
Content-Type: text/x-chdr; name="amdgpu_sem.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="amdgpu_sem.h"

/*
 * Copyright 2016 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * Authors: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
 *
 */


#ifndef _LINUX_AMDGPU_SEM_H
#define _LINUX_AMDGPU_SEM_H

#include <linux/types.h>
#include <linux/kref.h>
#include <linux/ktime.h>
#include <linux/list.h>
#include <linux/spinlock.h>
#include <linux/fence.h>

struct amdgpu_sem_core {
	struct file		*file;
	struct kref		kref;
	struct fence            *fence;
	struct mutex	lock;
};

struct amdgpu_sem {
	struct amdgpu_sem_core	*base;
	struct kref		kref;
	struct list_head        list;
};

#endif /* _LINUX_AMDGPU_SEM_H */

--------------050002060306040803050803
Content-Type: text/x-csrc; name="amdgpu_cs.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="amdgpu_cs.c"

/*
 * Copyright 2014 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <sys/ioctl.h>
#ifdef HAVE_ALLOCA_H
# include <alloca.h>
#endif

#include "xf86drm.h"
#include "amdgpu_drm.h"
#include "amdgpu_internal.h"

static int amdgpu_cs_unreference_sem(amdgpu_semaphore_handle sem);
static int amdgpu_cs_reset_sem(amdgpu_semaphore_handle sem);

/**
 * Create command submission context
 *
 * \param   dev - \c [in] amdgpu device handle
 * \param   context - \c [out] amdgpu context handle
 *
 * \return  0 on success otherwise POSIX Error code
*/
int amdgpu_cs_ctx_create(amdgpu_device_handle dev,
			 amdgpu_context_handle *context)
{
	struct amdgpu_context *gpu_context;
	union drm_amdgpu_ctx args;
	int i, j, k;
	int r;

	if (NULL == dev)
		return -EINVAL;
	if (NULL == context)
		return -EINVAL;

	gpu_context = calloc(1, sizeof(struct amdgpu_context));
	if (NULL == gpu_context)
		return -ENOMEM;

	gpu_context->dev = dev;

	r = pthread_mutex_init(&gpu_context->sequence_mutex, NULL);
	if (r)
		goto error;

	/* Create the context */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_CTX_OP_ALLOC_CTX;
	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_CTX, &args, sizeof(args));
	if (r)
		goto error;

	gpu_context->id = args.out.alloc.ctx_id;
	for (i = 0; i < AMDGPU_HW_IP_NUM; i++)
		for (j = 0; j < AMDGPU_HW_IP_INSTANCE_MAX_COUNT; j++)
			for (k = 0; k < AMDGPU_CS_MAX_RINGS; k++)
				list_inithead(&gpu_context->sem_list[i][j][k]);
	*context = (amdgpu_context_handle)gpu_context;

	return 0;

error:
	pthread_mutex_destroy(&gpu_context->sequence_mutex);
	free(gpu_context);
	return r;
}

/**
 * Release command submission context
 *
 * \param   dev - \c [in] amdgpu device handle
 * \param   context - \c [in] amdgpu context handle
 *
 * \return  0 on success otherwise POSIX Error code
*/
int amdgpu_cs_ctx_free(amdgpu_context_handle context)
{
	union drm_amdgpu_ctx args;
	int i, j, k;
	int r;

	if (NULL == context)
		return -EINVAL;

	pthread_mutex_destroy(&context->sequence_mutex);

	/* now deal with kernel side */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_CTX_OP_FREE_CTX;
	args.in.ctx_id = context->id;
	r = drmCommandWriteRead(context->dev->fd, DRM_AMDGPU_CTX,
				&args, sizeof(args));
	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
		for (j = 0; j < AMDGPU_HW_IP_INSTANCE_MAX_COUNT; j++) {
			for (k = 0; k < AMDGPU_CS_MAX_RINGS; k++) {
				amdgpu_semaphore_handle sem;
				LIST_FOR_EACH_ENTRY(sem, &context->sem_list[i][j][k], list) {
					list_del(&sem->list);
					amdgpu_cs_reset_sem(sem);
					amdgpu_cs_unreference_sem(sem);
				}
			}
		}
	}
	free(context);

	return r;
}

int amdgpu_cs_query_reset_state(amdgpu_context_handle context,
				uint32_t *state, uint32_t *hangs)
{
	union drm_amdgpu_ctx args;
	int r;

	if (!context)
		return -EINVAL;

	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_CTX_OP_QUERY_STATE;
	args.in.ctx_id = context->id;
	r = drmCommandWriteRead(context->dev->fd, DRM_AMDGPU_CTX,
				&args, sizeof(args));
	if (!r) {
		*state = args.out.state.reset_status;
		*hangs = args.out.state.hangs;
	}
	return r;
}

/**
 * Submit command to kernel DRM
 * \param   dev - \c [in]  Device handle
 * \param   context - \c [in]  GPU Context
 * \param   ibs_request - \c [in]  Pointer to submission requests
 * \param   fence - \c [out] return fence for this submission
 *
 * \return  0 on success otherwise POSIX Error code
 * \sa amdgpu_cs_submit()
*/
static int amdgpu_cs_submit_one(amdgpu_context_handle context,
				struct amdgpu_cs_request *ibs_request)
{
	union drm_amdgpu_cs cs;
	uint64_t *chunk_array;
	struct drm_amdgpu_cs_chunk *chunks;
	struct drm_amdgpu_cs_chunk_data *chunk_data;
	struct drm_amdgpu_cs_chunk_dep *dependencies = NULL;
	struct drm_amdgpu_cs_chunk_dep *sem_dependencies = NULL;
	struct list_head *sem_list;
	amdgpu_semaphore_handle sem, tmp;
	uint32_t i, size, sem_count = 0;
	bool user_fence;
	int r = 0;

	if (ibs_request->ip_type >= AMDGPU_HW_IP_NUM)
		return -EINVAL;
	if (ibs_request->ring >= AMDGPU_CS_MAX_RINGS)
		return -EINVAL;
	if (ibs_request->number_of_ibs > AMDGPU_CS_MAX_IBS_PER_SUBMIT)
		return -EINVAL;
	if (ibs_request->number_of_ibs == 0) {
		ibs_request->seq_no = AMDGPU_NULL_SUBMIT_SEQ;
		return 0;
	}
	user_fence = (ibs_request->fence_info.handle != NULL);

	size = ibs_request->number_of_ibs + (user_fence ? 2 : 1) + 1;

	chunk_array = alloca(sizeof(uint64_t) * size);
	chunks = alloca(sizeof(struct drm_amdgpu_cs_chunk) * size);

	size = ibs_request->number_of_ibs + (user_fence ? 1 : 0);

	chunk_data = alloca(sizeof(struct drm_amdgpu_cs_chunk_data) * size);

	memset(&cs, 0, sizeof(cs));
	cs.in.chunks = (uint64_t)(uintptr_t)chunk_array;
	cs.in.ctx_id = context->id;
	if (ibs_request->resources)
		cs.in.bo_list_handle = ibs_request->resources->handle;
	cs.in.num_chunks = ibs_request->number_of_ibs;
	/* IB chunks */
	for (i = 0; i < ibs_request->number_of_ibs; i++) {
		struct amdgpu_cs_ib_info *ib;
		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
		chunks[i].chunk_id = AMDGPU_CHUNK_ID_IB;
		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_ib) / 4;
		chunks[i].chunk_data = (uint64_t)(uintptr_t)&chunk_data[i];

		ib = &ibs_request->ibs[i];

		chunk_data[i].ib_data._pad = 0;
		chunk_data[i].ib_data.va_start = ib->ib_mc_address;
		chunk_data[i].ib_data.ib_bytes = ib->size * 4;
		chunk_data[i].ib_data.ip_type = ibs_request->ip_type;
		chunk_data[i].ib_data.ip_instance = ibs_request->ip_instance;
		chunk_data[i].ib_data.ring = ibs_request->ring;
		chunk_data[i].ib_data.flags = ib->flags;
	}

	pthread_mutex_lock(&context->sequence_mutex);

	if (user_fence) {
		i = cs.in.num_chunks++;

		/* fence chunk */
		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
		chunks[i].chunk_id = AMDGPU_CHUNK_ID_FENCE;
		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_fence) / 4;
		chunks[i].chunk_data = (uint64_t)(uintptr_t)&chunk_data[i];

		/* fence bo handle */
		chunk_data[i].fence_data.handle = ibs_request->fence_info.handle->handle;
		/* offset */
		chunk_data[i].fence_data.offset = 
			ibs_request->fence_info.offset * sizeof(uint64_t);
	}

	if (ibs_request->number_of_dependencies) {
		dependencies = malloc(sizeof(struct drm_amdgpu_cs_chunk_dep) *
			ibs_request->number_of_dependencies);
		if (!dependencies) {
			r = -ENOMEM;
			goto error_unlock;
		}

		for (i = 0; i < ibs_request->number_of_dependencies; ++i) {
			struct amdgpu_cs_fence *info = &ibs_request->dependencies[i];
			struct drm_amdgpu_cs_chunk_dep *dep = &dependencies[i];
			dep->ip_type = info->ip_type;
			dep->ip_instance = info->ip_instance;
			dep->ring = info->ring;
			dep->ctx_id = info->context->id;
			dep->handle = info->fence;
		}

		i = cs.in.num_chunks++;

		/* dependencies chunk */
		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
		chunks[i].chunk_id = AMDGPU_CHUNK_ID_DEPENDENCIES;
		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_dep) / 4
			* ibs_request->number_of_dependencies;
		chunks[i].chunk_data = (uint64_t)(uintptr_t)dependencies;
	}

	sem_list = &context->sem_list[ibs_request->ip_type][ibs_request->ip_instance][ibs_request->ring];
	LIST_FOR_EACH_ENTRY(sem, sem_list, list)
		sem_count++;
	if (sem_count) {
		sem_dependencies = malloc(sizeof(struct drm_amdgpu_cs_chunk_dep) * sem_count);
		if (!sem_dependencies) {
			r = -ENOMEM;
			goto error_unlock;
		}
		sem_count = 0;
		LIST_FOR_EACH_ENTRY_SAFE(sem, tmp, sem_list, list) {
			struct amdgpu_cs_fence *info = &sem->signal_fence;
			struct drm_amdgpu_cs_chunk_dep *dep = &sem_dependencies[sem_count++];
			dep->ip_type = info->ip_type;
			dep->ip_instance = info->ip_instance;
			dep->ring = info->ring;
			dep->ctx_id = info->context->id;
			dep->handle = info->fence;

			list_del(&sem->list);
			amdgpu_cs_reset_sem(sem);
			amdgpu_cs_unreference_sem(sem);
		}
		i = cs.in.num_chunks++;

		/* dependencies chunk */
		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
		chunks[i].chunk_id = AMDGPU_CHUNK_ID_DEPENDENCIES;
		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_dep) / 4 * sem_count;
		chunks[i].chunk_data = (uint64_t)(uintptr_t)sem_dependencies;
	}

	r = drmCommandWriteRead(context->dev->fd, DRM_AMDGPU_CS,
				&cs, sizeof(cs));
	if (r)
		goto error_unlock;

	ibs_request->seq_no = cs.out.handle;
	context->last_seq[ibs_request->ip_type][ibs_request->ip_instance][ibs_request->ring] = ibs_request->seq_no;
error_unlock:
	pthread_mutex_unlock(&context->sequence_mutex);
	free(dependencies);
	free(sem_dependencies);
	return r;
}

int amdgpu_cs_submit(amdgpu_context_handle context,
		     uint64_t flags,
		     struct amdgpu_cs_request *ibs_request,
		     uint32_t number_of_requests)
{
	uint32_t i;
	int r;

	if (NULL == context)
		return -EINVAL;
	if (NULL == ibs_request)
		return -EINVAL;

	r = 0;
	for (i = 0; i < number_of_requests; i++) {
		r = amdgpu_cs_submit_one(context, ibs_request);
		if (r)
			break;
		ibs_request++;
	}

	return r;
}

/**
 * Calculate absolute timeout.
 *
 * \param   timeout - \c [in] timeout in nanoseconds.
 *
 * \return  absolute timeout in nanoseconds
*/
drm_private uint64_t amdgpu_cs_calculate_timeout(uint64_t timeout)
{
	int r;

	if (timeout != AMDGPU_TIMEOUT_INFINITE) {
		struct timespec current;
		uint64_t current_ns;
		r = clock_gettime(CLOCK_MONOTONIC, &current);
		if (r) {
			fprintf(stderr, "clock_gettime() returned error (%d)!", errno);
			return AMDGPU_TIMEOUT_INFINITE;
		}

		current_ns = ((uint64_t)current.tv_sec) * 1000000000ull;
		current_ns += current.tv_nsec;
		timeout += current_ns;
		if (timeout < current_ns)
			timeout = AMDGPU_TIMEOUT_INFINITE;
	}
	return timeout;
}

static int amdgpu_ioctl_wait_cs(amdgpu_context_handle context,
				unsigned ip,
				unsigned ip_instance,
				uint32_t ring,
				uint64_t handle,
				uint64_t timeout_ns,
				uint64_t flags,
				bool *busy)
{
	amdgpu_device_handle dev = context->dev;
	union drm_amdgpu_wait_cs args;
	int r;

	memset(&args, 0, sizeof(args));
	args.in.handle = handle;
	args.in.ip_type = ip;
	args.in.ip_instance = ip_instance;
	args.in.ring = ring;
	args.in.ctx_id = context->id;

	if (flags & AMDGPU_QUERY_FENCE_TIMEOUT_IS_ABSOLUTE)
		args.in.timeout = timeout_ns;
	else
		args.in.timeout = amdgpu_cs_calculate_timeout(timeout_ns);

	r = drmIoctl(dev->fd, DRM_IOCTL_AMDGPU_WAIT_CS, &args);
	if (r)
		return -errno;

	*busy = args.out.status;
	return 0;
}

int amdgpu_cs_query_fence_status(struct amdgpu_cs_fence *fence,
				 uint64_t timeout_ns,
				 uint64_t flags,
				 uint32_t *expired)
{
	bool busy = true;
	int r;

	if (NULL == fence)
		return -EINVAL;
	if (NULL == expired)
		return -EINVAL;
	if (NULL == fence->context)
		return -EINVAL;
	if (fence->ip_type >= AMDGPU_HW_IP_NUM)
		return -EINVAL;
	if (fence->ring >= AMDGPU_CS_MAX_RINGS)
		return -EINVAL;
	if (fence->fence == AMDGPU_NULL_SUBMIT_SEQ) {
		*expired = true;
		return 0;
	}

	*expired = false;

	r = amdgpu_ioctl_wait_cs(fence->context, fence->ip_type,
				fence->ip_instance, fence->ring,
			       	fence->fence, timeout_ns, flags, &busy);

	if (!r && !busy)
		*expired = true;

	return r;
}

static int amdgpu_ioctl_wait_fences(struct amdgpu_cs_fence *fences,
				    uint32_t fence_count,
				    bool wait_all,
				    uint64_t timeout_ns,
				    uint32_t *status,
				    uint32_t *first)
{
	struct drm_amdgpu_fence *drm_fences;
	amdgpu_device_handle dev = fences[0].context->dev;
	union drm_amdgpu_wait_fences args;
	int r;
	uint32_t i;

	drm_fences = alloca(sizeof(struct drm_amdgpu_fence) * fence_count);
	for (i = 0; i < fence_count; i++) {
		drm_fences[i].ctx_id = fences[i].context->id;
		drm_fences[i].ip_type = fences[i].ip_type;
		drm_fences[i].ip_instance = fences[i].ip_instance;
		drm_fences[i].ring = fences[i].ring;
		drm_fences[i].seq_no = fences[i].fence;
	}

	memset(&args, 0, sizeof(args));
	args.in.fences = (uint64_t)(uintptr_t)drm_fences;
	args.in.fence_count = fence_count;
	args.in.wait_all = wait_all;
	args.in.timeout_ns = amdgpu_cs_calculate_timeout(timeout_ns);

	r = drmIoctl(dev->fd, DRM_IOCTL_AMDGPU_WAIT_FENCES, &args);
	if (r)
		return -errno;

	*status = args.out.status;

	if (first)
		*first = args.out.first_signaled;

	return 0;
}

int amdgpu_cs_wait_fences(struct amdgpu_cs_fence *fences,
			  uint32_t fence_count,
			  bool wait_all,
			  uint64_t timeout_ns,
			  uint32_t *status,
			  uint32_t *first)
{
	uint32_t ioctl_status = 0;
	uint32_t i;
	int r;

	/* Sanity check */
	if (NULL == fences)
		return -EINVAL;
	if (NULL == status)
		return -EINVAL;
	if (fence_count <= 0)
		return -EINVAL;
	for (i = 0; i < fence_count; i++) {
		if (NULL == fences[i].context)
			return -EINVAL;
		if (fences[i].ip_type >= AMDGPU_HW_IP_NUM)
			return -EINVAL;
		if (fences[i].ring >= AMDGPU_CS_MAX_RINGS)
			return -EINVAL;
	}

	*status = 0;

	r = amdgpu_ioctl_wait_fences(fences, fence_count, wait_all, timeout_ns,
					&ioctl_status, first);

	if (!r)
		*status = ioctl_status;

	return r;
}

int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
{
	struct amdgpu_semaphore *gpu_semaphore;

	if (NULL == sem)
		return -EINVAL;

	gpu_semaphore = calloc(1, sizeof(struct amdgpu_semaphore));
	if (NULL == gpu_semaphore)
		return -ENOMEM;

	atomic_set(&gpu_semaphore->refcount, 1);
	*sem = gpu_semaphore;

	return 0;
}

int amdgpu_cs_signal_semaphore(amdgpu_context_handle ctx,
			       uint32_t ip_type,
			       uint32_t ip_instance,
			       uint32_t ring,
			       amdgpu_semaphore_handle sem)
{
	if (NULL == ctx)
		return -EINVAL;
	if (ip_type >= AMDGPU_HW_IP_NUM)
		return -EINVAL;
	if (ring >= AMDGPU_CS_MAX_RINGS)
		return -EINVAL;
	if (NULL == sem)
		return -EINVAL;
	/* sem has been signaled */
	if (sem->signal_fence.context)
		return -EINVAL;
	pthread_mutex_lock(&ctx->sequence_mutex);
	sem->signal_fence.context = ctx;
	sem->signal_fence.ip_type = ip_type;
	sem->signal_fence.ip_instance = ip_instance;
	sem->signal_fence.ring = ring;
	sem->signal_fence.fence = ctx->last_seq[ip_type][ip_instance][ring];
	update_references(NULL, &sem->refcount);
	pthread_mutex_unlock(&ctx->sequence_mutex);
	return 0;
}

int amdgpu_cs_wait_semaphore(amdgpu_context_handle ctx,
			     uint32_t ip_type,
			     uint32_t ip_instance,
			     uint32_t ring,
			     amdgpu_semaphore_handle sem)
{
	if (NULL == ctx)
		return -EINVAL;
	if (ip_type >= AMDGPU_HW_IP_NUM)
		return -EINVAL;
	if (ring >= AMDGPU_CS_MAX_RINGS)
		return -EINVAL;
	if (NULL == sem)
		return -EINVAL;
	/* must signal first */
	if (NULL == sem->signal_fence.context)
		return -EINVAL;

	pthread_mutex_lock(&ctx->sequence_mutex);
	list_add(&sem->list, &ctx->sem_list[ip_type][ip_instance][ring]);
	pthread_mutex_unlock(&ctx->sequence_mutex);
	return 0;
}

static int amdgpu_cs_reset_sem(amdgpu_semaphore_handle sem)
{
	if (NULL == sem)
		return -EINVAL;
	if (NULL == sem->signal_fence.context)
		return -EINVAL;

	sem->signal_fence.context = NULL;;
	sem->signal_fence.ip_type = 0;
	sem->signal_fence.ip_instance = 0;
	sem->signal_fence.ring = 0;
	sem->signal_fence.fence = 0;

	return 0;
}

static int amdgpu_cs_unreference_sem(amdgpu_semaphore_handle sem)
{
	if (NULL == sem)
		return -EINVAL;

	if (update_references(&sem->refcount, NULL))
		free(sem);
	return 0;
}

int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem)
{
	return amdgpu_cs_unreference_sem(sem);
}

int amdgpu_cs_create_sem(amdgpu_device_handle dev,
			 amdgpu_sem_handle *sem)
{
	union drm_amdgpu_sem args;
	int r;

	if (NULL == dev)
		return -EINVAL;

	/* Create the context */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_SEM_OP_CREATE_SEM;
	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
	if (r)
		return r;

	*sem = args.out.handle;

	return 0;
}

int amdgpu_cs_signal_sem(amdgpu_device_handle dev,
			 amdgpu_context_handle ctx,
			 uint32_t ip_type,
			 uint32_t ip_instance,
			 uint32_t ring,
			 amdgpu_sem_handle sem)
{
	union drm_amdgpu_sem args;

	if (NULL == dev)
		return -EINVAL;

	/* Create the context */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_SEM_OP_SIGNAL_SEM;
	args.in.ctx_id = ctx->id;
	args.in.ip_type = ip_type;
	args.in.ip_instance = ip_instance;
	args.in.ring = ring;
	args.in.handle = sem;
	return drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
}

int amdgpu_cs_wait_sem(amdgpu_device_handle dev,
		       amdgpu_context_handle ctx,
		       uint32_t ip_type,
		       uint32_t ip_instance,
		       uint32_t ring,
		       amdgpu_sem_handle sem)
{
	union drm_amdgpu_sem args;

	if (NULL == dev)
		return -EINVAL;

	/* Create the context */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_SEM_OP_WAIT_SEM;
	args.in.ctx_id = ctx->id;
	args.in.ip_type = ip_type;
	args.in.ip_instance = ip_instance;
	args.in.ring = ring;
	args.in.handle = sem;
	args.in.seq = 0;
	return drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
}

int amdgpu_cs_export_sem(amdgpu_device_handle dev,
			  amdgpu_sem_handle sem,
			  int *shared_handle)
{
	union drm_amdgpu_sem args;
	int r;

	if (NULL == dev)
		return -EINVAL;

	/* Create the context */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_SEM_OP_EXPORT_SEM;
	args.in.handle = sem;
	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
	if (r)
		return r;
	*shared_handle = args.out.fd;
	return 0;
}

int amdgpu_cs_import_sem(amdgpu_device_handle dev,
			  int shared_handle,
			  amdgpu_sem_handle *sem)
{
	union drm_amdgpu_sem args;
	int r;

	if (NULL == dev)
		return -EINVAL;

	/* Create the context */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_SEM_OP_IMPORT_SEM;
	args.in.handle = shared_handle;
	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
	if (r)
		return r;
	*sem = args.out.handle;
	return 0;
}


int amdgpu_cs_destroy_sem(amdgpu_device_handle dev,
			  amdgpu_sem_handle sem)
{
	union drm_amdgpu_sem args;
	int r;

	if (NULL == dev)
		return -EINVAL;

	/* Create the context */
	memset(&args, 0, sizeof(args));
	args.in.op = AMDGPU_SEM_OP_DESTROY_SEM;
	args.in.handle = sem;
	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
	if (r)
		return r;

	return 0;
}

--------------050002060306040803050803
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------050002060306040803050803--
